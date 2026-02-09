<div align="center">

# Screenplay LaTeX

**Industry-standard screenplay formatting for LaTeX, with full pre-production annotation support.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![LaTeX](https://img.shields.io/badge/Made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/)
[![Engine](https://img.shields.io/badge/Engine-pdfLaTeX%20%7C%20LuaLaTeX%20%7C%20XeLaTeX-green.svg)](#getting-started)

Write, annotate, and prepare screenplays entirely in LaTeX. Toggle between a clean shooting script and a fully annotated pre-production draft with a single document class option.

</div>

---

## Preview

| Clean Script | Pre-Production Script |
|:---:|:---:|
| Standard shooting script with no annotations | Color-coded annotations for props, shots, lighting, and more |
| [View PDF](example_clean.pdf) | [View PDF](example_preproduction.pdf) |

> **See it in action:** Download [example.tex](example.tex) and compile it yourself to explore every feature.

---

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Screenplay Elements](#screenplay-elements)
- [Pre-Production Annotations](#pre-production-annotations)
- [Revision Support](#revision-support)
- [Scene Breakdown Table](#scene-breakdown-table)
- [Formatting Standards](#formatting-standards)
- [Dependencies](#dependencies)
- [Tips and Tricks](#tips-and-tricks)
- [License](#license)

---

## Features

- **Complete screenplay formatting** -- title pages, scene headings, action, dialogue, parentheticals, transitions, and dual dialogue, all conforming to industry standards
- **Pre-production toggle** -- switch between a clean shooting script and an annotated production draft with one flag
- **8 annotation categories** -- props, wardrobe, shots, camera, lighting, SFX, VFX, and set notes, each color-coded and tagged
- **Inline annotations** -- embed production notes directly inside action, dialogue, and parenthetical blocks
- **Revision tracking** -- margin asterisks for revised lines and colored revision pages following the standard color order
- **Scene breakdown table** -- auto-generated `.breakdown` file listing every annotation by scene, parseable by external tools
- **Flexible scene numbering** -- auto-increment, manual override, and revision inserts (e.g., Scene 14A)
- **Multi-engine support** -- works with pdfLaTeX, LuaLaTeX, and XeLaTeX

---

## Getting Started

### Prerequisites

A working TeX Live (or MiKTeX) installation. All required packages ship with a standard full install.

### Compile

```bash
# 1. Clone or download this repository
git clone https://github.com/your-username/screenplay-latex.git
cd screenplay-latex

# 2. Compile the example screenplay (run twice for the breakdown table)
pdflatex example.tex
pdflatex example.tex
```

### Toggle Pre-Production Mode

```latex
\documentclass[preproduction]{screenplay}   % Annotations ON  (colored, tagged)
\documentclass{screenplay}                  % Annotations OFF (clean shooting script)
```

One option controls everything. No other changes required.

> **Note:** For Courier Prime (the recommended production font), compile with LuaLaTeX or XeLaTeX and enable `fontspec` -- see [Tips and Tricks](#tips-and-tricks) for details.

---

## Project Structure

```
screenplay-latex/
├── screenplay.cls            # Document class -- all formatting and annotation logic
├── example.tex               # Full sample screenplay demonstrating every feature
├── example.pdf               # Compiled output (pre-production mode)
├── example_clean.pdf         # Compiled output (clean shooting script)
├── example_preproduction.pdf # Compiled output (pre-production mode, reference)
├── example.breakdown         # Auto-generated scene breakdown data
└── README.md                 # This file
```

---

## Screenplay Elements

### Title page

```latex
\screentitle{The Last Light}
\screenauthor{Jane Doe}
\screencontact{Jane Doe \\ 123 Sunset Blvd \\ jane@example.com}
\screendraftinfo{First Draft — February 2026}

\begin{document}
\maketitlepage
```

### Scene headings (sluglines)

```latex
\slugline[1]{EXT.}{COASTAL HIGHWAY}{DAWN}       % Manual scene number
\slugline[14A]{INT.}{WAREHOUSE}{NIGHT}           % Revision insert (14A)
\slugline{INT.}{KITCHEN}{DAY}                    % Auto-numbered
```

Scene numbers appear in both margins, per industry standard.

### Action

```latex
\action{Sarah enters the room. She looks around nervously.}
```

### Character cue, dialogue, and parenthetical

```latex
\character{SARAH}
\paren{whispering}
\dialogue{I think someone's watching us.}

\character[V.O.]{NARRATOR}      % Voice-over extension
\dialogue{She had no idea how right she was.}
```

Supported extensions include `V.O.`, `O.S.`, `CONT'D`, and any custom string.

### Transitions

```latex
\trans{CUT TO:}
\trans{FADE TO BLACK.}
\trans{SMASH CUT TO:}
```

### Dual dialogue

```latex
\dualdia
  {SARAH}{I'm leaving tonight.}
  {MICHAEL}{You can't be serious.}
```

Renders both characters side by side on the same line.

---

## Pre-Production Annotations

### The toggle

```latex
\documentclass[preproduction]{screenplay}   % Annotations visible
\documentclass{screenplay}                  % Clean script (annotations hidden)
```

### Annotation commands

All annotation commands are **inline** -- use them inside `\action{}`, `\dialogue{}`, `\paren{}`, or as standalone blocks between elements.

| Command | Color | Tag | Clean Script Behavior |
|---|---|---|---|
| `\prop{knife}` | Yellow | P | **Text preserved** |
| `\wardrobe{torn jacket}` | Pink | W | **Text preserved** |
| `\shot{CLOSE-UP}` | Blue | S | Text removed |
| `\cam{DOLLY IN}` | Purple | C | Text removed |
| `\lighting{low-key}` | Orange | L | Text removed |
| `\sfx{thunder}` | Green | X | Text removed |
| `\vfx{wire removal}` | Red | V | Text removed |
| `\setnote{cobwebs}` | Teal | D | Text removed |

**Text-preserving** commands (`\prop`, `\wardrobe`) leave their text in the clean script because they describe things visible in the story world. **Text-removing** commands vanish entirely in clean mode because they are purely technical production notes.

### Usage examples

**Inside action blocks:**

```latex
\action{
  Sarah grabs a \prop{chef's knife} from the counter.
  \lighting{Warm amber key light from the window.}
  \cam{SLOW PUSH IN on her hands.}
}
```

**Between blocks (standalone):**

```latex
\shot{EXTREME CLOSE-UP}
\action{Her fingers tremble around the \prop{knife handle}.}
```

**Inside dialogue and parentheticals:**

```latex
\character{SARAH}
\paren{setting down the \prop{glass}}
\dialogue{I never asked for this. \sfx{distant sirens}}
```

### Color-coded legend

Add `\preprodlegend` after `\maketitlepage` to print a color-coded legend page. Only visible in pre-production mode.

### Script notes

```latex
\scriptnote{End of Act One. Estimated runtime: 25 minutes.
  Location scout needed for warehouse exterior.}
```

Renders as a boxed note. Only visible in pre-production mode.

---

## Revision Support

### Revision marks

Wrap revised text in `\revised{}` to place an asterisk (\*) in the right margin:

```latex
\revised{
\character{SARAH}
\dialogue{This line was changed in revision.}
}
```

### Colored revision pages

```latex
\revisioncolor{pink}                        % Set page background color
\revisioninfo{2nd Draft}{February 8, 2026}  % Print revision header
```

Available colors follow the standard industry revision order:

| Draft | Color |
|---|---|
| Original | White |
| 2nd | Blue |
| 3rd | Pink |
| 4th | Yellow |
| 5th | Green |
| 6th | Goldenrod |
| 7th | Buff |
| 8th | Salmon |
| 9th | Cherry |
| 10th | Tan |

---

## Scene Breakdown Table

Every annotation is automatically logged to a `.breakdown` file during compilation:

```
\breakdownentry{SCENE_NUMBER}{CATEGORY}{ITEM}
```

To render a formatted breakdown at the end of your script:

```latex
\printbreakdownraw    % Appends a simple text listing of all annotations by scene
```

> **Note:** Compile twice -- the first pass writes the `.breakdown` file, the second reads it back in.

The `.breakdown` file is plain text and directly parseable by external tools (Python, spreadsheets, production management software) for generating call sheets, prop lists, and production schedules.

### Parsing the breakdown file

Example Python parser:

```python
import re
from collections import defaultdict

breakdown = defaultdict(lambda: defaultdict(list))

with open("example.breakdown") as f:
    for line in f:
        m = re.match(r'\\breakdownentry\{(.+?)\}\{(.+?)\}\{(.+)\}', line.strip())
        if m:
            scene, category, item = m.groups()
            breakdown[scene][category].append(item)

# Print prop list by scene
for scene in sorted(breakdown, key=lambda s: (s.replace('A','').replace('B',''), s)):
    props = breakdown[scene].get("PROP", [])
    if props:
        print(f"Scene {scene}: {', '.join(props)}")
```

---

## Formatting Standards

The document class follows industry-standard screenplay formatting:

| Element | Specification |
|---|---|
| Font | Courier 12pt (upgrade to Courier Prime via `fontspec`) |
| Margins | 1.5 in left; 1 in top, right, and bottom |
| Spacing | Single-spaced, one blank line between elements |
| Page numbers | Top-right corner, followed by a period |
| Scene numbers | Both left and right margins |
| Character cues | Centered, uppercase |
| Dialogue | 1 in left indent, 3.5 in wide |
| Parentheticals | 1.5 in left indent, 2 in wide |
| Transitions | Right-aligned, uppercase |

---

## Dependencies

All packages ship with a standard TeX Live or MiKTeX installation:

| Category | Packages |
|---|---|
| Layout | `geometry`, `fancyhdr`, `titlesec`, `setspace` |
| Fonts | `fontenc`, `courier` |
| Color and styling | `xcolor`, `marginnote` |
| Tables | `longtable`, `booktabs` |
| Utilities | `ifthen`, `xstring`, `etoolbox`, `enumitem`, `environ` |
| Other | `hyperref`, `paracol` |

> **Note:** For Courier Prime (free from [Google Fonts](https://fonts.google.com/specimen/Courier+Prime)), replace the font setup in `screenplay.cls` with `fontspec` and compile with LuaLaTeX or XeLaTeX.

---

## Tips and Tricks

- **Revision inserts** -- Use `\slugline[14A]` to insert new scenes between existing numbered scenes during revisions.
- **Nested annotations** -- Annotation commands can be placed inside any text-bearing command (`\action`, `\dialogue`, `\paren`).
- **Reset breakdown data** -- Delete the `.breakdown` file between compilations to start fresh.
- **Track changes per draft** -- Combine `\revised{}` with specific scene numbers to see exactly what changed in each revision.
- **Use Courier Prime** -- Replace the font setup block in `screenplay.cls` with:

```latex
\RequirePackage{fontspec}
\setmainfont{Courier Prime}
```

Then compile with `lualatex` or `xelatex` instead of `pdflatex`.

---

## License

This project is licensed under the **MIT License** -- free for personal and commercial use.

See [LICENSE](LICENSE) for details.
