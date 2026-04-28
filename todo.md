# Project Todo

## 🔴 High Priority

### 1. Add unit9 navigation links to all super-minds-baseball pages ✅
- [x] `super-minds-baseball/index.html`
- [x] `super-minds-baseball/unit7/baseball-present-continuous-course.html`
- [x] `super-minds-baseball/unit7/baseball-present-continuous-homework.html`
- [x] `super-minds-baseball/unit8/baseball-gerunds-ball-sports.html`

## 🟡 Medium Priority (CI / Test Gaps)

### 2. Add `unit8/question-words-grammar-homework.html` to quick-test.yml validation loops ✅
- [x] Line 103: HTML structure validation loop
- [x] Line 161: fun-things-we-do-reading.html navigation check loop

### 3. Add missing unit8 pages to ci.yml HTML validation ✅
- [x] `unit8/amazing-vehicles-reading.html`
- [x] `unit8/fun-things-we-do-reading.html`
- [x] `unit8/question-words-grammar-homework.html`

### 4. Add missing page tests to browser-tests.yml ✅
- [x] `unit8/fun-things-we-do-reading.html` page load test
- [x] `unit8/question-words-grammar-homework.html` page load test
- [x] `unit9/holiday-plans-grammar-review.html` page load test
- [x] Baseball homepage → Unit 9 navigation test
- [x] Baseball Unit 7 → Unit 9 navigation test
- [x] Baseball Unit 8 → Unit 9 navigation test
- [x] Screenshot coverage for reading, grammar, unit9, baseball-home

### 5. Add manual test sections to TESTING.md ✅
- [x] `unit8/question-words-grammar-homework.html` checklist
- [x] `unit8/amazing-vehicles-reading.html` checklist

### 6. Fix test.sh incomplete loops ✅
- [x] Line 88: Removed duplicate `unit8/fun-things-we-do-reading.html` from favicon loop
- [x] Line 127: Added `unit8/question-words-grammar-homework.html` and `unit9/holiday-plans-grammar-review.html` to fun-things-we-do-reading.html back-link check
- [x] Line 202: Added `unit9/holiday-plans-grammar-review.html` to question-words-grammar-homework.html back-link check
- [x] Line 218+: Added step 10 — super-minds-baseball unit9 link check

### 7. Update AGENTS.md documentation ✅
- [x] Added steps 16-19 documenting super-minds-baseball Unit 9 nav updates

### 8. Add quick-test.yml step for baseball/unit9 nav ✅
- [x] "Validate Baseball Section Unit 9 Navigation" step added

### 9. Add Unit 9 Fairy Tales documentation ✅
- [x] README lists `unit9/fairy-tales-reading.html` in available courses and project structure
- [x] TESTING.md includes a manual checklist for `/unit9/fairy-tales-reading.html`
- [x] AGENTS.md documents Fairy Tales behavior and localStorage key details

### 10. Document latest review fixes ✅
- [x] Fairy Tales reading answer option text no longer includes literal `✓` characters
- [x] Baseball Unit 7 desktop/mobile navigation includes Fairy Tales links
- [x] README and TESTING.md reflect the current Unit 9 page coverage

---

## 🔴 Refactor — High Severity

### 11. Extract shared navigation HTML into a JS template ✅
- [x] Added `renderNav()` + 4 pattern builders (`A`, `B`, `C`, `D`) to `js/common.js`
- [x] `initCommon()` auto-renders nav when `window.NAV_CONFIG` is present
- [x] Replaced inline `<nav>` in 11 files with `<script>window.NAV_CONFIG = {...}</script><nav id="site-nav"></nav>`
- [x] Fixed inconsistencies: `baseball-font` on unit9 brand, mobile active style, `fa-bus` brand icon
- **Patterns:**
  - **A** (2 files): Unit 7 blue theme, Lucide icons, dropdowns
  - **B** (6 files): Unit 8/9 green theme, FontAwesome icons, dropdowns
  - **C** (2 files): Baseball sub-pages red theme, flat `|` links
  - **D** (1 file): Baseball unit8 green theme, flat links (discovered during refactor)
- **Impact:** Eliminated ~550 lines of duplicated HTML

### 12. Extract baseball theme CSS into `css/baseball-theme.css` ✅
- [x] `unit8/gerunds-ball-sports.html:15–192`
- [x] `unit8/amazing-vehicles-reading.html:18–257`
- [x] `unit8/fun-things-we-do-reading.html:15–304` (remaining `.translation` animation extracted as `.translation-animated`)
- [x] `unit9/holiday-plans-grammar-review.html:15–348`
- [x] `unit9/fairy-tales-reading.html:15–362`
- [x] `super-minds-baseball/unit8/baseball-gerunds-ball-sports.html`
- **Impact:** ~800 lines of duplicated CSS extracted
- **Note:** `unit8/grammar.css` already exists but is only loaded by `question-words-grammar-homework.html`

### 13. Deduplicate inline JS functions — use `js/common.js` consistently ✅
- [x] `toggleMobileMenu()` — already in `common.js`, no inline redefinitions found
- [x] `toggleTranslation()` — removed from `unit8/fun-things-we-do-reading.html` and `unit9/fairy-tales-reading.html`; enhanced `common.js` version with `.translate-hint` support
- [x] `toggleAnswer()` — renamed page-specific variants to avoid shadowing:
  - `unit8/fun-things-we-do-reading.html` → `toggleQuestionAnswer()`
  - `unit8/amazing-vehicles-reading.html` → `toggleReadingAnswer()`
  - `super-minds-baseball/unit7/*.html` → `toggleReveal()`
  - Removed `typeof` guard from `common.js` canonical version
- [x] `speak()` — already in `common.js`, no inline redefinitions found
- [x] `updateProgress()` / `toggleTodo()` / `resetTodos()` — already in `common.js`, no inline redefinitions found
- [x] `copyDialogue()` — replaced with `data-copy-text` + inline `copyToClipboard()` in both Unit 7 homework pages
- [x] `revealAnswer()` — extracted to `common.js` with `data-placeholder` support; removed from `unit9/*.html`
- **Impact:** ~200 lines of duplicated JS eliminated

### 14. Resolve baseball version near-duplication
- [x] `super-minds-baseball/unit8/baseball-gerunds-ball-sports.html` vs `unit8/gerunds-ball-sports.html` (~95% identical, generated by `scripts/generate-baseball.py`)
- [x] `super-minds-baseball/unit7/baseball-present-continuous-course.html` vs `unit7/present-continuous-course.html` are intentional themed rewrites, not template duplicates
- [x] `super-minds-baseball/unit7/baseball-present-continuous-homework.html` vs `unit7/present-continuous-homework.html` are intentional themed rewrites, not template duplicates
- [x] Extracted shared Unit 7 baseball theme + card-flip styles into `css/baseball-unit7.css`
- **Idea:** A future theme-toggle could still reduce the baseball page count further, but the current themed rewrites are now centralized on shared CSS

---

## 🟡 Refactor — Medium Severity

### 15. Replace inline `onclick` with `addEventListener`
- **457 total inline `onclick` handlers** across 14 HTML files
- Prioritize non-interactive elements (`<div>`, `<span>`) that lack `role="button"` / `tabindex`
- **Notable:**
  - `unit7/present-continuous-homework.html:460` — flashcard flip
  - `unit8/gerunds-ball-sports.html:293` — vocabulary speak
  - `unit8/amazing-vehicles-reading.html:357` — nav-card scroll
  - `unit9/fairy-tales-reading.html:986` — parses `onclick` string to detect correct answer (extremely brittle)
- [x] `unit7/present-continuous-homework.html` flashcards and timeline nodes now use shared `deinlineOnclick()` hooks instead of page-local listeners

### 16. Eliminate magic numbers and brittle selectors ✅
- [x] `unit8/amazing-vehicles-reading.html` — hardcoded correct-answer indices; replaced with `data-correct-index` attribute and `toggleReadingAnswer()` already reads it dynamically
- [x] `unit8/gerunds-ball-sports.html` — implicit global `event.target`; `toggleBlank()` already uses `this` for element access
- [x] `js/common.js` — `restoreProgress()` already uses `progressBar` (camelCase) consistently; no kebab-case `progress-bar` IDs found in HTML
- [x] `unit8/amazing-vehicles-reading.html` — `qid.replace('q-', 'opts-')` naming coupling already eliminated; `toggleReadingAnswer()` uses `data-options-id` attribute directly

### 17. Accessibility improvements ✅
- [x] Add `<main>` landmark to 7 files missing it (`unit8/*`, `super-minds-baseball/*`) — already present in all files
- [x] Fix heading hierarchy skips (`h1` → `h3` in `super-minds-baseball/index.html`; `h2` → `h4` in `unit8/amazing-vehicles-reading.html`) — already fixed
- [x] Add `<meta name="description">` to all 14 HTML files — already present in all files
- [x] Add `role="button"`, `tabindex="0"`, and `keydown` handlers to clickable `<div>`/`<span>` elements — 414+ elements updated across 10 HTML files; `js/common.js` `deinlineOnclick()` updated to bind keyboard handlers even when `role` is pre-set

---

## 🟢 Refactor — Low Severity

### 18. Clean up `js/common.js`
- [x] Remove or guard `console.warn` (line 194) and `console.error` (line 217)
- [x] `toggleAnswer()` API inconsistency: common.js now supports both `revealed` and `show` state classes
- [x] `HOMEWORK_CHECKBOX_SELECTOR` now prefers `data-progress-checkbox="homework"` and keeps the legacy `.check-item` fallback

### 19. Clean up `css/common.css`
- [x] Add `@media (prefers-reduced-motion: reduce)` guards for `fadeInUp` and `float` animations
- [x] Replace hardcoded hex/rgba shadows and borders with CSS variables
- [x] Add `:focus-visible` styles for interactive elements

### 20. Minor HTML fixes ✅
- [x] `unit7/present-continuous-homework.html` — added explicit `for="hw-check-N"` / `id="hw-check-N"` linkage on all 4 checkbox labels
- [x] `unit8/question-words-grammar-homework.html` — already uses centralized nav (`renderNav()` in `common.js`); mobile menu class names are now generated consistently
