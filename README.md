# Super Minds 2 - English Learning Platform

> 🎓 An interactive English learning resource designed for children

## 📚 Available Courses

### Unit 7 - Present Continuous Tense (现在进行时)
An interactive web-based course to help children learn the **Present Continuous Tense**.

Through engaging and fun methods, children can easily master:
- 📝 The structure and rules of present continuous tense
- 🎯 Correct usage of "be" verbs (am/is/are)
- ✏️ Spelling rules for verb present participles (-ing forms)
- 🎮 Interactive exercises to reinforce learning

### Unit 8 - Gerunds as Subjects (动名词作主语)
A baseball-themed course focusing on **using gerunds as subjects** with ball sports vocabulary.

**Two learning tracks available:**

1. **Ball Sports** (`unit8/index.html`)
   - 🏀 10 ball sports vocabulary words (soccer, basketball, tennis, volleyball, golf, bowling, baseball, badminton, rugby, ping-pong)
   - 📝 Grammar structure: Playing + sport + is + adjective
   - 🎵 Song activities with fill-in-the-blank exercises
   - 📖 Reading comprehension with interactive translations
   - ✏️ Chinese-to-English translation practice

2. **Amazing Vehicles** (`unit8/amazing-vehicles.html`)
   - 🚌 9 vehicle-related vocabulary words (amazing, because, inside, difficult, front, back, party, drive, pool)
   - 📏 Grammar: Measure vs Measuring, There be with length units (1cm=10mm, 1m=100cm)
   - 📖 Two reading passages with comprehension questions
   - 📝 Cloze exercise with interactive blanks
   - ✏️ Homework todo list with progress tracking

3. **Fun Things We Do** (`unit8/reading.html`)
   - 🎨 Character cards with hobbies (Amy, Ben, Cindy, David)
   - 📖 Reading passage with clickable translations
   - 📝 5 reading comprehension questions
   - 🎯 Key vocabulary with pronunciation (Web Speech API)
   - 📚 Grammar focus: like/enjoy/love + V-ing, be interested in + V-ing
   - ✅ Interactive todo list for homework tracking

4. **Grammar Homework** (`unit8/grammar.html`)
   - 📝 Grammar focus: 5 question words (Where, When, Which, Who, How often)
   - 💬 New dialogue: Creating a football team story
   - 🎯 9 Unit 9 verb phrases with audio pronunciation
   - ✍️ Sentence practice with Where/When/Which patterns
   - 📧 Email cloze exercise (Harry's study trip to France)
   - ✅ Interactive todo list for homework tracking

### Unit 9 - Holiday Plans Grammar (假期计划语法)
A grammar review page consolidating key sentence patterns from the entire book.

**Content:** (`unit9/index.html`)
   - 🎵 Page 108 song grammar: `It's time for...`, `Can I...`, `I'm going to...`
   - 📝 Page 109 grammar summary: question words, be verbs, can, have got, there be
   - 💬 Two dialogue fill-in-the-blank exercises (35+ blanks)
   - 🎯 5 verb phrases with audio pronunciation (Web Speech API)
   - ✅ Interactive todo list for homework tracking

## 🌐 Access the Course

**Click the link below to start learning:**

👉 **[Access the Course](https://ben1009.github.io/super-minds/)**

No installation required — just open it in your browser!

## 🏗️ Project Structure

```
├── index.html              # Homepage - course navigation
├── css/
│   └── common.css          # Shared styles (variables, animations)
├── js/
│   └── common.js           # Shared utilities (navigation, toggles, progress)
├── unit7/
│   ├── index.html          # Unit 7: Present Continuous Tense
│   └── homework.html       # Unit 7 Homework
├── unit8/
│   ├── index.html          # Unit 8: Gerunds as Subjects (Ball Sports)
│   ├── amazing-vehicles.html  # Unit 8: Amazing Vehicles (Reading & Vocabulary)
│   ├── reading.html        # Unit 8: Fun Things We Do (Reading & Hobbies)
│   ├── grammar.html        # Unit 8: Grammar Homework & Exercises
│   ├── grammar.css         # Unit 8: Grammar page styles
│   └── grammar.js          # Unit 8: Grammar page interactions
├── unit9/
│   └── index.html          # Unit 9: Holiday Plans Grammar Review
├── super-minds-baseball/   # Baseball-themed edition
│   ├── index.html          # Baseball homepage with links to all units
│   ├── unit7/
│   │   ├── index.html      # Baseball Unit 7: Present Continuous
│   │   └── homework.html   # Baseball Unit 7 Homework
│   └── unit8/
│       └── index.html      # Baseball Unit 8: Gerunds (links to main site Unit 9)
└── .github/workflows/      # CI/CD automation
```

## ✨ Features

- 🖼️ Beautiful visual design to capture children's attention
- 🖱️ Interactive learning experience
- 📖 Clear and organized knowledge structure
- ✅ Instant feedback on practice exercises
- 🌴 Unit 9 grammar review: Holiday Plans with dialogue fill-in-the-blanks
- ⚾ Baseball-themed special edition with cross-navigation to all units
- 🔄 Shared code architecture for maintainability
- ✅ Automated testing with GitHub Actions

## 🧪 Testing

This project includes comprehensive automated testing:

| Test Type | Tool | Coverage |
|-----------|------|----------|
| File Structure | Bash | Required files, references |
| HTML/CSS/JS | html-validate, stylelint, ESLint | Syntax validation |
| Functional | Puppeteer, Playwright | Headless browser E2E tests |
| Performance | Lighthouse CI | Performance, accessibility |
| Visual | Puppeteer | Screenshot comparisons |

**Run tests locally:**
```bash
# File structure validation
./test.sh

# Start local server
python3 -m http.server 8000
```

## 📄 License

This project uses a dual-license model:

| Component | License | Description |
|-----------|---------|-------------|
| **Source Code** | [Apache License 2.0](./LICENSE) | The code is freely available for use, modification, and distribution |
| **Course Content** | [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) | The educational content is for non-commercial use only, with attribution and share-alike requirements |

---

*Happy Learning! 🎉*
