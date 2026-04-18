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
grep -l "common.css" index.html unit7/*.html unit8/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f references common.css"
done

grep -l "common.js" index.html unit7/*.html unit8/*.html 2>/dev/null | while read f; do
    echo "   ✓ $f references common.js"
done

# Check Unit 9 index.html has required elements
echo ""
echo "4b. Checking Unit 9 index.html..."
if [ -f "unit9/index.html" ]; then
    if grep -q 'data-answer' "unit9/index.html"; then
        echo "   ✓ unit9/index.html uses data-answer attributes for blanks"
    else
        echo "   ⚠️ unit9/index.html may be missing data-answer attributes"
    fi
    
    if grep -q 'function revealAnswer' "unit9/index.html"; then
        echo "   ✓ revealAnswer() function present"
    else
        echo "   ⚠️ revealAnswer() function may need updating"
    fi
    
    if grep -q 'function toggleTodo' "unit9/index.html"; then
        echo "   ✓ toggleTodo() function present"
    else
        echo "   ⚠️ toggleTodo() function may need updating"
    fi
else
    echo "   ✗ unit9/index.html not found"
fi

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
for file in index.html unit7/*.html unit8/*.html super-minds-baseball/index.html super-minds-baseball/unit7/*.html super-minds-baseball/unit8/*.html; do
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
echo "5b. Checking Unit 9 page navigation links..."
ERRORS=0

for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/amazing-vehicles.html unit8/reading.html unit8/grammar.html; do
    if [ -f "$file" ]; then
        if grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
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
for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/amazing-vehicles.html unit8/grammar.html unit9/index.html; do
    if [ -f "$file" ]; then
        if grep -q 'reading.html' "$file"; then
            echo "   ✓ $file has link to reading.html"
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
echo "7. Checking grammar.html (Unit 8 Homework)..."
ERRORS=0

# Helper function to check content in a file
check_content() {
    local file="$1"
    local pattern="$2"
    local description="$3"
    if grep -q "$pattern" "$file"; then
        echo "   ✓ $description"
    else
        echo "   ✗ $description!"
        ERRORS=$((ERRORS + 1))
    fi
}

# Check grammar.html exists
if [ -f "unit8/grammar.html" ]; then
    echo "   ✓ unit8/grammar.html exists"
    
    # Check for navigation links
    check_content "unit8/grammar.html" 'index.html' "grammar.html has link to index.html"
    check_content "unit8/grammar.html" 'amazing-vehicles.html' "grammar.html has link to amazing-vehicles.html"
    check_content "unit8/grammar.html" 'reading.html' "grammar.html has link to reading.html"
    
    # Check for external CSS/JS files
    check_content "unit8/grammar.html" 'grammar.css' "grammar.html links to grammar.css"
    check_content "unit8/grammar.html" 'grammar.js' "grammar.html links to grammar.js"
    
    # Check for data-original attribute on trans-toggle buttons
    check_content "unit8/grammar.html" 'data-original' "grammar.html uses data-original attributes"
    
    # Check for required sections
    check_content "unit8/grammar.html" 'Grammar Focus' "grammar.html has Grammar Focus section"
    check_content "unit8/grammar.html" 'New Dialogue' "grammar.html has New Dialogue section"
    check_content "unit8/grammar.html" 'Key Vocabulary' "grammar.html has Key Vocabulary section"
    check_content "unit8/grammar.html" 'Sentence Practice' "grammar.html has Sentence Practice section"
    check_content "unit8/grammar.html" 'Complete the Email' "grammar.html has Complete the Email section"
    check_content "unit8/grammar.html" "Today's Todo" "grammar.html has Today's Todo section"
    
    # Check for interactive functions (now in grammar.js)
    check_content "unit8/grammar.js" 'function toggleTrans' "grammar.js has toggleTrans function"
    check_content "unit8/grammar.js" 'function toggleBlank' "grammar.js has toggleBlank function"
    check_content "unit8/grammar.js" 'function speakText' "grammar.js has speakText function"
    check_content "unit8/grammar.js" 'addEventListener' "grammar.js uses addEventListener"
else
    echo "   ✗ unit8/grammar.html not found!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "8. Checking grammar.html navigation links from other pages..."
ERRORS=0

# Check that grammar.html is linked from all relevant pages
for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/reading.html unit8/amazing-vehicles.html unit8/grammar.html unit9/index.html; do
    if [ -f "$file" ]; then
        if grep -q 'grammar.html' "$file"; then
            echo "   ✓ $file has link to grammar.html"
        else
            echo "   ✗ $file missing link to grammar.html!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "9. Checking unit9/index.html navigation links from other pages..."
ERRORS=0

# Check that unit9 is linked from all relevant pages
for file in index.html unit7/index.html unit7/homework.html unit8/index.html unit8/reading.html unit8/amazing-vehicles.html unit8/grammar.html; do
    if [ -f "$file" ]; then
        if grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "10. Checking super-minds-baseball pages link to unit9..."
ERRORS=0

for file in super-minds-baseball/index.html super-minds-baseball/unit7/index.html super-minds-baseball/unit7/homework.html super-minds-baseball/unit8/index.html; do
    if [ -f "$file" ]; then
        if grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
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
echo "3. Test the new grammar page: http://localhost:8000/unit8/grammar.html"
echo "4. Test the reading page: http://localhost:8000/unit8/reading.html"
echo "5. Test the Unit 9 page: http://localhost:8000/unit9/index.html"
echo "6. Follow TESTING.md checklist"
