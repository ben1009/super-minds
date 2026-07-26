# Build Scripts

This directory contains build and validation helpers for the Super Minds project.

## `generate-baseball.py`

Generates the baseball-themed variant of the Super Minds 2 Unit 8 gerunds page from the canonical source file.

### Usage

```bash
python3 scripts/generate-baseball.py
```

**Input:** `sm2/unit8/gerunds-ball-sports.html`

**Output:** `sm2/baseball/unit8/baseball-gerunds-ball-sports.html`

### Transformations Applied

| Transformation | Source | Output |
|---------------|--------|--------|
| Favicon path | `../../favicon.svg` | `../../../favicon.svg` |
| GA script path | `../../ga.js` | `../../../ga.js` |
| CSS path | `../../css/baseball-theme.css` | `../../../css/baseball-theme.css` |
| JS path | `../../js/common.js` | `../../../js/common.js` |
| NAV config | `active:'unit8-sports'` | `active:'baseball-unit8-sports'` |
| Meta description | `Unit 8 棒球主题英语学习...` | `棒球版 Unit 8 球类运动...` |
| Chinese quotes | `”` (U+201D) | ASCII `"` |
| Blank lines | Lines with only spaces/tabs | Empty lines |

### When to Run

Run this script after modifying `sm2/unit8/gerunds-ball-sports.html` to keep the baseball variant in sync.

### Testing

```bash
python3 scripts/test_generate_baseball.py
PYTHONDONTWRITEBYTECODE=1 ./test.sh
```

The quick validation workflow also verifies that the committed baseball output matches the generated output.

## `test_sm3_pages.py`

Validates Super Minds 3 lesson pages and shared navigation regressions.

```bash
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest scripts/test_sm3_pages.py
```

Coverage includes:

- SM3 page titles, nav config, and required shared resources
- SM3 Unit 2 source pictures under `sm3/unit2/assets/`
- Lesson action isolation through `data-lesson-action`
- Compact mobile navigation sections for SM2 and SM3
- Todo storage keys and interactive reveal controls
