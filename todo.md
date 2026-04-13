# Project Todo & History

## Completed: Refactoring Project

**Branch:** `refactor/consolidate-shared-code` ✅ **COMPLETED**

### Summary
All refactoring phases completed successfully on 2024. The codebase has been consolidated with shared CSS/JS modules and automated testing infrastructure.

### Major Changes Delivered:
1. ✅ Removed duplicate `ga.js` from baseball folder - all pages now reference root `ga.js`
2. ✅ Created `css/common.css` - shared styles (variables, animations, utilities)
3. ✅ Created `js/common.js` - shared JavaScript utilities (12+ functions)
4. ✅ Standardized mobile navigation component across all pages
5. ✅ Consolidated toggle/accordion functionality
6. ✅ Unified Lucide icons initialization
7. ✅ Added comprehensive GitHub Actions CI/CD workflows:
   - `.github/workflows/quick-test.yml` - Quick validation
   - `.github/workflows/ci.yml` - Full CI suite
   - `.github/workflows/browser-tests.yml` - Playwright E2E, Lighthouse, Visual Regression
   - `.github/workflows/unit8-reading-test.yml` - Unit 8 Reading page specific tests
8. ✅ Updated all documentation (AGENTS.md, README.md, TESTING.md)

---

## Active: New Features & Content

### Unit 8 Grammar Homework Page ✅
**Status:** Completed
**File:** `unit8/grammar.html`

Features:
- 5 question words (Where, When, Which, Who, How often) grammar cards
- New dialogue: Football team story with 8 scenes
- 9 Unit 9 verb phrases with audio pronunciation
- Sentence practice exercises
- Email cloze exercise (Harry's France trip)
- Interactive todo list

---

## Active Refactoring Tasks

### 1. Fix test.sh Script ✅ **COMPLETED**
**Priority:** High

Issues fixed:
- [x] Line 19, 23: Updated to check `unit8/*.html` in addition to `unit7/*.html`
- [x] Line 86: Fixed bug - `$f` changed to `$file`
- [x] Verified all tests pass

### 2. Standardize Unit 8 Pages to Use Shared Resources ⚠️
**Priority:** Low (Design Decision)

**Status:** Evaluated - Intentional Design

The Unit 8 pages intentionally use a unique baseball theme with custom styles:
- `unit8/index.html` - Baseball field green background, leather cards, stitch-red accents
- `unit8/reading.html` - Same baseball theme
- `unit8/grammar.html` - Uses separate `grammar.css` and `grammar.js` for baseball theme
- `unit8/amazing-vehicles.html` - Uses shared `common.js` but has custom styles

**Decision:** Keep separate styling for theme consistency. The shared `common.css` is designed for the main Super Minds theme (sky blue gradient), not the baseball theme.

**Future consideration:** Could extract shared JS functions (`toggleMobileMenu`, `speak`, etc.) to reduce duplication while keeping custom CSS.

### 3. Cleanup todo.md ✅ **COMPLETED**
**Priority:** Low

- [x] Removed duplicate old refactoring content
- [x] Consolidated into clean structure
- [x] All refactoring tasks now documented in clean format

---

## Future Ideas

- [ ] Add more interactive quiz types
- [ ] Implement progress tracking across all units
- [ ] Add sound effects for interactions
- [ ] Mobile app version (PWA)
- [ ] Extract shared JavaScript functions from Unit 8 pages to reduce duplication
