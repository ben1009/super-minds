#!/bin/bash
# Quick test script for refactoring

echo "=== Super Minds Refactoring Test ==="
echo ""

# Check shared files exist
echo "1. Checking shared files..."
[ -f "css/common.css" ] && echo "   ✓ css/common.css exists" || echo "   ✗ css/common.css missing"
[ -f "js/common.js" ] && echo "   ✓ js/common.js exists" || echo "   ✗ js/common.js missing"
[ -f "ga.js" ] && echo "   ✓ ga.js exists" || echo "   ✗ ga.js missing"
[ -f "favicon.svg" ] && echo "   ✓ favicon.svg exists" || echo "   ✗ favicon.svg missing"
[ ! -f "super-minds-baseball/ga.js" ] && echo "   ✓ Duplicate ga.js removed" || echo "   ✗ Duplicate ga.js still exists"

echo ""
echo "2. Checking file references..."

# Check HTML files reference shared CSS/JS
grep -l "common.css" index.html unit7/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f references common.css"
done

grep -l "common.js" index.html unit7/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f references common.js"
done

# Check Unit 8 reading.html has required elements
echo ""
echo "5. Checking Unit 8 reading.html..."
if [ -f "unit8/reading.html" ]; then
    if grep -q 'data-correct-option' "unit8/reading.html"; then
        echo "   ✓ reading.html uses data-correct-option attributes"
    else
        echo "   ⚠️ reading.html may be missing data-correct-option attributes"
    fi
    
    if grep -q 'function speak(text, cardElement)' "unit8/reading.html"; then
        echo "   ✓ speak() function has cardElement parameter"
    else
        echo "   ⚠️ speak() function may need updating"
    fi
    
    if grep -q '<button type="button"' "unit8/reading.html"; then
        echo "   ✓ reading.html uses semantic button elements"
    else
        echo "   ⚠️ reading.html may not use button elements"
    fi
else
    echo "   ✗ unit8/reading.html not found"
fi

echo ""
echo "3. Checking baseball folder uses ../ga.js..."
grep -l "../ga.js" super-minds-baseball/*.html super-minds-baseball/*/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f uses ../ga.js"
done

echo ""
echo "4. Checking favicon on all pages..."
ERRORS=0

# Combined loop for all HTML files
for file in index.html unit7/*.html unit8/*.html unit8/reading.html super-minds-baseball/index.html super-minds-baseball/unit7/*.html super-minds-baseball/unit8/*.html; do
    if [ -f "$file" ]; then
        if grep -q 'rel="icon"' "$file"; then
            echo "   ✓ $file has favicon"
        else
            echo "   ✗ $file missing favicon!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "6. Checking reading page navigation links..."
ERRORS=0

# Check that reading.html is linked from all relevant pages
for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/amazing-vehicles.html; do
    if [ -f "$file" ]; then
        if grep -q 'reading.html' "$file"; then
            echo "   ✓ $f has link to reading.html"
        else
            echo "   ✗ $file missing link to reading.html!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "=== Test Complete ==="
echo ""
echo "Next steps:"
echo "1. Start a local server: python3 -m http.server 8000"
echo "2. Open http://localhost:8000"
echo "3. Test the new reading page: http://localhost:8000/unit8/reading.html"
echo "4. Follow TESTING.md checklist"
