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

# Check navigation extraction
echo ""
echo "2b. Checking navigation extraction..."
ERRORS=0

if grep -q 'function renderNav' js/common.js; then
    echo "   ✓ js/common.js has renderNav() function"
else
    echo "   ✗ js/common.js missing renderNav() function!"
    ERRORS=$((ERRORS + 1))
fi

for file in unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html unit9/holiday-plans-grammar-review.html unit9/fairy-tales-reading.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $f has NAV_CONFIG"
        else
            echo "   ✗ $f missing NAV_CONFIG!"
            ERRORS=$((ERRORS + 1))
        fi
        
        if grep -q 'id="site-nav"' "$file"; then
            echo "   ✓ $f has site-nav container"
        else
            echo "   ✗ $f missing site-nav container!"
            ERRORS=$((ERRORS + 1))
        fi
        
        # Verify old inline nav is removed
        if grep -q '<nav class="sticky top-0' "$file" || grep -q '<nav class="bg-red-800' "$file"; then
            echo "   ✗ $f still has old inline nav!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

# Check Unit 9 index.html has required elements
echo ""
echo "4b. Checking Unit 9 index.html..."
if [ -f "unit9/holiday-plans-grammar-review.html" ]; then
    if grep -q 'data-answer' "unit9/holiday-plans-grammar-review.html"; then
        echo "   ✓ unit9/holiday-plans-grammar-review.html uses data-answer attributes for blanks"
    else
        echo "   ⚠️ unit9/holiday-plans-grammar-review.html may be missing data-answer attributes"
    fi
    
    if grep -q 'window.revealAnswer' "js/common.js"; then
        echo "   ✓ revealAnswer() function present in common.js"
    else
        echo "   ⚠️ revealAnswer() function may need updating"
    fi
    
    if grep -q 'toggleTodoItem' "js/common.js"; then
        echo "   ✓ toggleTodoItem() available in common.js"
    else
        echo "   ⚠️ toggleTodoItem() may need updating"
    fi
else
    echo "   ✗ unit9/holiday-plans-grammar-review.html not found"
fi

# Check Unit 9 fairy-tales.html
echo ""
echo "4c. Checking Unit 9 fairy-tales.html..."
if [ -f "unit9/fairy-tales-reading.html" ]; then
    echo "   ✓ unit9/fairy-tales-reading.html exists"
    
    if grep -q 'fairy tale' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has Fairy Tales vocabulary"
    else
        echo "   ✗ fairy-tales.html missing Fairy Tales vocabulary!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'on holiday' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has Reading on Holiday vocabulary"
    else
        echo "   ✗ fairy-tales.html missing Reading on Holiday vocabulary!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'Folk Tales Around the World' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has Reading Passage A"
    else
        echo "   ✗ fairy-tales.html missing Reading Passage A!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'Reading on Holiday' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has Reading Passage B"
    else
        echo "   ✗ fairy-tales.html missing Reading Passage B!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'function showQuizAnswer' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has showQuizAnswer() function"
    else
        echo "   ✗ fairy-tales.html missing showQuizAnswer() function!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'window.revealAnswer' "js/common.js"; then
        echo "   ✓ fairy-tales.html can use revealAnswer() from common.js"
    else
        echo "   ✗ fairy-tales.html missing revealAnswer() function!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'window.toggleTranslation' "js/common.js"; then
        echo "   ✓ fairy-tales.html can use toggleTranslation() from common.js"
    else
        echo "   ✗ fairy-tales.html missing toggleTranslation() function!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'window.speak' "js/common.js"; then
        echo "   ✓ speak() function available in common.js with cardElement"
    else
        echo "   ✗ speak() function missing from common.js!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'toggleTodoItem' "js/common.js"; then
        echo "   ✓ toggleTodoItem() available in common.js"
    else
        echo "   ✗ toggleTodoItem() missing from common.js!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'data-answer' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html uses data-answer attributes"
    else
        echo "   ✗ fairy-tales.html missing data-answer attributes!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'word-quiz-blank' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has word quiz blanks"
    else
        echo "   ✗ fairy-tales.html missing word quiz blanks!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'quiz-option' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has quiz options"
    else
        echo "   ✗ fairy-tales.html missing quiz options!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'reading-card' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html uses reading-card class"
    else
        echo "   ✗ fairy-tales.html missing reading-card class!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q 'leather-card' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html uses leather-card class"
    else
        echo "   ✗ fairy-tales.html missing leather-card class!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q "Today's Todo" "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html has Today's Todo section"
    else
        echo "   ✗ fairy-tales.html missing Today's Todo section!"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q '../ga.js' "unit9/fairy-tales-reading.html"; then
        echo "   ✓ fairy-tales.html uses ../ga.js"
    else
        echo "   ✗ fairy-tales.html not using ../ga.js!"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "   ✗ unit9/fairy-tales-reading.html not found!"
    ERRORS=$((ERRORS + 1))
fi

# Check Unit 8 reading.html has required elements
echo ""
echo "5. Checking Unit 8 fun-things-we-do-reading.html..."
if [ -f "unit8/fun-things-we-do-reading.html" ]; then
    if grep -q 'data-correct-option' "unit8/fun-things-we-do-reading.html"; then
        echo "   ✓ fun-things-we-do-reading.html uses data-correct-option attributes"
    else
        echo "   ⚠️ fun-things-we-do-reading.html may be missing data-correct-option attributes"
    fi
    
    if grep -q 'window.speak' "js/common.js"; then
        echo "   ✓ speak() function available in common.js with cardElement"
    else
        echo "   ⚠️ speak() function may need updating"
    fi
    
    if grep -q '<button type="button"' "unit8/fun-things-we-do-reading.html"; then
        echo "   ✓ reading.html uses semantic button elements"
    else
        echo "   ⚠️ reading.html may not use button elements"
    fi
else
    echo "   ✗ unit8/fun-things-we-do-reading.html not found"
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
for file in index.html unit7/*.html unit8/*.html unit9/*.html super-minds-baseball/index.html super-minds-baseball/unit7/*.html super-minds-baseball/unit8/*.html; do
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

# For pages with NAV_CONFIG, links are in common.js
for file in index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        elif grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Verify common.js has unit9 links
if grep -q 'unit9' js/common.js; then
    echo "   ✓ js/common.js contains unit9 navigation links"
else
    echo "   ✗ js/common.js missing unit9 navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "5c. Checking fairy-tales.html navigation links from all pages..."
ERRORS=0

for file in index.html unit9/holiday-plans-grammar-review.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        else
            count=$(grep -c 'fairy-tales' "$file")
            if [ "$count" -eq 0 ]; then
                echo "   ✗ $file missing link to fairy-tales.html!"
                ERRORS=$((ERRORS + 1))
            elif [ "$count" -gt 2 ]; then
                echo "   ✗ $file has $count fairy-tales links (expected max 2)!"
                ERRORS=$((ERRORS + 1))
            else
                echo "   ✓ $file has link to fairy-tales.html ($count refs)"
            fi
        fi
    fi
done

# Verify common.js has fairy-tales links
if grep -q 'fairy-tales' js/common.js; then
    echo "   ✓ js/common.js contains fairy-tales navigation links"
else
    echo "   ✗ js/common.js missing fairy-tales navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "5d. Checking super-minds-baseball pages link to fairy-tales..."
ERRORS=0

for file in super-minds-baseball/index.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        else
            count=$(grep -c 'fairy-tales' "$file")
            if [ "$count" -eq 0 ]; then
                echo "   ✗ $file missing link to fairy-tales.html!"
                ERRORS=$((ERRORS + 1))
            elif [ "$count" -gt 2 ]; then
                echo "   ✗ $file has $count fairy-tales links (expected max 2)!"
                ERRORS=$((ERRORS + 1))
            else
                echo "   ✓ $file has link to fairy-tales.html ($count refs)"
            fi
        fi
    fi
done

# Verify common.js has fairy-tales links for baseball pages
if grep -q 'fairy-tales' js/common.js; then
    echo "   ✓ js/common.js contains fairy-tales navigation links"
else
    echo "   ✗ js/common.js missing fairy-tales navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "6. Checking reading page navigation links..."
ERRORS=0

# Check that reading.html is linked from all relevant pages
for file in index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/question-words-grammar-homework.html unit9/holiday-plans-grammar-review.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        elif grep -q 'fun-things-we-do-reading.html' "$file"; then
            echo "   ✓ $file has link to fun-things-we-do-reading.html"
        else
            echo "   ✗ $file missing link to reading.html!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Verify common.js has reading page links
if grep -q 'fun-things-we-do-reading.html' js/common.js; then
    echo "   ✓ js/common.js contains fun-things-we-do-reading.html navigation links"
else
    echo "   ✗ js/common.js missing fun-things-we-do-reading.html navigation links!"
    ERRORS=$((ERRORS + 1))
fi

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
if [ -f "unit8/question-words-grammar-homework.html" ]; then
    echo "   ✓ unit8/question-words-grammar-homework.html exists"
    
    # Check for navigation links (inline or centralized)
    if grep -q 'window.NAV_CONFIG' "unit8/question-words-grammar-homework.html"; then
        echo "   ✓ question-words-grammar-homework.html uses centralized nav"
    else
        check_content "unit8/question-words-grammar-homework.html" 'index.html' "question-words-grammar-homework.html has link to index.html"
        check_content "unit8/question-words-grammar-homework.html" 'amazing-vehicles-reading.html' "question-words-grammar-homework.html has link to amazing-vehicles-reading.html"
        check_content "unit8/question-words-grammar-homework.html" 'fun-things-we-do-reading.html' "question-words-grammar-homework.html has link to fun-things-we-do-reading.html"
    fi
    
    # Check for external CSS/JS files
    check_content "unit8/question-words-grammar-homework.html" 'grammar.css' "grammar.html links to grammar.css"
    check_content "unit8/question-words-grammar-homework.html" 'grammar.js' "grammar.html links to grammar.js"
    
    # Check for data-original attribute on trans-toggle buttons
    check_content "unit8/question-words-grammar-homework.html" 'data-original' "grammar.html uses data-original attributes"
    
    # Check for required sections
    check_content "unit8/question-words-grammar-homework.html" 'Grammar Focus' "grammar.html has Grammar Focus section"
    check_content "unit8/question-words-grammar-homework.html" 'New Dialogue' "grammar.html has New Dialogue section"
    check_content "unit8/question-words-grammar-homework.html" 'Key Vocabulary' "grammar.html has Key Vocabulary section"
    check_content "unit8/question-words-grammar-homework.html" 'Sentence Practice' "grammar.html has Sentence Practice section"
    check_content "unit8/question-words-grammar-homework.html" 'Complete the Email' "grammar.html has Complete the Email section"
    check_content "unit8/question-words-grammar-homework.html" "Today's Todo" "grammar.html has Today's Todo section"
    
    # Check for interactive functions (now in grammar.js)
    check_content "unit8/grammar.js" 'function toggleTrans' "grammar.js has toggleTrans function"
    check_content "unit8/grammar.js" 'function toggleBlank' "grammar.js has toggleBlank function"
    check_content "unit8/grammar.js" 'function speakText' "grammar.js has speakText function"
    check_content "unit8/grammar.js" 'addEventListener' "grammar.js uses addEventListener"
else
    echo "   ✗ unit8/question-words-grammar-homework.html not found!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "8. Checking grammar.html navigation links from other pages..."
ERRORS=0

# Check that grammar.html is linked from all relevant pages
for file in index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/fun-things-we-do-reading.html unit8/amazing-vehicles-reading.html unit8/question-words-grammar-homework.html unit9/holiday-plans-grammar-review.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        elif grep -q 'question-words-grammar-homework.html' "$file"; then
            echo "   ✓ $file has link to question-words-grammar-homework.html"
        else
            echo "   ✗ $file missing link to grammar.html!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Verify common.js has grammar page links
if grep -q 'question-words-grammar-homework.html' js/common.js; then
    echo "   ✓ js/common.js contains question-words-grammar-homework.html navigation links"
else
    echo "   ✗ js/common.js missing question-words-grammar-homework.html navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "9. Checking unit9/holiday-plans-grammar-review.html navigation links from other pages..."
ERRORS=0

# Check that unit9 is linked from all relevant pages
for file in index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/fun-things-we-do-reading.html unit8/amazing-vehicles-reading.html unit8/question-words-grammar-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        elif grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Verify common.js has unit9 links
if grep -q 'unit9' js/common.js; then
    echo "   ✓ js/common.js contains unit9 navigation links"
else
    echo "   ✗ js/common.js missing unit9 navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "10. Checking super-minds-baseball pages link to unit9..."
ERRORS=0

for file in super-minds-baseball/index.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; do
    if [ -f "$file" ]; then
        if grep -q 'window.NAV_CONFIG' "$file"; then
            echo "   ✓ $file uses centralized nav (common.js)"
        elif grep -q 'unit9' "$file"; then
            echo "   ✓ $file has link to unit9"
        else
            echo "   ✗ $file missing link to unit9!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# Verify common.js has unit9 links for baseball pages
if grep -q 'unit9' js/common.js; then
    echo "   ✓ js/common.js contains unit9 navigation links"
else
    echo "   ✗ js/common.js missing unit9 navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "11. Checking index.html has fairy-tales card and quick link..."
ERRORS=0

if grep -q 'unit9/fairy-tales-reading.html' "index.html"; then
    echo "   ✓ index.html links to fairy-tales.html"
else
    echo "   ✗ index.html missing link to fairy-tales.html!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q '童话故事' "index.html"; then
    echo "   ✓ index.html has 童话故事 card text"
else
    echo "   ✗ index.html missing 童话故事 card text!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q 'Fairy Tales' "index.html"; then
    echo "   ✓ index.html has Fairy Tales card text"
else
    echo "   ✗ index.html missing Fairy Tales card text!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "12. Checking unit9/holiday-plans-grammar-review.html has fairy-tales in nav dropdown..."
ERRORS=0

if grep -q 'window.NAV_CONFIG' "unit9/holiday-plans-grammar-review.html"; then
    echo "   ✓ unit9/holiday-plans-grammar-review.html uses centralized nav"
elif grep -q 'fairy-tales-reading.html' "unit9/holiday-plans-grammar-review.html"; then
    echo "   ✓ unit9/holiday-plans-grammar-review.html has fairy-tales nav link"
else
    echo "   ✗ unit9/holiday-plans-grammar-review.html missing fairy-tales nav link!"
    ERRORS=$((ERRORS + 1))
fi

# Verify common.js has fairy-tales links
if grep -q 'fairy-tales' js/common.js; then
    echo "   ✓ js/common.js contains fairy-tales navigation links"
else
    echo "   ✗ js/common.js missing fairy-tales navigation links!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "13. Checking TODO section consistency across all pages..."
ERRORS=0

for file in unit8/question-words-grammar-homework.html unit8/fun-things-we-do-reading.html unit9/holiday-plans-grammar-review.html unit9/fairy-tales-reading.html unit8/amazing-vehicles-reading.html; do
    if [ -f "$file" ]; then
        # Check data-todo attributes
        if grep -q 'data-todo' "$file"; then
            echo "   ✓ $file has data-todo attributes"
        else
            echo "   ✗ $file missing data-todo attributes!"
            ERRORS=$((ERRORS + 1))
        fi
        
        # Check localStorage persistence (grammar.html uses grammar.js)
        if [ "$file" = "unit8/question-words-grammar-homework.html" ]; then
            if grep -q 'localStorage' unit8/grammar.js; then
                echo "   ✓ $file uses localStorage (in grammar.js)"
            else
                echo "   ✗ $file missing localStorage!"
                ERRORS=$((ERRORS + 1))
            fi
        elif grep -q 'localStorage' "$file"; then
            echo "   ✓ $file uses localStorage"
        else
            echo "   ✗ $file missing localStorage!"
            ERRORS=$((ERRORS + 1))
        fi
        
        # Check progressBar
        if grep -q 'progressBar' "$file"; then
            echo "   ✓ $file has progressBar"
        else
            echo "   ✗ $file missing progressBar!"
            ERRORS=$((ERRORS + 1))
        fi
        
        # Check resetTodoItems function (renamed from resetTodos)
        if grep -q 'resetTodoItems' "$file"; then
            echo "   ✓ $file has resetTodoItems"
        else
            echo "   ✗ $file missing resetTodoItems!"
            ERRORS=$((ERRORS + 1))
        fi
        
        # Check NO old .checked pattern
        if grep -q '\.checked' "$file"; then
            echo "   ✗ $file still uses old .checked pattern!"
            ERRORS=$((ERRORS + 1))
        else
            echo "   ✓ $file clean (no .checked)"
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "14. Checking width consistency (no max-w-4xl in content sections)..."
ERRORS=0

# Check unit8/gerunds-ball-sports.html content sections are full width
if grep -q 'leather-card.*max-w-4xl.*mx-auto' unit8/gerunds-ball-sports.html; then
    echo "   ✗ unit8/gerunds-ball-sports.html still has max-w-4xl content sections!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ unit8/gerunds-ball-sports.html content sections are full width"
fi

# Check unit8/amazing-vehicles-reading.html content sections are full width
if grep -q 'leather-card.*max-w-4xl.*mx-auto' unit8/amazing-vehicles-reading.html; then
    echo "   ✗ unit8/amazing-vehicles-reading.html still has max-w-4xl content sections!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ unit8/amazing-vehicles-reading.html content sections are full width"
fi

# Check super-minds-baseball/unit8/baseball-gerunds-ball-sports.html content sections are full width
if grep -q 'leather-card.*max-w-4xl.*mx-auto' super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; then
    echo "   ✗ super-minds-baseball/unit8/baseball-gerunds-ball-sports.html still has max-w-4xl content sections!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ super-minds-baseball/unit8/baseball-gerunds-ball-sports.html content sections are full width"
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "15. Checking index.html card badge consistency..."
ERRORS=0

# Count badges using unit-badge vs inline gradients
unit_badge_count=$(grep -c 'class="unit-badge' index.html)
gradient_count=$(grep -c 'bg-gradient-to-r' index.html)

if [ "$gradient_count" -eq 0 ]; then
    echo "   ✓ All index.html cards use unit-badge ($unit_badge_count badges)"
else
    echo "   ✗ index.html has $gradient_count cards with inline gradients instead of unit-badge!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "16. Checking fun-things-we-do-reading.html todo matches fairy-tales.html pattern..."
ERRORS=0

# Check reading.html todo items use bg-white rounded-xl pattern
if grep -q 'todo-item bg-white rounded-xl' unit8/fun-things-we-do-reading.html; then
    echo "   ✓ fun-things-we-do-reading.html todo items use fairy-tales pattern"
else
    echo "   ✗ fun-things-we-do-reading.html todo items missing bg-white rounded-xl pattern!"
    ERRORS=$((ERRORS + 1))
fi

# Check reading.html todo items do NOT use reading-card class
if grep -q 'reading-card.*todo-item' unit8/fun-things-we-do-reading.html; then
    echo "   ✗ reading.html todo items still use reading-card class!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ reading.html todo items clean (no reading-card)"
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "17. Checking amazing-vehicles.html vocabulary has leather-card wrapper..."
ERRORS=0

# Check Task 1 vocabulary has leather-card wrapper
if grep -A10 'id="vocab"' unit8/amazing-vehicles-reading.html | grep -q 'leather-card'; then
    echo "   ✓ Task 1 vocabulary has leather-card wrapper"
else
    echo "   ✗ Task 1 vocabulary missing leather-card wrapper!"
    ERRORS=$((ERRORS + 1))
fi

# Check Extra vocabulary has leather-card wrapper
if grep -A10 'id="extra-vocab"' unit8/amazing-vehicles-reading.html | grep -q 'leather-card'; then
    echo "   ✓ Extra vocabulary has leather-card wrapper"
else
    echo "   ✗ Extra vocabulary missing leather-card wrapper!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "18. Checking main container width consistency across all pages..."
ERRORS=0

# All content pages should use max-w-6xl as main container
for file in index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/question-words-grammar-homework.html unit8/fun-things-we-do-reading.html unit9/holiday-plans-grammar-review.html unit9/fairy-tales-reading.html super-minds-baseball/index.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; do
    if [ -f "$file" ]; then
        # Check that the main content container uses max-w-6xl
        if grep -q 'max-w-6xl.*mx-auto' "$file"; then
            echo "   ✓ $file uses max-w-6xl main container"
        else
            echo "   ✗ $file missing max-w-6xl main container!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "19. Checking refactor deduplication completeness..."
ERRORS=0

# common.js: new shared functions
if grep -q 'window.toggleReveal' js/common.js; then
    echo "   ✓ toggleReveal() extracted to common.js"
else
    echo "   ✗ toggleReveal() missing from common.js!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q 'window.revealAnswer' js/common.js; then
    echo "   ✓ revealAnswer() extracted to common.js"
else
    echo "   ✗ revealAnswer() missing from common.js!"
    ERRORS=$((ERRORS + 1))
fi

# common.js: no typeof guard on canonical functions
if grep -q 'typeof toggleAnswer' js/common.js; then
    echo "   ✗ toggleAnswer() still has typeof guard in common.js!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ toggleAnswer() has no typeof guard"
fi

if grep -q 'typeof revealAnswer' js/common.js; then
    echo "   ✗ revealAnswer() still has typeof guard in common.js!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ revealAnswer() has no typeof guard"
fi

# common.js: speak() uses generic .speaking selector
if grep -q "'\.speaking'" js/common.js; then
    echo "   ✓ speak() uses generic '.speaking' selector"
else
    echo "   ✗ speak() missing generic '.speaking' selector!"
    ERRORS=$((ERRORS + 1))
fi

# common.js: toggleTranslation uses toggleVisibility
if grep -q 'toggleVisibility(trans' js/common.js; then
    echo "   ✓ toggleTranslation() reuses toggleVisibility utility"
else
    echo "   ✗ toggleTranslation() not reusing toggleVisibility!"
    ERRORS=$((ERRORS + 1))
fi

# common.js: toggleTranslation uses textContent not innerHTML
if grep -A3 'if (hint)' js/common.js | grep -q 'textContent'; then
    echo "   ✓ toggleTranslation() uses textContent for hints"
else
    echo "   ✗ toggleTranslation() not using textContent for hints!"
    ERRORS=$((ERRORS + 1))
fi

# CSS: .translation-animated class exists
if grep -q '\.translation\.translation-animated' css/baseball-theme.css; then
    echo "   ✓ .translation-animated class exists in baseball-theme.css"
else
    echo "   ✗ .translation-animated class missing from baseball-theme.css!"
    ERRORS=$((ERRORS + 1))
fi

# HTML: no inline toggleTranslation remaining
for file in unit8/fun-things-we-do-reading.html unit9/fairy-tales-reading.html; do
    if [ -f "$file" ]; then
        if grep -q 'function toggleTranslation' "$file"; then
            echo "   ✗ $file still has inline toggleTranslation!"
            ERRORS=$((ERRORS + 1))
        else
            echo "   ✓ $file has no inline toggleTranslation"
        fi
    fi
done

# HTML: no inline revealAnswer remaining
for file in unit9/fairy-tales-reading.html unit9/holiday-plans-grammar-review.html; do
    if [ -f "$file" ]; then
        if grep -q 'function revealAnswer' "$file"; then
            echo "   ✗ $file still has inline revealAnswer!"
            ERRORS=$((ERRORS + 1))
        else
            echo "   ✓ $file has no inline revealAnswer"
        fi
    fi
done

# HTML: renamed toggleAnswer variants
if grep -q 'toggleQuestionAnswer' unit8/fun-things-we-do-reading.html; then
    echo "   ✓ fun-things-we-do-reading.html uses toggleQuestionAnswer()"
else
    echo "   ✗ fun-things-we-do-reading.html missing toggleQuestionAnswer()!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q 'toggleReadingAnswer' unit8/amazing-vehicles-reading.html; then
    echo "   ✓ amazing-vehicles-reading.html uses toggleReadingAnswer()"
else
    echo "   ✗ amazing-vehicles-reading.html missing toggleReadingAnswer()!"
    ERRORS=$((ERRORS + 1))
fi

# Baseball unit7: no inline toggleReveal (now in common.js)
for file in super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'function toggleReveal' "$file"; then
            echo "   ✗ $file still has inline toggleReveal!"
            ERRORS=$((ERRORS + 1))
        else
            echo "   ✓ $file has no inline toggleReveal"
        fi
    fi
done

# data-placeholder on fairy-tales word quiz blanks
if grep -q 'data-placeholder=' unit9/fairy-tales-reading.html; then
    echo "   ✓ fairy-tales-reading.html uses data-placeholder attributes"
else
    echo "   ✗ fairy-tales-reading.html missing data-placeholder attributes!"
    ERRORS=$((ERRORS + 1))
fi

# data-copy-text on unit7 homework copy buttons
for file in unit7/present-continuous-homework.html super-minds-baseball/unit7/baseball-present-continuous-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'data-copy-text' "$file"; then
            echo "   ✓ $file uses data-copy-text for clipboard"
        else
            echo "   ✗ $file missing data-copy-text!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# fun-things-we-do-reading.html uses DOMContentLoaded for init
if grep -q 'DOMContentLoaded' unit8/fun-things-we-do-reading.html; then
    echo "   ✓ fun-things-we-do-reading.html defers init with DOMContentLoaded"
else
    echo "   ✗ fun-things-we-do-reading.html missing DOMContentLoaded guard!"
    ERRORS=$((ERRORS + 1))
fi

# fun-things-we-do-reading.html has no inline <style> block
if grep -q '<style>' unit8/fun-things-we-do-reading.html; then
    echo "   ✗ fun-things-we-do-reading.html still has inline <style> block!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ fun-things-we-do-reading.html has no inline <style> block"
fi

# copyDialogue no longer defined inline
for file in unit7/present-continuous-homework.html super-minds-baseball/unit7/baseball-present-continuous-homework.html; do
    if [ -f "$file" ]; then
        if grep -q 'function copyDialogue' "$file"; then
            echo "   ✗ $file still has inline copyDialogue!"
            ERRORS=$((ERRORS + 1))
        else
            echo "   ✓ $file has no inline copyDialogue"
        fi
    fi
done

# PR #30: accessibility - semantic <main> tag
if grep -q '<main.*class="max-w-6xl' unit8/gerunds-ball-sports.html; then
    echo "   ✓ unit8/gerunds-ball-sports.html uses semantic <main> tag"
else
    echo "   ✗ unit8/gerunds-ball-sports.html missing semantic <main> tag!"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: toggleBlank uses unified signature (no event param, uses this)
if grep -q "toggleBlank('blank" unit8/gerunds-ball-sports.html && ! grep -q "toggleBlank(event," unit8/gerunds-ball-sports.html; then
    echo "   ✓ gerunds-ball-sports.html toggleBlank uses unified signature"
else
    echo "   ✗ gerunds-ball-sports.html toggleBlank not unified!"
    ERRORS=$((ERRORS + 1))
fi

# PR #30: no console.error/console.warn in common.js (brittle selector cleanup)
if grep -q 'console\.error\|console\.warn' js/common.js; then
    echo "   ✗ common.js still has console.error/console.warn!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ common.js has no console.error/console.warn"
fi

# PR #30: initCommon uses document.readyState check
if grep -q "document.readyState === 'loading'" js/common.js; then
    echo "   ✓ initCommon() checks document.readyState"
else
    echo "   ✗ initCommon() missing document.readyState check!"
    ERRORS=$((ERRORS + 1))
fi

# PR #32: baseball-theme.css referenced by migrated pages
BASEBALL_PAGES="unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html unit9/fairy-tales-reading.html unit9/holiday-plans-grammar-review.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html"
for file in $BASEBALL_PAGES; do
    if [ -f "$file" ]; then
        if grep -q 'baseball-theme.css' "$file"; then
            echo "   ✓ $file references baseball-theme.css"
        else
            echo "   ✗ $file missing baseball-theme.css reference!"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

# PR #32: CSS custom properties exist
if grep -q -- '--leather-primary' css/baseball-theme.css && grep -q -- '--stitch-red' css/baseball-theme.css && grep -q -- '--field-green' css/baseball-theme.css; then
    echo "   ✓ CSS custom properties exist in baseball-theme.css"
else
    echo "   ✗ CSS custom properties missing from baseball-theme.css!"
    ERRORS=$((ERRORS + 1))
fi

# PR #32: keyframe animations exist
if grep -q '@keyframes float' css/baseball-theme.css && grep -q '@keyframes pulse' css/baseball-theme.css; then
    echo "   ✓ Keyframe animations (float, pulse) exist in baseball-theme.css"
else
    echo "   ✗ Keyframe animations missing from baseball-theme.css!"
    ERRORS=$((ERRORS + 1))
fi

# PR #33: speak() utter.rate = 0.8
if grep -q "utter.rate = 0.8" js/common.js; then
    echo "   ✓ speak() uses utter.rate = 0.8"
else
    echo "   ✗ speak() missing utter.rate = 0.8!"
    ERRORS=$((ERRORS + 1))
fi

# PR #33: speak() handles onerror alongside onend
if grep -q "utter.onend = utter.onerror" js/common.js; then
    echo "   ✓ speak() handles onend and onerror together"
else
    echo "   ✗ speak() missing onerror handler!"
    ERRORS=$((ERRORS + 1))
fi

# PR #31: no inline <nav> HTML remaining (all use renderNav via NAV_CONFIG)
INLINE_NAV_FILES="unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html unit9/fairy-tales-reading.html unit9/holiday-plans-grammar-review.html super-minds-baseball/index.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html"
INLINE_NAV_ERRORS=0
for file in $INLINE_NAV_FILES; do
    if [ -f "$file" ]; then
        # Check if file uses centralized nav (NAV_CONFIG) vs inline nav links
        if grep -q 'NAV_CONFIG' "$file"; then
            : # uses centralized nav, good
        elif grep -q '<nav' "$file"; then
            echo "   ✗ $file still has inline <nav> HTML!"
            INLINE_NAV_ERRORS=$((INLINE_NAV_ERRORS + 1))
            ERRORS=$((ERRORS + 1))
        fi
    fi
done
if [ $INLINE_NAV_ERRORS -eq 0 ]; then
    echo "   ✓ All pages use centralized nav (no inline <nav> found)"
fi

# PR #29: renamed course pages exist
RENAME_FILES="unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html unit9/holiday-plans-grammar-review.html unit9/fairy-tales-reading.html"
for file in $RENAME_FILES; do
    if [ -f "$file" ]; then
        :
    else
        echo "   ✗ $file missing (PR #29 rename)!"
        ERRORS=$((ERRORS + 1))
    fi
done
echo "   ✓ All renamed course pages exist"

# Verify common.js defines all shared functions (both function xxx() and window.xxx = function)
COMMON_FUNCS="toggleVisibility toggleTranslation toggleAnswer revealAnswer toggleReveal speak updateProgress restoreProgress toggleComplete copyToClipboard switchTab toggleQuizAnswer toggleCompAnswer toggleTimeline renderNav initCommon updateTodoProgress toggleTodoItem resetTodoItems"
MISSING_FUNC=0
for func in $COMMON_FUNCS; do
    if ! grep -qE "function $func\(|window\.$func *= *function" js/common.js; then
        echo "   ✗ $func() not defined in common.js!"
        MISSING_FUNC=$((MISSING_FUNC + 1))
        ERRORS=$((ERRORS + 1))
    fi
done
if [ $MISSING_FUNC -eq 0 ]; then
    echo "   ✓ All shared functions defined in common.js"
fi

# Accessibility: deinlineOnclick() exists and is called by initCommon()
if grep -q 'function deinlineOnclick' js/common.js; then
    echo "   ✓ deinlineOnclick() function defined in common.js"
else
    echo "   ✗ deinlineOnclick() missing from common.js!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q 'deinlineOnclick()' js/common.js; then
    echo "   ✓ initCommon() calls deinlineOnclick()"
else
    echo "   ✗ initCommon() does not call deinlineOnclick()!"
    ERRORS=$((ERRORS + 1))
fi

# Accessibility: deinlineOnclick includes keyboard accessibility
if grep -q "interactiveTags.indexOf(el.tagName) === -1" js/common.js; then
    echo "   ✓ deinlineOnclick() includes keyboard accessibility"
else
    echo "   ✗ deinlineOnclick() missing keyboard accessibility!"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: deinlineOnclick() has whitespace-tolerant two-arg pattern
if grep -q "s\*\\\\(\\\\s\*" js/common.js; then
    echo "   ✓ deinlineOnclick() has whitespace-tolerant two-arg pattern"
else
    echo "   ✗ deinlineOnclick() missing whitespace-tolerant two-arg pattern!"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: deinlineOnclick() uses fn.call(el, ...) consistently across patterns
CALL_PATTERNS=$(grep -c 'fn.call(el' js/common.js || echo 0)
if [ "$CALL_PATTERNS" -ge 8 ]; then
    echo "   ✓ deinlineOnclick() uses fn.call(el, ...) consistently ($CALL_PATTERNS patterns)"
else
    echo "   ✗ deinlineOnclick() fn.call consistency missing! (found $CALL_PATTERNS, expected >= 8)"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: initCommon() supports data-copy-feedback attribute
if grep -q "data-copy-feedback" js/common.js; then
    echo "   ✓ initCommon() supports data-copy-feedback attribute"
else
    echo "   ✗ initCommon() missing data-copy-feedback support!"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: baseball toggleBlank does not use implicit global event.target
if ! grep -q "event.target" super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; then
    echo "   ✓ baseball toggleBlank does not use implicit event.target"
else
    echo "   ✗ baseball toggleBlank still uses implicit event.target!"
    ERRORS=$((ERRORS + 1))
fi

# PR #37: both toggleBlank implementations use this for element access
THIS_TOGGLEBLANK=0
if grep -q "var element = this;" unit8/gerunds-ball-sports.html; then
    THIS_TOGGLEBLANK=$((THIS_TOGGLEBLANK + 1))
fi
if grep -q "var element = this;" super-minds-baseball/unit8/baseball-gerunds-ball-sports.html; then
    THIS_TOGGLEBLANK=$((THIS_TOGGLEBLANK + 1))
fi
if [ "$THIS_TOGGLEBLANK" -eq 2 ]; then
    echo "   ✓ both toggleBlank implementations use this for element access"
else
    echo "   ✗ toggleBlank this consistency broken! (found $THIS_TOGGLEBLANK/2)"
    ERRORS=$((ERRORS + 1))
fi

# Accessibility: all pages have main-content landmark
MAIN_CONTENT_FILES="index.html unit7/present-continuous-course.html unit7/present-continuous-homework.html unit8/gerunds-ball-sports.html unit8/amazing-vehicles-reading.html unit8/fun-things-we-do-reading.html unit8/question-words-grammar-homework.html unit9/fairy-tales-reading.html unit9/holiday-plans-grammar-review.html super-minds-baseball/index.html super-minds-baseball/unit7/baseball-present-continuous-course.html super-minds-baseball/unit7/baseball-present-continuous-homework.html super-minds-baseball/unit8/baseball-gerunds-ball-sports.html"
MAIN_CONTENT_ERRORS=0
for file in $MAIN_CONTENT_FILES; do
    if [ -f "$file" ]; then
        if ! grep -q 'id="main-content"' "$file"; then
            echo "   ✗ $file missing id=main-content!"
            MAIN_CONTENT_ERRORS=$((MAIN_CONTENT_ERRORS + 1))
            ERRORS=$((ERRORS + 1))
        fi
    fi
done
if [ $MAIN_CONTENT_ERRORS -eq 0 ]; then
    echo "   ✓ All pages have id=main-content landmark"
fi

# Accessibility: data-copy-text auto-binding in initCommon
if grep -q 'data-copy-text' js/common.js; then
    echo "   ✓ initCommon() auto-binds data-copy-text buttons"
else
    echo "   ✗ initCommon() missing data-copy-text binding!"
    ERRORS=$((ERRORS + 1))
fi

# Navigation: toggleMobileMenu uses data-action instead of inline onclick
if grep -q 'data-action="toggle-mobile-menu"' js/common.js; then
    echo "   ✓ Mobile menu button uses data-action (no inline onclick)"
else
    echo "   ✗ Mobile menu button still uses inline onclick!"
    ERRORS=$((ERRORS + 1))
fi

# Build script unit tests
if [ -f "scripts/test_generate_baseball.py" ]; then
    if python3 scripts/test_generate_baseball.py >/dev/null 2>&1; then
        echo "   ✓ Build script unit tests pass"
    else
        echo "   ✗ Build script unit tests FAILED!"
        python3 scripts/test_generate_baseball.py
        ERRORS=$((ERRORS + 1))
    fi
else
    echo "   ✗ Build script unit tests not found!"
    ERRORS=$((ERRORS + 1))
fi

# Build script sync check: baseball gerunds must match generated output
if [ -f "scripts/generate-baseball.py" ]; then
    TEMP_DIR=$(mktemp -d)
    cp -r unit8 "$TEMP_DIR/"
    cp scripts/generate-baseball.py "$TEMP_DIR/"
    (cd "$TEMP_DIR" && python3 generate-baseball.py >/dev/null 2>&1)
    if diff -q "$TEMP_DIR/super-minds-baseball/unit8/baseball-gerunds-ball-sports.html" super-minds-baseball/unit8/baseball-gerunds-ball-sports.html >/dev/null 2>&1; then
        echo "   ✓ Baseball gerunds page is in sync with build script"
    else
        echo "   ✗ Baseball gerunds page is OUT OF SYNC with build script!"
        echo "     Run: python3 scripts/generate-baseball.py"
        ERRORS=$((ERRORS + 1))
    fi
    rm -rf "$TEMP_DIR"
else
    echo "   ✗ Build script scripts/generate-baseball.py not found!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "19. Checking unit7 course page top spacing..."
ERRORS=0

if grep -q '<body class="sm-body">' unit7/present-continuous-course.html; then
    echo "   ✓ unit7/present-continuous-course.html uses the shared body class"
else
    echo "   ✗ unit7/present-continuous-course.html missing expected body class!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q '<body class="p-4 md:p-8 sm-body">' unit7/present-continuous-course.html; then
    echo "   ✗ unit7/present-continuous-course.html still has top padding utilities!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ unit7/present-continuous-course.html has no extra top padding"
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "20. Checking common.css accessibility and token usage..."
ERRORS=0

if grep -q '@media (prefers-reduced-motion: reduce)' css/common.css; then
    echo "   ✓ common.css includes reduced-motion guard"
else
    echo "   ✗ common.css missing reduced-motion guard!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q ':focus-visible' css/common.css; then
    echo "   ✓ common.css includes focus-visible styles"
else
    echo "   ✗ common.css missing focus-visible styles!"
    ERRORS=$((ERRORS + 1))
fi

if grep -q -- '--shadow-ink' css/common.css && grep -q -- '--focus-ring' css/common.css; then
    echo "   ✓ common.css uses shared shadow and focus tokens"
else
    echo "   ✗ common.css missing shared shadow or focus tokens!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "21. Checking unit7 homework event binding cleanup..."
ERRORS=0

if grep -Fq "onclick=\"this.classList.toggle('flipped')\"" unit7/present-continuous-homework.html; then
    echo "   ✗ unit7/present-continuous-homework.html still has inline flashcard onclick!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ unit7/present-continuous-homework.html flashcards use addEventListener"
fi

if grep -q 'onclick="toggleTimeline(this)"' unit7/present-continuous-homework.html; then
    echo "   ✗ unit7/present-continuous-homework.html still has inline timeline onclick!"
    ERRORS=$((ERRORS + 1))
else
    echo "   ✓ unit7/present-continuous-homework.html timeline nodes use addEventListener"
fi

if grep -q "document.addEventListener('DOMContentLoaded'" unit7/present-continuous-homework.html; then
    echo "   ✓ unit7/present-continuous-homework.html binds events on DOMContentLoaded"
else
    echo "   ✗ unit7/present-continuous-homework.html missing DOMContentLoaded bindings!"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
    exit 1
fi

echo ""
echo "=== Test Complete ==="
echo ""
echo "Next steps:"
echo "1. Start a local server: python3 -m http.server 8000"
echo "2. Open http://localhost:8000"
echo "3. Test the new grammar page: http://localhost:8000/unit8/question-words-grammar-homework.html"
echo "4. Test the reading page: http://localhost:8000/unit8/fun-things-we-do-reading.html"
echo "5. Test the Unit 9 page: http://localhost:8000/unit9/holiday-plans-grammar-review.html"
echo "6. Test the Fairy Tales page: http://localhost:8000/unit9/fairy-tales-reading.html"
echo "7. Follow TESTING.md checklist"
