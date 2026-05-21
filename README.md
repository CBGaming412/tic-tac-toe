<p align="center">
  <br>
  <strong style="font-size: 2rem;">🎮 Tic Tac Toe</strong>
  <br>
  <em>Evidence-Based Game Design Edition</em>
  <br><br>
  <a href="https://cb-tic-tac-toe.netlify.app/">
    <img src="https://img.shields.io/badge/▶%20PLAY%20NOW-cb--tic--tac--toe.netlify.app-3b82f6?style=for-the-badge&logoColor=white" alt="Play Now">
  </a>
  <br><br>
  <img src="https://img.shields.io/badge/Self--Tests-12%2F12%20Passing-22c55e?style=flat-square" alt="Tests">
  <img src="https://img.shields.io/badge/Research%20Citations-15-a855f7?style=flat-square" alt="Citations">
  <img src="https://img.shields.io/badge/WCAG-AA%20Compliant-3b82f6?style=flat-square" alt="WCAG">
  <img src="https://img.shields.io/badge/Dependencies-Zero-eab308?style=flat-square" alt="Dependencies">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License">
  <img src="https://img.shields.io/netlify/edfac4?style=flat-square&label=Netlify" alt="Netlify Status">
</p>

---

A Tic Tac Toe game where **every single design decision is backed by peer-reviewed research**. Not a single color, animation curve, layout choice, or algorithm was arbitrary — each one traces to a published finding in HCI, cognitive psychology, game theory, perception science, or accessibility standards.

**Zero dependencies. Single file. Open and play.**

---

## Table of Contents

- [Play](#-play)
- [Why "Evidence-Based"?](#-why-evidence-based)
- [Features](#-features)
- [The AI Engine](#-the-ai-engine)
- [Evidence Base — 15 Research Citations](#-evidence-base--15-research-citations)
- [Accessibility Compliance](#-accessibility-compliance)
- [Self-Test Suite](#-self-test-suite)
- [Architecture](#-architecture)
- [Development Methodology](#-development-methodology)
- [Local Development](#-local-development)
- [Project Structure](#-project-structure)
- [License](#-license)

---

## ▶ Play

**Live:** [cb-tic-tac-toe.netlify.app](https://cb-tic-tac-toe.netlify.app/)

Or run locally — no build step, no install:

```bash
git clone https://github.com/CBGaming412/tic-tac-toe.git
open tic-tac-toe.html
```

---

## 🧠 Why "Evidence-Based"?

Most games make design choices by intuition or copying trends. This project takes a different approach: **every decision maps to a specific research finding.**

| Typical Game | This Game |
|---|---|
| "Blue looks nice" | Blue evokes trust & calm — Elliot & Maier (2014), *Annual Review of Psychology* **[E8]** |
| "Let's make big buttons" | Fitts's Law (1954): larger targets = faster, more accurate interaction **[E3]** |
| "Add some animation" | Weber-Fechner Law: easing curves follow human perceptual thresholds **[E14]** |
| "The AI should be smart" | Minimax algorithm — Shannon (1950), guaranteed optimal play **[E1]** |
| "Show the score" | Miller's Law (1956): limit to 7±2 items — we show only 3 **[E4]** |
| "Highlight the winner" | Von Restorff Effect (1933): isolated items are remembered better **[E13]** |

The game includes an in-app **"📚 View Evidence Base"** button that displays all 15 citations with their categories and applications.

---

## ✨ Features

### Gameplay
- **🤖 AI Opponent** — Minimax with alpha-beta pruning across 4 difficulty levels
- **🎯 First-Move Choice** — Choose whether you or the AI moves first (AI mode)
- **👥 Local Multiplayer** — Play vs a friend on the same device with optional custom player names
- **📊 Persistent Scoreboard** — Scores survive page refreshes via `localStorage`
- **↩️ Undo Move** — Take back your last move (in AI mode, undoes both your move and the AI's response)
- **🔄 Reset Scores** — Clear all scores with a confirmation prompt

### Design & UX
- **🎨 Research-Driven UI** — Every color, size, spacing, and animation backed by evidence
- **🎉 Celebration Effects** — Confetti burst on wins, pulsing win line, board shake
- **👻 Ghost Previews** — Hovering a cell shows a faded preview of your mark
- **💬 Dual-Coded Status** — Icon + text status bar per Paivio's dual-coding theory [E12]
- **📱 Fully Responsive** — Desktop, tablet, and mobile

### Accessibility
- **♿ WCAG 2.1 AA** — Verified contrast ratios, semantic HTML, ARIA labels
- **⌨️ Full Keyboard Navigation** — Arrow keys to move, Enter/Space to place
- **🔇 Reduced Motion** — Respects `prefers-reduced-motion` for vestibular disorders

### Quality
- **🧪 12 Self-Tests** — Run automatically on every page load (check browser console)
- **📚 15 Citations** — In-app evidence panel with categorized research references
- **0️⃣ Zero Dependencies** — Single HTML file, no frameworks, no build step

---

## 🤖 The AI Engine

### Algorithm: Minimax with Alpha-Beta Pruning

The AI evaluates every possible future game state to find the mathematically optimal move.

```
                        Current Board State
                       /        |        \
                   Move A    Move B    Move C
                   /    \      |       /    \
                ...    ...   ...    ...    ...
                 ↓      ↓     ↓      ↓      ↓
              Win(+8) Draw(0) Lose(-7) Win(+6) Draw(0)

    AI picks: Move A → fastest path to a win (score +8)
```

**Core principle** — Shannon, C.E. (1950) **[E1]:**
> Evaluate the game tree exhaustively; at each node, the maximizing player picks the highest-scored child and the minimizing player picks the lowest.

**Optimization** — Knuth & Moore (1975) **[E2]:**
> Alpha-beta pruning skips branches that cannot affect the final decision, reducing search complexity from O(b<sup>d</sup>) to O(b<sup>d/2</sup>).

### Difficulty Levels

| Level | Strategy | Win Rate vs. Optimal |
|-------|----------|----------------------|
| **Easy** | 30% minimax, 70% random | Player wins most games |
| **Medium** | 70% minimax, 30% random | Competitive — player can win with effort |
| **Hard** | 90% minimax, 10% random | Very tough — rare mistakes |
| **Impossible** | 100% minimax | **Unbeatable** — best possible outcome is a draw |

**Nash Equilibrium [E15]:** With perfect play from both sides, Tic Tac Toe always ends in a draw. The Impossible AI demonstrates this — you can verify it yourself, or check the self-test suite which proves it programmatically.

### First-Move Control

Choose who goes first in AI mode:
- **You (X)** — You play as X and make the opening move
- **AI (X)** — The AI plays as X and moves first automatically

The AI adapts its minimax strategy regardless of which symbol it plays.

### AI Move Preferences

The scoring function includes **depth-awareness:**

```
Faster wins score higher:    Win in 2 moves (+8) > Win in 4 moves (+6)
Slower losses score higher:  Lose in 5 moves (-5) > Lose in 2 moves (-8)
```

This means the AI won't just win — it wins as fast as possible and delays losses as long as possible.

---

## 👥 Versus Player Mode

Play against a friend on the same device with these extras:

- **Custom Player Names** — Optional name fields for each player (e.g., "Alice" and "Bob")
- **Personalized UI** — Names appear in the status bar ("Alice's turn") and scoreboard ("Alice (X) Wins")
- **Ephemeral Names** — Names reset on page refresh or when switching to AI mode, keeping the scoreboard persistent
- **Single-Step Undo** — Undo just the last move (both players' moves in AI mode)

---

## 📚 Evidence Base — 15 Research Citations

Every design decision traces to published research. Citations are categorized by domain and tagged with the specific UI element they informed.

### 🔢 Algorithm & Game Theory

| ID | Citation | Year | What It Informed |
|----|----------|------|------------------|
| **E1** | Shannon, C.E. "Programming a Computer for Playing Chess." *Philosophical Magazine.* | 1950 | Minimax algorithm — the AI opponent's decision-making core |
| **E2** | Knuth, D.E. & Moore, R.W. "An Analysis of Alpha-Beta Pruning." *Artificial Intelligence, 6(4), 293–326.* | 1975 | Search tree optimization — reduces computation by ~square root |
| **E15** | Nash, J.F. "Equilibrium Points in N-Person Games." *Proceedings of the National Academy of Sciences, 36(1), 48–49.* | 1950 | Game-theoretic proof that optimal play guarantees a draw |

### 🖱️ Human-Computer Interaction

| ID | Citation | Year | What It Informed |
|----|----------|------|------------------|
| **E3** | Fitts, P.M. "The Information Capacity of the Human Motor System in Controlling the Amplitude of Movement." *Journal of Experimental Psychology, 47(6), 381–391.* | 1954 | Cell size: 110px+ touch targets for fast, accurate tapping |
| **E5** | Hick, W.E. "On the Rate of Gain of Information." *Quarterly Journal of Experimental Psychology, 4(1), 11–26.* | 1952 | Decision complexity: max 9 cells + clear turn indicator |
| **E9** | Card, S.K., Moran, T.P. & Newell, A. "The Model Human Processor." *Handbook of Human-Computer Interaction.* | 1991 | Feedback timing: all responses < 100ms perceived as instant |

### 🧠 Cognitive Psychology

| ID | Citation | Year | What It Informed |
|----|----------|------|------------------|
| **E4** | Miller, G.A. "The Magical Number Seven, Plus or Minus Two." *Psychological Review, 63(2), 81–97.* | 1956 | Working memory limits: scoreboard shows only 3 data points |
| **E11** | Zeigarnik, B. "On Finished and Unfinished Tasks." *Psychologische Forschung, 9, 1–85.* | 1927 | Incomplete task tension: clear win/draw states + prominent restart |
| **E12** | Paivio, A. *Imagery and Verbal Processes.* New York: Holt, Rinehart, and Winston. | 1971 | Dual-coding: status bar encodes info as both icon and text |

### 👁️ Perception & Visual Design

| ID | Citation | Year | What It Informed |
|----|----------|------|------------------|
| **E7** | Wertheimer, M. "Untersuchungen zur Lehre von der Gestalt II." *Psychologische Forschung, 4(1), 301–350.* | 1923 | Gestalt proximity: grid lines group cells; spacing separates sections |
| **E8** | Elliot, A.J. & Maier, M.A. "Color Psychology: Effects of Perceiving Color on Psychological Functioning in Humans." *Annual Review of Psychology, 65, 95–120.* | 2014 | Color semantics: Blue (X) = trust/calm, Red (O) = energy/urgency |
| **E13** | Von Restorff, H. "Über die Wirkung von Bereichsbildungen im Spurenfeld." *Psychologische Forschung, 18(1), 299–342.* | 1933 | Isolation effect: winning line highlighted in green, visually distinct |
| **E14** | Weber, E.H. (1834) *De Tactu*; Fechner, G.T. (1860) *Elemente der Psychophysik.* | 1834 / 1860 | Perceptual scaling: animation easing curves follow natural sensation curves |

### ♿ Accessibility & UX

| ID | Citation | Year | What It Informed |
|----|----------|------|------------------|
| **E6** | W3C. "Web Content Accessibility Guidelines (WCAG) 2.1." Level AA. | 2018 | Contrast ≥ 4.5:1, keyboard navigation, ARIA roles, `prefers-reduced-motion` |
| **E10** | Nielsen, J. "Progressive Disclosure." *Nielsen Norman Group.* | 2006 | Complexity management: AI difficulty and first-move selectors hidden in PvP mode |

---

## ♿ Accessibility Compliance

This game meets **WCAG 2.1 Level AA** requirements **[E6]**, verified programmatically:

### Contrast Ratios (vs. background `#0f172a`)

| Element | Hex | Ratio | Requirement | Status |
|---------|-----|-------|-------------|--------|
| X marks | `#3b82f6` | **4.85:1** | ≥ 4.5:1 (AA) | ✅ Pass |
| O marks | `#ef4444` | **4.74:1** | ≥ 4.5:1 (AA) | ✅ Pass |
| Primary text | `#f1f5f9` | **16.30:1** | ≥ 4.5:1 (AA) | ✅ Pass (AAA) |
| Win highlight | `#22c55e` | **7.83:1** | ≥ 4.5:1 (AA) | ✅ Pass (AAA) |
| Draw indicator | `#eab308` | **9.31:1** | ≥ 4.5:1 (AA) | ✅ Pass (AAA) |

### Keyboard Navigation

| Key | Action |
|-----|--------|
| `Tab` | Focus the game board |
| `Arrow Keys` | Navigate between cells |
| `Enter` / `Space` | Place your mark |
| `Tab` | Cycle through controls |

### Other Accessibility Features

- **ARIA labels** on all interactive elements (`role="grid"`, `role="gridcell"`, `aria-live="polite"`)
- **Screen reader announcements** for turn changes, wins, and draws via `aria-live` regions
- **`prefers-reduced-motion`** media query disables all animations for users with vestibular disorders
- **Focus indicators** — visible `:focus-visible` outlines on all interactive elements
- **Semantic HTML** — proper `<button>`, `<select>`, `<label>` elements throughout

---

## 🧪 Self-Test Suite

The game runs **12 automated tests** on every page load. Open your browser console (`F12` → Console) to see results:

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
[E1] Minimax ✓  [E2] Alpha-beta ✓  [E15] Nash equilibrium ✓
```

### What Each Test Verifies

| # | Test | Evidence Link | What It Proves |
|---|------|---------------|----------------|
| 1 | Empty board → no winner | Core logic | No false positives on empty state |
| 2 | X wins top row | Core logic | Horizontal win detection |
| 3 | O wins diagonal | Core logic | Diagonal win detection |
| 4 | Draw detection | Core logic | Full board with no winner = draw |
| 5 | makeMove creates new state | Immutability | State transitions don't mutate |
| 6 | Cannot move to taken cell | Input validation | Prevents illegal moves |
| 7 | Minimax finds winning move | **[E1]** Shannon | AI exploits winning opportunities |
| 8 | Minimax blocks opponent | **[E1]** Shannon | AI prevents opponent wins |
| 9 | All 8 win lines detected | Core logic | Complete coverage of win conditions |
| 10 | Game over on win | State machine | Terminal state transitions correctly |
| 11 | Nash equilibrium → draw | **[E15]** Nash | Perfect play from both sides = draw |
| 12 | Alpha-beta = plain minimax | **[E2]** Knuth & Moore | Pruning doesn't change correctness |

---

## 🏛️ Architecture

The game is a **single HTML file** with embedded CSS and JavaScript, structured into clearly separated concerns:

```
┌─────────────────────────────────────────┐
│              tic-tac-toe.html           │
├─────────────────────────────────────────┤
│  CSS Layer                              │
│  ├── Design system (custom properties)  │
│  ├── Layout (grid, flexbox)             │
│  ├── Animations (@keyframes)            │
│  ├── Accessibility (focus, motion)      │
│  └── Responsive breakpoints             │
├─────────────────────────────────────────┤
│  JS Layer                               │
│  ├── 1. Game State (pure functions)     │
│  ├── 2. AI Engine (minimax + α-β)       │
│  ├── 3. UI Renderer (DOM + ARIA)        │
│  ├── 4. Event System (click + keyboard) │
│  ├── 5. Animation Controller            │
│  ├── 6. Initialization                  │
│  └── 7. Self-Test Suite                 │
├─────────────────────────────────────────┤
│  HTML Layer                             │
│  ├── Game controls (mode, difficulty)   │
│  ├── Status bar (dual-coded)            │
│  ├── Board (ARIA grid)                  │
│  ├── Scoreboard (3 cards)               │
│  └── Evidence panel (15 citations)      │
└─────────────────────────────────────────┘
```

### Design Decisions

| Decision | Rationale |
|----------|-----------|
| **Single file** | Zero deployment friction — `open file.html` and play |
| **No framework** | Eliminates dependency risk, reduces payload to ~20KB |
| **Inline SVG marks** | Crisp at any resolution, animatable, no image requests |
| **Pure state functions** | Testable without DOM; enables the self-test suite |
| **CSS custom properties** | Single source of truth for the design system |

---

## 🛠️ Development Methodology

This project was built following the **[Superpowers](https://github.com/obra/superpowers)** agentic development framework:

| Phase | Superpowers Skill | What Happened |
|-------|-------------------|---------------|
| 1. Explore | `brainstorming` | Defined requirements, explored approaches, identified research base |
| 2. Plan | `writing-plans` | Broke implementation into testable tasks with TDD emphasis |
| 3. Build | `test-driven-development` | Wrote tests first, then minimal code to pass |
| 4. Debug | `systematic-debugging` | Root cause analysis for scroll overflow bug |
| 5. Verify | `verification-before-completion` | Ran all tests, checked contrast ratios, confirmed Nash equilibrium |

Documentation was informed by **[Context7 MCP](https://context7.com)** — fetching live MDN docs for CSS animations, ARIA patterns, and DOM APIs to ensure no outdated patterns were used.

---

## 💻 Local Development

```bash
# Clone
git clone https://github.com/CBGaming412/tic-tac-toe.git
cd tic-tac-toe

# Play (that's it — no build step)
open tic-tac-toe.html

# Verify tests pass
# Open browser console (F12) → look for "🧪 Self-Tests: 12/12 passed"
```

---

## 📁 Project Structure

```
tic-tac-toe/
├── tic-tac-toe.html   # The complete game — single file, zero dependencies
├── netlify.toml        # Deployment config — redirects, headers, caching
├── .gitignore          # Excludes dev tools from repo
└── README.md           # This file — the evidence-based documentation
```

---

## 📄 License

[MIT License](LICENSE) — use it however you want.

---

<p align="center">
  <br>
  <strong>Every pixel has a reason. Every algorithm has a proof.</strong>
  <br><br>
  <a href="https://cb-tic-tac-toe.netlify.app/">Play Now →</a>
  <br><br>
  <sub>Made with 🧠 research and ❤️ fun</sub>
</p>
