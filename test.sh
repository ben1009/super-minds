#!/bin/bash
# Quick test script for refactoring

echo "=== Super Minds Refactoring Test ==="
echo ""

# Check shared files exist
echo "1. Checking shared files..."
[ -f "css/common.css" ] && echo "   ✓ css/common.css exists" || echo "   ✗ css/common.css missing"
[ -f "js/common.js" ] && echo "   ✓ js/common.js exists" || echo "   ✗ js/common.js missing"
[ -f "ga.js" ] && echo "   ✓ ga.js exists" || echo "   ✗ ga.js missing"
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

echo ""
echo "3. Checking baseball folder uses ../ga.js..."
grep -l "../ga.js" super-minds-baseball/*.html super-minds-baseball/*/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f uses ../ga.js"
done

echo ""
echo "4. Checking favicon on all pages..."
ERRORS=0
for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/amazing-vehicles.html; do
    if grep -q 'rel="icon"' "$file"; then
        echo "   ✓ $file has favicon"
    else
        echo "   ✗ $file missing favicon!"
        ERRORS=$((ERRORS + 1))
    fi
done
for file in super-minds-baseball/index.html super-minds-baseball/unit7/index.html super-minds-baseball/unit7/homework.html super-minds-baseball/unit8/index.html; do
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
echo "=== Test Complete ==="
echo ""
echo "Next steps:"
echo "1. Start a local server: python3 -m http.server 8000"
echo "2. Open http://localhost:8000"
echo "3. Follow TESTING.md checklist"
