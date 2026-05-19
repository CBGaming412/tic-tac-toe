# 🎮 Tic Tac Toe — Evidence-Based Edition

A beautifully crafted Tic Tac Toe game where **every design decision is backed by research**. Built with vanilla HTML, CSS, and JavaScript — no frameworks, no dependencies.

![Game Preview](https://img.shields.io/badge/Play-Open%20tic--tac--toe.html-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Tests](https://img.shields.io/badge/Self--Tests-12%2F12%20Passing-brightgreen?style=flat-square)
![Citations](https://img.shields.io/badge/Research%20Citations-15-purple?style=flat-square)

---

## ✨ Features

| Feature | Details |
|---------|---------|
| 🤖 **AI Opponent** | Minimax algorithm with alpha-beta pruning — 4 difficulty levels |
| 👥 **Local Multiplayer** | Play vs a friend on the same device |
| ♿ **Fully Accessible** | WCAG 2.1 AA compliant — keyboard navigation, ARIA labels, screen reader support |
| 🎨 **Polished UI** | Smooth animations, color-coded players, responsive design |
| 🧪 **Self-Testing** | 12 automated tests run on load (check browser console) |
| 📚 **Evidence-Based** | 15 research citations — every design choice is justified |
| 🎉 **Celebrations** | Confetti on wins, pulsing win line, board shake effects |
| 📱 **Responsive** | Works on desktop, tablet, and mobile |

---

## 🚀 Quick Start

1. **Clone the repo**
   ```bash
   git clone https://github.com/CBGaming412/tic-tac-toe.git
   cd tic-tac-toe
   ```

2. **Open the game**
   ```bash
   open tic-tac-toe.html
   # or just double-click the file in your file explorer
   ```

That's it. No build step. No `npm install`. Just open and play.

---

## 🎮 How to Play

| Control | Action |
|---------|--------|
| **Click / Tap** | Place your mark on a cell |
| **Arrow Keys** | Navigate between cells |
| **Enter / Space** | Place mark on focused cell |
| **Mode Selector** | Switch between vs AI and vs Player |
| **AI Difficulty** | Easy → Medium → Hard → Impossible |
| **↻ New Game** | Reset the board (scores persist) |

### AI Difficulty Levels

| Level | Behavior |
|-------|----------|
| **Easy** | 30% optimal, 70% random moves |
| **Medium** | 70% optimal, 30% random moves |
| **Hard** | 90% optimal, 10% random moves |
| **Impossible** | 100% optimal — you literally cannot win (only draw) |

> 💡 **Fun fact:** On Impossible difficulty, the AI plays with perfect minimax strategy. Per Nash equilibrium theory [E15], two perfect players will always draw in Tic Tac Toe.

---

## 🧠 The AI Engine

The AI uses the **Minimax algorithm** with **Alpha-Beta Pruning**:

```
Minimax: Evaluate every possible future game state
         and pick the move that leads to the best
         worst-case outcome.

Alpha-Beta: Skip branches that can't possibly affect
            the final decision — reduces search from
            O(b^d) to O(b^(d/2)).
```

### How it works:

```
Current Board          AI Evaluates All Futures
                       
 X | O |              Move 3 → Win in 2 turns ✓ (score: +8)
-----------            Move 5 → Draw in 4 turns  (score: 0)
   | X |              Move 7 → Lose in 3 turns   (score: -7)
-----------            
   |   | O            AI picks: Move 3 (highest score)
```

The AI prefers:
- **Faster wins** (win in 2 turns > win in 4 turns)
- **Slower losses** (lose in 5 turns > lose in 2 turns)
- **Draws over losses**

---

## 📚 Evidence Base — 15 Research Citations

Every design choice in this game is backed by published research. Click the **"📚 View Evidence Base"** button in-game to see all citations, or read them here:

### Algorithm & Game Theory

| ID | Citation | Application |
|----|----------|-------------|
| E1 | Shannon, C.E. (1950). "Programming a Computer for Playing Chess." *Philosophical Magazine.* | Minimax algorithm — AI opponent core |
| E2 | Knuth, D.E. & Moore, R.W. (1975). "An Analysis of Alpha-Beta Pruning." *Artificial Intelligence, 6(4).* | Efficient search tree pruning |
| E15 | Nash, J.F. (1950). "Equilibrium Points in N-Person Games." | Perfect play always results in a draw |

### Human-Computer Interaction (HCI)

| ID | Citation | Application |
|----|----------|-------------|
| E3 | Fitts, P.M. (1954). "The Information Capacity of the Human Motor System." *J. of Exp. Psychology.* | Large 110px+ touch targets for fast interaction |
| E5 | Hick, W.E. (1952). "On the Rate of Gain of Information." *Quarterly J. of Exp. Psychology.* | Max 9 cells + clear turn indicator reduces decision time |
| E9 | Card, S.K. et al. (1991). "The Model Human Processor." *Handbook of HCI.* | Feedback under 100ms feels instant |

### Cognitive Psychology

| ID | Citation | Application |
|----|----------|-------------|
| E4 | Miller, G.A. (1956). "The Magical Number Seven, Plus or Minus Two." *Psychological Review.* | Scoreboard limited to 3 data points |
| E11 | Zeigarnik, B. (1927). "On Finished and Unfinished Tasks." | Clear win/draw resolution with prominent restart |
| E12 | Paivio, A. (1971). *Imagery and Verbal Processes.* | Icon + text dual encoding in status bar |

### Perception & Design

| ID | Citation | Application |
|----|----------|-------------|
| E7 | Wertheimer, M. (1923). Gestalt Laws of Grouping. | Grid lines create cell grouping; spacing separates sections |
| E8 | Elliot, A.J. & Maier, M.A. (2014). "Color Psychology." *Annual Review of Psychology.* | Blue (X) = trust/calm; Red (O) = energy/urgency |
| E13 | Von Restorff, H. (1933). "Isolation Effect." | Winning line highlighted in green, distinct from normal marks |
| E14 | Weber, E.H. (1834) / Fechner, G.T. (1860). Weber-Fechner Law. | Animation easing follows natural perceptual curves |

### Accessibility & UX

| ID | Citation | Application |
|----|----------|-------------|
| E6 | W3C (2018). WCAG 2.1 Level AA. | 4.5:1+ contrast, keyboard nav, ARIA labels, reduced-motion |
| E10 | Nielsen, J. (2006). "Progressive Disclosure." *Nielsen Norman Group.* | AI difficulty hidden when in PvP mode |

---

## 🧪 Self-Tests

The game runs **12 automated tests** on every page load. Open your browser console (`F12`) to see:

```
✅ Empty board → no winner
✅ X wins top row
✅ O wins diagonal
✅ Draw detected correctly
✅ makeMove creates new state
✅ Cannot move to taken cell
✅ Minimax finds O winning move
✅ Minimax blocks X win
✅ All 8 win lines detected
✅ Game over on win
✅ [E15] Nash equilibrium: perfect play → draw
✅ Alpha-beta pruning produces same result as plain minimax

🧪 Self-Tests: 12/12 passed
✨ All evidence-based tests VERIFIED
```

### WCAG Contrast Verification

All color combinations verified against the dark background (`#0f172a`):

| Element | Color | Contrast Ratio | Status |
|---------|-------|----------------|--------|
| X marks | `#3b82f6` | 4.85:1 | ✅ AA |
| O marks | `#ef4444` | 4.74:1 | ✅ AA |
| Primary text | `#f1f5f9` | 16.30:1 | ✅ AAA |
| Win highlight | `#22c55e` | 7.83:1 | ✅ AAA |
| Draw indicator | `#eab308` | 9.31:1 | ✅ AAA |

---

## 🏗️ Project Structure

```
tic-tac-toe/
├── tic-tac-toe.html      # The complete game (single file, zero dependencies)
├── context7-mcp.sh        # Context7 MCP client helper script
├── superpowers-mcp.sh     # Superpowers MCP client helper script
└── README.md              # This file
```

---

## 🛠️ Built With

| Tool | Purpose |
|------|---------|
| **Vanilla HTML/CSS/JS** | Zero dependencies, instant load |
| **[Context7 MCP](https://context7.com)** | Fetched up-to-date MDN docs for CSS animations, ARIA patterns |
| **[Superpowers MCP](https://github.com/erophames/superpowers-mcp)** | Guided workflow: brainstorming → planning → TDD → verification |
| **Minimax + Alpha-Beta** | Optimal AI opponent |
| **CSS Animations** | `@keyframes`, transitions, cubic-bezier easing |
| **SVG** | Crisp, scalable X and O marks |

---

## 📄 License

MIT License — do whatever you want with it.

---

<p align="center">
  Made with 🧠 evidence and ❤️ fun<br>
  <em>Every pixel has a reason.</em>
</p>
