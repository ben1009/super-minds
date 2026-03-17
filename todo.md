# Refactoring Todo List

Branch: `refactor/consolidate-shared-code`

## Overview

This refactoring aims to eliminate code duplication, improve maintainability, and establish a cleaner architecture for the Super Minds English learning platform.

---

## Phase 1: Remove duplicate ga.js from baseball folder

**Problem:** The `super-minds-baseball/ga.js` is identical to the root `ga.js`, violating DRY principle.

**Tasks:**
- [x] Delete `super-minds-baseball/ga.js`
- [x] Update reference in `super-minds-baseball/index.html` from `ga.js` to `../ga.js`
- [x] Verify all baseball pages use the shared script

---

## Phase 2: Extract shared CSS variables and keyframes

**Problem:** Common CSS patterns are duplicated across multiple HTML files:
- `@keyframes fadeInUp` animation
- Body background gradients
- Common utility classes

**Tasks:**
- [x] Create `css/common.css` with shared styles
- [x] Extract common keyframes (fadeInUp, float, etc.)
- [x] Extract common body background styles
- [x] Update all HTML files to include shared CSS

---

## Phase 3: Create shared JavaScript utilities module

**Problem:** Identical JavaScript functions are copy-pasted across pages:
- `toggleMobileMenu()`
- `toggleAnswer()` / toggle functions
- Progress tracking logic

**Tasks:**
- [ ] Create `js/common.js` with shared utilities
- [ ] Move `toggleMobileMenu()` to shared module
- [ ] Move common toggle functionality to shared module
- [ ] Update all HTML files to include shared JS

---

## Phase 4: Standardize mobile navigation component

**Problem:** Navigation HTML structure is duplicated in every page with minor variations.

**Tasks:**
- [ ] Create consistent navigation markup pattern
- [ ] Document the navigation structure in AGENTS.md
- [ ] Ensure all pages use identical nav component

---

## Phase 5: Consolidate toggle/accordion functionality

**Problem:** Multiple implementations of similar toggle patterns:
- Quiz answers (`toggleQuizAnswer`)
- Story translations (`toggleTranslation`)
- Comprehension answers (`toggleCompAnswer`)
- Timeline details (`toggleTimeline`)

**Tasks:**
- [ ] Analyze all toggle implementations
- [ ] Design unified toggle API
- [ ] Replace individual functions with unified implementation

---

## Phase 6: Unify Lucide icons initialization

**Problem:** Inconsistent Lucide icons initialization:
- Some files call `lucide.createIcons()`
- Some don't, causing missing icons

**Tasks:**
- [ ] Audit all pages for icon initialization
- [ ] Ensure `lucide.createIcons()` is called appropriately
- [ ] Consider auto-initialization in shared JS

---

## Progress Tracker

| Phase | Task | Status |
|-------|------|--------|
| 1 | Remove duplicate ga.js from baseball folder | ✅ done |
| 2 | Extract shared CSS variables and keyframes | ✅ done |
| 3 | Create shared JavaScript utilities module | pending |
| 4 | Standardize mobile navigation component | pending |
| 5 | Consolidate toggle/accordion functionality | pending |
| 6 | Unify Lucide icons initialization | pending |
| 7 | Update documentation | pending |

---

## Phase 7: Update documentation

**Problem:** Documentation needs to reflect the new shared code structure after refactoring.

**Tasks:**
- [ ] Update `AGENTS.md` with new project structure
- [ ] Document the shared CSS/JS modules
- [ ] Update file references in documentation
- [ ] Add usage examples for shared utilities
- [ ] Update navigation component documentation

---

## Notes

- Each phase should be committed separately for clean git history
- Test all pages after each phase to ensure functionality is preserved
- Keep changes minimal - focus on DRY principle, not feature changes
- Update todo.md status as each phase is completed
