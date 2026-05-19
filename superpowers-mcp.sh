#!/bin/bash
# Superpowers MCP Client Helper
# Usage:
#   ./superpowers-mcp.sh list                              - List all skills
#   ./superpowers-mcp.sh use <skill-name>                  - Load a skill
#   ./superpowers-mcp.sh recommend <task-description>      - Get skill recommendations
#   ./superpowers-mcp.sh workflow <goal>                   - Compose a multi-skill workflow
#   ./superpowers-mcp.sh search <query>                    - Semantic search across skills
#   ./superpowers-mcp.sh file <skill> <filename>           - Get a supporting file

export SUPERPOWERS_SKILLS_DIR="/home/user/superpowers-skills/skills"
MCP_SERVER="node /home/user/superpowers-mcp/build/index.js"

call_mcp() {
  local tool_call="$1"
  echo "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"initialize\",\"params\":{\"protocolVersion\":\"2024-11-05\",\"capabilities\":{},\"clientInfo\":{\"name\":\"arena\",\"version\":\"1.0.0\"}}}
{\"jsonrpc\":\"2.0\",\"method\":\"notifications/initialized\",\"params\":{}}
$tool_call" | $MCP_SERVER 2>/dev/null | tail -1
}

case "$1" in
  list)
    echo "⚡ Available Superpowers Skills:"
    echo "================================"
    call_mcp '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"list_skills","arguments":{}}}' | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
skills = json.loads(data['result']['content'][0]['text'])
for s in skills:
    files = ', '.join(s.get('files', [])) if s.get('files') else 'none'
    print(f\"  ⚡ {s['name']}\")
    print(f\"    {s['description'][:120]}\")
    print(f\"    Files: {files}\")
    print()
"
    ;;
  use)
    SKILL_NAME="$2"
    echo "📖 Loading skill: $SKILL_NAME"
    echo "================================"
    call_mcp "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"use_skill\",\"arguments\":{\"name\":\"$SKILL_NAME\"}}}" | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['result']['content'][0]['text'])
"
    ;;
  recommend)
    TASK="$2"
    echo "🎯 Recommending skills for: $TASK"
    echo "================================"
    call_mcp "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"recommend_skills\",\"arguments\":{\"task\":\"$TASK\"}}}" | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['result']['content'][0]['text'])
" | python3 -m json.tool 2>/dev/null
    ;;
  workflow)
    GOAL="$2"
    echo "🔄 Composing workflow for: $GOAL"
    echo "================================"
    call_mcp "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"compose_workflow\",\"arguments\":{\"goal\":\"$GOAL\"}}}" | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['result']['content'][0]['text'])
" | python3 -m json.tool 2>/dev/null
    ;;
  search)
    QUERY="$2"
    echo "🔍 Searching skills for: $QUERY"
    echo "================================"
    call_mcp "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"semantic_search_skills\",\"arguments\":{\"query\":\"$QUERY\"}}}" | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['result']['content'][0]['text'])
" | python3 -m json.tool 2>/dev/null
    ;;
  file)
    SKILL="$2"
    FILE="$3"
    echo "📄 Loading file: $FILE from skill: $SKILL"
    echo "================================"
    call_mcp "{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"tools/call\",\"params\":{\"name\":\"get_skill_file\",\"arguments\":{\"skill\":\"$SKILL\",\"file\":\"$FILE\"}}}" | \
      python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data['result']['content'][0]['text'])
"
    ;;
  *)
    echo "Superpowers MCP Helper"
    echo "Usage:"
    echo "  $0 list                         - List all skills"
    echo "  $0 use <skill-name>             - Load a skill"
    echo "  $0 recommend <task>             - Get skill recommendations"
    echo "  $0 workflow <goal>              - Compose a workflow"
    echo "  $0 search <query>              - Semantic search"
    echo "  $0 file <skill> <filename>      - Get a supporting file"
    ;;
esac
