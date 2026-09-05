# Super Minds - English Learning Platform

An interactive English learning resource for children, covering Super Minds 2 and Super Minds 3 grammar, vocabulary, reading, and homework practice.

## Available Courses

### Super Minds 2

#### Unit 7 - Present Continuous Tense

**Course:** `sm2/unit7/present-continuous-course.html`

- Present continuous structure and usage
- Be verb practice with `am`, `is`, and `are`
- Verb `-ing` spelling rules
- Interactive quizzes, story reading, and cloze practice

**Homework:** `sm2/unit7/present-continuous-homework.html`

- Sentence transformations
- Story retelling and dialogue writing
- Homework checklist with progress tracking

#### Unit 8 - Gerunds, Reading, and Question Words

1. **Ball Sports:** `sm2/unit8/gerunds-ball-sports.html`
   - Ball sports vocabulary
   - `Playing + sport + is + adjective`
   - Song blanks, reading translations, and translation practice

2. **Amazing Vehicles:** `sm2/unit8/amazing-vehicles-reading.html`
   - Vehicle vocabulary
   - Measure vs. Measuring
   - `There be` with length units
   - Reading questions and cloze practice

3. **Fun Things We Do:** `sm2/unit8/fun-things-we-do-reading.html`
   - Hobbies and character reading
   - Like/enjoy/love + `V-ing`
   - Vocabulary pronunciation and reading questions

4. **Question Words Grammar Homework:** `sm2/unit8/question-words-grammar-homework.html`
   - Where, When, Which, Who, and How often
   - Dialogue cards, sentence practice, and email cloze

#### Unit 9 - Holiday Plans and Fairy Tales

1. **Holiday Plans Grammar:** `sm2/unit9/holiday-plans-grammar-review.html`
   - `It's time for...`, `Can I...`, and `be going to...`
   - Grammar summary, dialogue blanks, and todo tracking

2. **Fairy Tales Reading:** `sm2/unit9/fairy-tales-reading.html`
   - Fairy tale vocabulary and holiday reading vocabulary
   - Two reading passages, comprehension questions, and word quiz blanks

#### Reviews

- `sm2/review/review-units-1-3.html`
- `sm2/review/review-unit-4.html`
- `sm2/review/review-unit-5.html`
- `sm2/review/review-unit-5-lecture2.html`

#### Baseball Edition

- `sm2/baseball/index.html`
- `sm2/baseball/unit7/baseball-present-continuous-course.html`
- `sm2/baseball/unit7/baseball-present-continuous-homework.html`
- `sm2/baseball/unit8/baseball-gerunds-ball-sports.html`

The baseball Unit 8 page is generated from `sm2/unit8/gerunds-ball-sports.html` by `scripts/generate-baseball.py`.

### Super Minds 3

1. **Unit 0 - Explorers:** `sm3/unit0/explorers-be-good-at.html`
   - Explorer vocabulary
   - `be good at` grammar
   - Reading, speaking, and review practice

2. **Unit 1 - School Subjects:** `sm3/unit1/school-subjects-like-doing.html`
   - School subject vocabulary
   - Like doing / enjoy doing patterns
   - Interactive reading and pronunciation practice

3. **Unit 1 - Story Part:** `sm3/unit1/story-part.html`
   - PDF-based story lesson
   - Story reading, translations, vocabulary, and comprehension practice

4. **Unit 2 - Picnic and There Be:** `sm3/unit2/there-is-there-are-picnic.html`
   - Two source pictures from the PDF at the top of the lesson
   - Countable and uncountable food vocabulary
   - `There is`, `There are`, questions, and negatives
   - Picnic song, supermarket story, fill-in practice, and todo tracking

5. **Unit 2 - Breakfast and Simple Present:** `sm3/unit2/breakfast-foods-simple-present.html`
   - Breakfast vocabulary from the new PDF
   - Pizza ordering dialogue and sentence patterns
   - Saturday housework reading and comprehension practice
   - Simple present verb-form cloze and todo tracking

6. **Unit 3 - Daily Routines and Frequency Adverbs:** `sm3/unit3/daily-routines-frequency-adverbs.html`
   - Frequency adverbs, placement rules, and time expressions
   - Daily-routine reading with translations and true/false feedback
   - Story vocabulary, cloze, grammar practice, and Helping Hands preview

## Access

Open the published site here:

https://ben1009.github.io/super-minds/

## Project Structure

```text
├── index.html
├── ga.js
├── favicon.svg
├── css/
│   ├── common.css
│   ├── baseball-theme.css
│   └── baseball-unit7.css
├── js/
│   └── common.js
├── scripts/
│   ├── generate-baseball.py
│   ├── test_generate_baseball.py
│   ├── test_review_unit5_lecture2.py
│   └── test_sm3_pages.py
├── sm2/
│   ├── unit7/
│   ├── unit8/
│   ├── unit9/
│   ├── review/
│   └── baseball/
├── sm3/
│   ├── unit0/
│   ├── unit1/
│   ├── unit2/
│       └── assets/
└── unit3/
├── README.md
├── TESTING.md
├── AGENTS.md
└── todo.md
```

## Features

- Interactive single-page lessons with translations, revealable answers, quizzes, and todo progress
- Shared navigation rendered by `js/common.js`
- Compact mobile navigation with collapsible SM2 and SM3 sections
- Web Speech API pronunciation practice
- Shared Google Analytics loader through `ga.js`
- Static deployment through GitHub Pages
- Automated checks for page structure, generated baseball output, links, and SM3 lesson regressions

## Testing

Run the main local checks:

```bash
PYTHONDONTWRITEBYTECODE=1 ./test.sh
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest scripts/test_sm3_pages.py
python3 scripts/test_generate_baseball.py
```

For browser testing:

```bash
python3 -m http.server 8000
```

Then open http://localhost:8000.

## License

| Component | License |
|-----------|---------|
| Source code | [Apache License 2.0](./LICENSE) |
| Course content | [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) |
