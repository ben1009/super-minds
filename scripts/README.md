# Build Scripts

This directory contains build and automation scripts for the Super Minds project.

## `generate-baseball.py`

Generates the baseball-themed variant of the Unit 8 gerunds page from the canonical source file.

### Usage

```bash
python3 scripts/generate-baseball.py
```

**Input:** `unit8/gerunds-ball-sports.html`
**Output:** `super-minds-baseball/unit8/baseball-gerunds-ball-sports.html`

### Transformations Applied

| Transformation | Source | Output |
|---------------|--------|--------|
| Favicon path | `../favicon.svg` | `../../favicon.svg` |
| GA script path | `../ga.js` | `../../ga.js` |
| CSS path | `../css/baseball-theme.css` | `../../css/baseball-theme.css` |
| JS path | `../js/common.js` | `../../js/common.js` |
| NAV config | `active:'unit8-sports'` | `active:'baseball-unit8-sports'` |
| Meta description | `Unit 8 棒球主题英语学习...` | `棒球版 Unit 8 球类运动...` |
| Chinese quotes | U+201D (`"`) | ASCII `"` |
| Blank lines | Lines with only spaces/tabs | Empty lines |

### When to Run

Run this script after modifying `unit8/gerunds-ball-sports.html` to keep the baseball variant in sync.

### Testing

```bash
# Run unit tests
python3 scripts/test_generate_baseball.py

# Run full test suite (includes sync check)
./test.sh
```

The CI (`quick-test.yml`) also verifies that the committed output matches the script's generated output.
