# Testing Guide

Use this guide to verify the static Super Minds site after page, navigation, or content updates.

## Automated Testing

### GitHub Actions

| Workflow | File | Coverage |
|----------|------|----------|
| Quick Validation | `.github/workflows/quick-test.yml` | File structure, generated files, references, basic HTML checks |
| Full CI | `.github/workflows/ci.yml` | HTML/CSS/JS validation, links, functional checks |
| Browser Tests | `.github/workflows/browser-tests.yml` | Playwright E2E, Lighthouse, visual regression, accessibility |
| Unit 8 Reading | `.github/workflows/unit8-reading-test.yml` | SM2 Unit 8 reading page behavior |
| Unit 9 Pages | `.github/workflows/unit9-test.yml` | SM2 Unit 9 grammar and reading checks |

### Local Commands

```bash
# Full project quick validation
PYTHONDONTWRITEBYTECODE=1 ./test.sh

# SM3 page and shared mobile navigation regression tests
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest scripts/test_sm3_pages.py

# Generated baseball page tests
python3 scripts/test_generate_baseball.py

# JavaScript syntax check
node --check js/common.js
```

`scripts/test_sm3_pages.py` covers SM3 Unit 0, Unit 1, Unit 1 Story, Unit 2 There Be, and Unit 2 Breakfast. It also verifies that the mobile menu uses compact collapsible SM2/SM3 sections and that SM3 Unit 2 lesson controls use `data-lesson-action` instead of the shared nav `data-action` attribute.

## Build Script Testing

`scripts/generate-baseball.py` reads `sm2/unit8/gerunds-ball-sports.html` and writes `sm2/baseball/unit8/baseball-gerunds-ball-sports.html`.

```bash
python3 scripts/generate-baseball.py
python3 scripts/test_generate_baseball.py
```

The tests cover path upgrades, `NAV_CONFIG.active` transformation, meta description updates, quote normalization, whitespace cleanup, trailing newline enforcement, and idempotency.

## Manual Server

Start a local static server from the repository root:

```bash
python3 -m http.server 8000
```

Open http://localhost:8000 in the browser.

## Manual Checklist

### Shared Resources

- [ ] Homepage loads with the shared gradient background and favicon
- [ ] `ga.js` loads without 404s
- [ ] `css/common.css` and `js/common.js` load on root, SM2, SM3, and baseball pages
- [ ] Lucide and Font Awesome icons render where used
- [ ] Browser console has no `toggleMobileMenu is not defined` or similar errors

### Mobile Navigation

- [ ] Resize to a mobile viewport under 768px
- [ ] Hamburger button opens and closes the menu
- [ ] Mobile menu shows Home plus compact collapsible `SM2` and `SM3` sections
- [ ] On SM2 pages, the SM2 section is open by default and SM3 is collapsed
- [ ] On SM3 pages, the SM3 section is open by default and SM2 is collapsed
- [ ] Desktop navigation remains visible at desktop width and the mobile menu is hidden
- [ ] SM3 Unit 2 lesson clicks do not open or close the mobile nav accidentally

### Homepage

- [ ] `http://localhost:8000/` loads
- [ ] SM2 course cards link to `sm2/unit7/`, `sm2/unit8/`, `sm2/unit9/`, and `sm2/review/`
- [ ] SM3 course cards link to `sm3/unit0/`, `sm3/unit1/`, and `sm3/unit2/`
- [ ] Baseball entry links to `sm2/baseball/`

### Super Minds 2

#### Unit 7

- [ ] `http://localhost:8000/sm2/unit7/present-continuous-course.html` loads
- [ ] Quiz items expand and collapse
- [ ] Story translations toggle
- [ ] Comprehension answers toggle
- [ ] Cloze dropdowns and answer checking work
- [ ] `http://localhost:8000/sm2/unit7/present-continuous-homework.html` loads
- [ ] Tabs, flashcards, timeline nodes, answer masks, copy button, and homework progress work

#### Unit 8

- [ ] `http://localhost:8000/sm2/unit8/gerunds-ball-sports.html` loads
- [ ] Vocabulary pronunciation works
- [ ] Song blanks and reading translations toggle
- [ ] `http://localhost:8000/sm2/unit8/amazing-vehicles-reading.html` loads
- [ ] Vehicle vocabulary, reading questions, cloze blanks, and todo progress work
- [ ] `http://localhost:8000/sm2/unit8/fun-things-we-do-reading.html` loads
- [ ] Character cards, reading translations, vocabulary audio, and questions work
- [ ] `http://localhost:8000/sm2/unit8/question-words-grammar-homework.html` loads
- [ ] Grammar cards, dialogue translations, sentence answers, email cloze, and todo list work

#### Unit 9

- [ ] `http://localhost:8000/sm2/unit9/holiday-plans-grammar-review.html` loads
- [ ] Grammar cards, dialogue blanks, answer table toggles, audio, and todo list work
- [ ] `http://localhost:8000/sm2/unit9/fairy-tales-reading.html` loads
- [ ] Two vocabulary sets render
- [ ] Reading translations and comprehension feedback work
- [ ] Correct answer text does not include a literal checkmark character
- [ ] Word quiz blanks and todo list work

#### Reviews

- [ ] `http://localhost:8000/sm2/review/review-units-1-3.html` loads
- [ ] `http://localhost:8000/sm2/review/review-unit-4.html` loads
- [ ] `http://localhost:8000/sm2/review/review-unit-5.html` loads
- [ ] `http://localhost:8000/sm2/review/review-unit-5-lecture2.html` loads
- [ ] Reading translations, answer reveals, and todo progress work on each review page

#### Baseball Edition

- [ ] `http://localhost:8000/sm2/baseball/` loads
- [ ] Baseball Unit 7 course and homework pages load
- [ ] Baseball Unit 8 generated page loads
- [ ] Baseball pages link back to the main SM2 and SM3 lessons correctly

### Super Minds 3

#### Unit 0

- [ ] `http://localhost:8000/sm3/unit0/explorers-be-good-at.html` loads
- [ ] Vocabulary, reading translations, answer reveals, and todo interactions work
- [ ] Mobile nav opens with SM3 expanded

#### Unit 1

- [ ] `http://localhost:8000/sm3/unit1/school-subjects-like-doing.html` loads
- [ ] School subject vocabulary and pronunciation work
- [ ] Like doing / enjoy doing practice works
- [ ] `http://localhost:8000/sm3/unit1/story-part.html` loads
- [ ] Story translations, vocabulary, questions, and revealable answers work

#### Unit 2

- [ ] `http://localhost:8000/sm3/unit2/there-is-there-are-picnic.html` loads
- [ ] The two source pictures are visible near the top of the lesson
- [ ] Food vocabulary pronunciation works
- [ ] Song translations toggle
- [ ] Reading comprehension options show correct/wrong feedback
- [ ] Picnic basket blanks reveal and hide answers
- [ ] Supermarket story translations and questions work
- [ ] Translation practice answers reveal correctly
- [ ] Todo progress uses `sm3Unit2ThereBeTodos`
- [ ] Lesson controls use `data-lesson-action` and do not conflict with mobile nav `data-action`

#### Unit 3

- [ ] `http://localhost:8000/sm3/unit3/daily-routines-frequency-adverbs.html` loads
- [ ] Frequency adverbs and time-expression practice reveal answers correctly
- [ ] Daily-routine and story translations toggle
- [ ] Reading choices show correct/wrong feedback
- [ ] Vocabulary pronunciation and Helping Hands answers work
- [ ] Todo progress uses `sm3Unit3RoutinesTodos`
- [ ] Lesson controls use `data-lesson-action` and do not conflict with mobile nav `data-action`
- [ ] `http://localhost:8000/sm3/unit2/breakfast-foods-simple-present.html` loads
- [ ] Breakfast vocabulary pronunciation works
- [ ] Pizza dialogue translations toggle
- [ ] Busy Saturday reading comprehension options show correct/wrong feedback
- [ ] Helping Hand reading translations and questions work
- [ ] Simple present cloze answers reveal and hide correctly
- [ ] Todo progress uses `sm3Unit2BreakfastTodos`
- [ ] Lesson controls use `data-lesson-action` and do not conflict with mobile nav `data-action`

## Regression Matrix

| Feature | Expected Current Behavior |
|---------|---------------------------|
| Page load | All root, SM2, SM3, review, and baseball pages load without console errors |
| Mobile menu | Compact collapsible SM2/SM3 sections; active course family opens by default |
| Desktop nav | Full dropdown navigation remains visible on desktop and opens on hover or keyboard focus |
| Lesson actions | Translations, answers, vocabulary audio, and todos respond to click and keyboard activation |
| Progress save | Todo progress persists through localStorage |
| Baseball generation | Generated SM2 baseball Unit 8 file stays in sync with source |
| SM3 Unit 2 images | `unit2-source-000.jpg` and `unit2-source-001.jpg` are both present and referenced |

## Browser Matrix

- [ ] Chrome or Edge
- [ ] Firefox
- [ ] Safari when available
- [ ] Mobile viewport in DevTools
