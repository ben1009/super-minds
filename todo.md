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
- [x] Create `js/common.js` with shared utilities
- [x] Move `toggleMobileMenu()` to shared module
- [x] Move common toggle functionality to shared module
- [x] Update all HTML files to include shared JS

---

## Phase 4: Standardize mobile navigation component

**Problem:** Navigation HTML structure is duplicated in every page with minor variations.

**Tasks:**
- [x] Create consistent navigation markup pattern
- [x] Document the navigation structure in AGENTS.md
- [x] Ensure all pages use identical nav component

---

## Phase 5: Consolidate toggle/accordion functionality

**Problem:** Multiple implementations of similar toggle patterns:
- Quiz answers (`toggleQuizAnswer`)
- Story translations (`toggleTranslation`)
- Comprehension answers (`toggleCompAnswer`)
- Timeline details (`toggleTimeline`)

**Tasks:**
- [x] Analyze all toggle implementations
- [x] Design unified toggle API
- [x] Replace individual functions with unified implementation

---

## Phase 6: Unify Lucide icons initialization

**Problem:** Inconsistent Lucide icons initialization:
- Some files call `lucide.createIcons()`
- Some don't, causing missing icons

**Tasks:**
- [x] Audit all pages for icon initialization
- [x] Ensure `lucide.createIcons()` is called appropriately
- [x] Consider auto-initialization in shared JS

---

## Progress Tracker

| Phase | Task | Status |
|-------|------|--------|
| 1 | Remove duplicate ga.js from baseball folder | ✅ done |
| 2 | Extract shared CSS variables and keyframes | ✅ done |
| 3 | Create shared JavaScript utilities module | ✅ done |
| 4 | Standardize mobile navigation component | ✅ done |
| 5 | Consolidate toggle/accordion functionality | ✅ done |
| 6 | Unify Lucide icons initialization | ✅ done |
| 7 | Update documentation | ✅ done |

---

## Summary

All refactoring phases completed successfully!

### Changes Made:

1. **Updated**: `super-minds-baseball/` - All pages use `../../ga.js` to reference root ga.js
   - index.html, unit7/index.html, unit7/homework.html, unit8/index.html
3. **Created**: `css/common.css` - Shared styles (variables, animations, utilities)
3. **Created**: `js/common.js` - Shared JavaScript utilities (12+ functions)
4. **Updated**: All HTML files to use shared resources
5. **Updated**: `AGENTS.md` with new architecture documentation
6. **Created**: GitHub Actions CI/CD workflows for automated testing
   - Headless browser testing with Puppeteer and Playwright
   - E2E tests for interactions, navigation, responsive design
   - Lighthouse CI for performance and accessibility
   - Visual regression testing with screenshots
7. **Created**: TESTING.md and test.sh for manual testing

### Benefits:

- **DRY Principle**: Eliminated code duplication across pages
- **Maintainability**: Changes to shared code apply everywhere
- **Consistency**: Unified navigation, icons, and interactions
- **Performance**: Reduced total code size through reuse
- **Quality**: Automated testing prevents regressions

### Testing

Three types of tests are now available:

1. **Automated (GitHub Actions)**:
   - **Quick Validation** - File structure, references, HTML basics
   - **Full CI** - HTML/CSS/JS validation, link checking, ESLint
   - **Headless Browser** - Puppeteer/Playwright E2E tests in headless mode
   - **Lighthouse CI** - Performance, accessibility, best practices audits
   - **Visual Regression** - Screenshot comparisons

2. **Local Headless Testing**:
   ```bash
   npm install puppeteer
   node smoke-test.js  # Headless browser tests locally
   ```

3. **Manual**:
   - Run `./test.sh` for quick file checks
   - Run `python3 -m http.server 8000` for browser testing
   - Follow TESTING.md checklist

### Files Created/Modified

```
✅ Created: css/common.css
✅ Created: js/common.js
✅ Created: .github/workflows/quick-test.yml
✅ Created: .github/workflows/ci.yml
✅ Created: TESTING.md
✅ Created: test.sh
✅ Modified: index.html, unit7/*.html (use shared resources)
✅ Modified: AGENTS.md (updated documentation)
✅ Modified: super-minds-baseball/*.html (all use ../../ga.js)
✅ Deleted: super-minds-baseball/ga.js (truly removed, all pages reference root)
```

---

## Phase 7: Update documentation

**Problem:** Documentation needs to reflect the new shared code structure after refactoring.

**Tasks:**
- [x] Update `AGENTS.md` with new project structure
- [x] Document the shared CSS/JS modules
- [x] Update file references in documentation
- [x] Add usage examples for shared utilities
- [x] Update navigation component documentation

---

## Notes

- Each phase should be committed separately for clean git history
- Test all pages after each phase to ensure functionality is preserved
- Keep changes minimal - focus on DRY principle, not feature changes
- Update todo.md status as each phase is completed
