# Testing Guide for Refactoring

This guide helps verify that the refactoring didn't break any functionality.

## Automated Testing (GitHub Actions)

The project includes GitHub Actions workflows for automated testing:

### Workflows

| Workflow | File | Description |
|----------|------|-------------|
| **Quick Validation** | `.github/workflows/quick-test.yml` | Fast checks on every push/PR |
| **Full CI** | `.github/workflows/ci.yml` | Comprehensive test suite |
| **Browser Tests** | `.github/workflows/browser-tests.yml` | Playwright E2E, Lighthouse CI, Visual Regression |
| **Unit 8 Reading** | `.github/workflows/unit8-reading-test.yml` | Specific tests for Unit 8 Reading page functionality |
| **Unit 9 Grammar** | `.github/workflows/unit9-test.yml` | Specific tests for Unit 9 Grammar page functionality |

### Quick Validation Tests

Runs on every push to master/main and on pull requests:

- ✅ Required files exist (index.html, ga.js, css/common.css, js/common.js)
- ✅ Duplicate ga.js removed from baseball folder
- ✅ All pages reference shared CSS/JS correctly
- ✅ Baseball pages use correct `../ga.js` path
- ✅ HTML has proper DOCTYPE and viewport meta
- ✅ All pages have favicon (`<link rel="icon">`)

### Full CI Tests

Comprehensive testing including:

- **File Structure Validation** - All required files present
- **HTML Validation** - Using html-validate
- **CSS Validation** - Using stylelint
- **JavaScript Validation** - Using ESLint
- **Link Checking** - Internal link validation
- **Functional Tests** - Using Puppeteer for browser automation
- **Accessibility Checks** - Semantic HTML validation

### Running Tests Locally

You can run the same checks locally:

```bash
# Run the quick validation script
./test.sh

# Or manually check with these commands:

# Check required files
ls -la index.html ga.js css/common.css js/common.js

# Check for duplicate ga.js
ls super-minds-baseball/ga.js 2>/dev/null && echo "FAIL: Duplicate exists" || echo "PASS: No duplicate"

# Check shared resource references
grep "common.css" index.html unit7/*.html
grep "common.js" index.html unit7/*.html
```

---

## Manual Testing

### Quick Start

> **Note:** Replace `<project-root>` with your actual project directory path (e.g., `~/projects/super-minds` or `C:\Users\YourName\projects\super-minds`)

Start a local server to test the pages:

```bash
# Navigate to project root (change to your actual path)
cd <project-root>

# Using Python 3
python3 -m http.server 8000

# Or using Node.js (if installed)
npx serve .

# Or using PHP (if installed)
php -S localhost:8000
```

Then open http://localhost:8000 in your browser.

---

## Testing Checklist

### ✅ Phase 1: GA Script Consolidation & Favicon

- [ ] Open browser DevTools (F12) → Network tab
- [ ] Visit http://localhost:8000/super-minds-baseball/
- [ ] Verify `ga.js` loads from `../ga.js` (not `ga.js`)
- [ ] No 404 errors for ga.js in console

**Favicon Check:**
- [ ] Browser tab shows 🧠 icon on homepage
- [ ] Browser tab shows 🧠 icon on Unit 7 page
- [ ] Browser tab shows 🧠 icon on Unit 8 page
- [ ] Browser tab shows 🧠 icon on all baseball pages

**Verify in HTML:**
```bash
# Check all pages have favicon
grep -l 'rel="icon"' index.html unit7/*.html unit8/*.html super-minds-baseball/*.html super-minds-baseball/*/*.html
```

**Files to check:**
- `/super-minds-baseball/index.html`
- `/super-minds-baseball/unit7/index.html`
- `/super-minds-baseball/unit7/homework.html`
- `/super-minds-baseball/unit8/index.html`

---

### ✅ Phase 2: Shared CSS

**Visual Check - Main Site:**
- [ ] http://localhost:8000/ - Homepage loads with correct gradient background
- [ ] http://localhost:8000/unit7/index.html - Unit 7 page has correct styling
- [ ] http://localhost:8000/unit7/homework.html - Homework page has correct styling
- [ ] Animations work: `.animate-fade-in` elements fade in on load
- [ ] Cards have hover effects: `.card-hover` elements lift on hover

**Check for CSS errors:**
```javascript
// In browser console, check if common.css is loaded
document.querySelector('link[href*="common.css"]')
```

**Specific elements to verify:**
- [ ] Body has gradient background (sky blue → green)
- [ ] `.ink-gradient` headers have orange/red gradient
- [ ] `.glass-card` elements have glass effect with border
- [ ] `.unit-badge` has rotation and border

---

### ✅ Phase 3 & 5: Shared JavaScript / Toggle Functions

**Navigation Testing:**
- [ ] Resize browser to mobile width (< 768px)
- [ ] Click hamburger menu (☰) - menu opens
- [ ] Click again - menu closes
- [ ] Resize to desktop - mobile menu is hidden

**Unit 7 Page (/unit7/index.html):**
- [ ] Quiz items: Click any quiz question → answer expands
- [ ] Click again → answer collapses
- [ ] Chevron icon rotates when expanded
- [ ] Story translation: Click story paragraph → translation shows
- [ ] Comprehension questions: Click question → answer shows
- [ ] Cloze test: Click blanks → dropdown appears
- [ ] Check Answers button works

**Homework Page (/unit7/homework.html):**
- [ ] Tab switching: Click "否定句", "疑问句" tabs
- [ ] Flashcards: Click to flip
- [ ] Timeline: Click nodes to expand/collapse
- [ ] Answer masks: Click to reveal answers
- [ ] Checkboxes: Check items → progress bar updates
- [ ] Refresh page → progress is restored
- [ ] Copy dialogue button works

**Console Check:**
```javascript
// Should not show any errors like:
// "toggleMobileMenu is not defined"
// "cannot read property of undefined"
```

---

### ✅ Phase 6: Icon Initialization

- [ ] All Lucide icons display correctly (book-open, menu, chevrons)
- [ ] No broken icon placeholders visible
- [ ] Icons in navigation bar load properly

**Check in console:**
```javascript
// Should return an array of icon elements
document.querySelectorAll('[data-lucide]')
```

---

### ✅ Cross-Page Navigation

Test all links work correctly:

**From Homepage (index.html):**
- [ ] Unit 7 card → /unit7/index.html
- [ ] Unit 8 card → /unit8/index.html
- [ ] Homework card → /unit7/homework.html

**From Unit 7:**
- [ ] Nav: "首页 Home" → /
- [ ] Nav: "Unit 8" → /unit8/index.html
- [ ] Nav: "作业 Homework" → /unit7/homework.html

**From Homework:**
- [ ] Nav: "Unit 7" → /unit7/index.html

**From Unit 9:**
- [ ] Nav: "首页 Home" → /
- [ ] Nav: "Unit 7" → /unit7/index.html
- [ ] Nav: "Unit 8" → /unit8/index.html
- [ ] Blank toggle: Click blank → answer reveals
- [ ] Answer table toggle: Click button → answer table shows
- [ ] Todo toggle: Click task → marked completed

---

### ✅ Unit 9 Page (/unit9/index.html)

- [ ] Page loads with correct title "Unit 9 · 假期计划语法"
- [ ] 3 grammar cards displayed (It's time for..., Can I..., be going to...)
- [ ] 5 vocabulary cards with pronunciation icons
- [ ] Grammar summary table (Page 109) displays correctly
- [ ] Two dialogue fill-in-the-blank exercises present (≥30 blanks)
- [ ] Click blank → answer reveals, click again → hides
- [ ] Answer table toggle buttons work
- [ ] 4 todo items present, click to mark complete
- [ ] Navigation links to Unit 7 and Unit 8 work

---

### ✅ Baseball Section

- [ ] http://localhost:8000/super-minds-baseball/ - loads correctly
- [ ] Navigation works between baseball pages
- [ ] Styling is correct (baseball theme preserved)

---

## Automated Testing Script

Run this in browser console on each page:

```javascript
// Test 1: Check shared resources loaded
function testSharedResources() {
    const cssLoaded = !!document.querySelector('link[href*="common.css"]');
    const jsLoaded = typeof toggleMobileMenu === 'function';
    console.log('✓ CSS common.css:', cssLoaded);
    console.log('✓ JS common.js:', jsLoaded);
    return cssLoaded && jsLoaded;
}

// Test 2: Check toggle functions exist
function testToggleFunctions() {
    const functions = [
        'toggleMobileMenu',
        'toggleQuizAnswer', 
        'toggleTranslation',
        'toggleCompAnswer',
        'toggleAnswer',
        'toggleTimeline',
        'switchTab'
    ];
    
    functions.forEach(fn => {
        const exists = typeof window[fn] === 'function';
        console.log(`${exists ? '✓' : '✗'} ${fn}()`);
    });
}

// Test 3: Check Lucide icons
function testIcons() {
    const icons = document.querySelectorAll('[data-lucide]');
    console.log(`✓ Found ${icons.length} Lucide icon elements`);
    return icons.length > 0;
}

// Run all tests
console.log('=== Running Tests ===');
testSharedResources();
testToggleFunctions();
testIcons();
console.log('=== Tests Complete ===');
```

---

## Regression Testing

Compare before/after behavior:

| Feature | Before | After |
|---------|--------|-------|
| Page load | Works | Should work identically |
| Mobile menu | Works | Should work identically |
| Quiz toggles | Works | Should work identically |
| Progress save | Works | Should work identically |
| Icons display | Works | Should work identically |

---

## Common Issues & Fixes

### Issue: "toggleMobileMenu is not defined"
**Fix:** Ensure `js/common.js` is loaded before any inline scripts that use it.

### Issue: Icons not showing
**Fix:** Check that `lucide@latest` script is loaded and `initCommon()` runs.

### Issue: Styles missing
**Fix:** Verify `css/common.css` is loaded and `sm-body` class is on `<body>`.

### Issue: 404 for ga.js
**Fix:** Check that baseball pages use `../ga.js` not `ga.js`.

---

## Browser Testing Matrix

Test on at least:
- [ ] Chrome/Edge (Chromium)
- [ ] Firefox
- [ ] Safari (if on Mac)
- [ ] Mobile viewport (Chrome DevTools)
