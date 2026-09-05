# Project Todo

## Recently Completed

### SM3 Unit 3 Daily Routines Lesson From PDF ✅

- [x] Created `sm3/unit3/daily-routines-frequency-adverbs.html` from the Unit 3 PDF.
- [x] Added frequency adverbs, routine and story readings, time expressions, grammar practice, and todo tracking.
- [x] Updated homepage, shared navigation, documentation, and SM3 regression coverage.

### SM3 Unit 2 Lesson From PDF ✅

- [x] Created `sm3/unit2/there-is-there-are-picnic.html`.
- [x] Added the two missing source pictures at the top of the lesson:
  - `sm3/unit2/assets/unit2-source-000.jpg`
  - `sm3/unit2/assets/unit2-source-001.jpg`
- [x] Added food vocabulary, `There is` / `There are` grammar, picnic song, supermarket story, reading questions, translation practice, and todo tracking.
- [x] Updated homepage and shared navigation links.
- [x] Added SM3 regression coverage in `scripts/test_sm3_pages.py`.

### SM3 Unit 2 Breakfast Lesson From PDF ✅

- [x] Created `sm3/unit2/breakfast-foods-simple-present.html`.
- [x] Added breakfast vocabulary, pizza ordering dialogue, Saturday housework reading, extension reading, simple present cloze, and todo tracking.
- [x] Updated homepage and shared navigation links.
- [x] Updated README, TESTING, AGENTS, and SM3 regression coverage.

### Mobile Navigation Fixes ✅

- [x] Isolated SM3 Unit 2 lesson controls with `data-lesson-action`.
- [x] Kept shared navigation controls on `data-action`.
- [x] Added compact mobile nav sections for `SM2` and `SM3`.
- [x] Open the active course family by default on mobile.
- [x] Preserved desktop dropdown navigation.
- [x] Added regression coverage for compact mobile navigation.

### Documentation Sync ✅

- [x] Updated `README.md` for the current SM2/SM3 course inventory.
- [x] Updated `TESTING.md` for current paths, SM3 checks, and compact mobile nav behavior.
- [x] Updated `scripts/README.md` for the current baseball generator paths.
- [x] Updated `AGENTS.md` for the current repo structure and shared navigation rules.
- [x] Updated this todo/status file.

## Current Maintenance Notes

### Generated Files

- [x] `sm2/baseball/unit8/baseball-gerunds-ball-sports.html` is generated from `sm2/unit8/gerunds-ball-sports.html`.
- [ ] Run `python3 scripts/generate-baseball.py` after changing the SM2 Unit 8 ball sports source page.
- [ ] Run `python3 scripts/test_generate_baseball.py` after generator or source-path changes.

### Test Commands

- [x] Main validation command: `PYTHONDONTWRITEBYTECODE=1 ./test.sh`.
- [x] SM3 regression command: `PYTHONDONTWRITEBYTECODE=1 python3 -m unittest scripts/test_sm3_pages.py`.
- [x] JS syntax command: `node --check js/common.js`.

## Refactor Backlog

### Replace Remaining Inline `onclick` Handlers

- [ ] Continue reducing inline `onclick` handlers across legacy SM2 pages.
- [ ] Prioritize clickable `<div>` and `<span>` elements that still need keyboard accessibility.
- [ ] Keep page-specific actions on page-specific data attributes, not shared nav `data-action`.

### Shared CSS Cleanup

- [ ] Move repeated page-local visual patterns into shared CSS only when at least two pages need them.
- [ ] Keep single-page PDF-derived styling local when it is not reused.

### Review Pages

- [ ] Keep `sm2/review/` pages aligned with the shared nav and shared interaction helpers.
- [ ] Add focused regression tests when changing review-page todo state or answer reveals.
