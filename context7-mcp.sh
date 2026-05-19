#!/bin/bash
# Context7 MCP Client Helper
# Usage:
#   ./context7-mcp.sh resolve <library_name> <query>
#   ./context7-mcp.sh docs <library_id> <query>
#   ./context7-mcp.sh search <library_name> <query>   (resolve + docs in one shot)

MCP_URL="http://localhost:3007/mcp"
HEADERS='-H "Content-Type: application/json" -H "Accept: application/json, text/event-stream"'

call_mcp() {
  local payload="$1"
  curl -s -X POST "$MCP_URL" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json, text/event-stream" \
    -d "$payload" 2>/dev/null | grep "^data:" | sed 's/^data: //'
}

case "$1" in
  resolve)
    LIBRARY_NAME="$2"
    QUERY="$3"
    echo "🔍 Resolving library: $LIBRARY_NAME"
    call_mcp "{
      \"jsonrpc\": \"2.0\",
      \"id\": 10,
      \"method\": \"tools/call\",
      \"params\": {
        \"name\": \"resolve-library-id\",
        \"arguments\": {
          \"libraryName\": \"$LIBRARY_NAME\",
          \"query\": \"$QUERY\"
        }
      }
    }"
    ;;
  docs)
    LIBRARY_ID="$2"
    QUERY="$3"
    echo "📖 Fetching docs for: $LIBRARY_ID"
    call_mcp "{
      \"jsonrpc\": \"2.0\",
      \"id\": 11,
      \"method\": \"tools/call\",
      \"params\": {
        \"name\": \"query-docs\",
        \"arguments\": {
          \"libraryId\": \"$LIBRARY_ID\",
          \"query\": \"$QUERY\"
        }
      }
    }"
    ;;
  search)
    LIBRARY_NAME="$2"
    QUERY="$3"
    echo "🔍 Resolving library: $LIBRARY_NAME ..."
    RESULT=$(call_mcp "{
      \"jsonrpc\": \"2.0\",
      \"id\": 10,
      \"method\": \"tools/call\",
      \"params\": {
        \"name\": \"resolve-library-id\",
        \"arguments\": {
          \"libraryName\": \"$LIBRARY_NAME\",
          \"query\": \"$QUERY\"
        }
      }
    }")
    echo "$RESULT" | python3 -m json.tool 2>/dev/null || echo "$RESULT"
    # Extract first library ID
    LIB_ID=$(echo "$RESULT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
text = data['result']['content'][0]['text']
# Find first /org/project pattern
import re
match = re.search(r'(/[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+)', text)
if match:
    print(match.group(1))
" 2>/dev/null)
    if [ -n "$LIB_ID" ]; then
      echo ""
      echo "📖 Fetching docs for: $LIB_ID ..."
      call_mcp "{
        \"jsonrpc\": \"2.0\",
        \"id\": 11,
        \"method\": \"tools/call\",
        \"params\": {
          \"name\": \"query-docs\",
          \"arguments\": {
            \"libraryId\": \"$LIB_ID\",
            \"query\": \"$QUERY\"
          }
        }
      }" | python3 -m json.tool 2>/dev/null
    else
      echo "❌ Could not extract library ID"
    fi
    ;;
  *)
    echo "Usage:"
    echo "  $0 resolve <library_name> <query>"
    echo "  $0 docs <library_id> <query>"
    echo "  $0 search <library_name> <query>"
    ;;
esac
