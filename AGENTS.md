# Super Minds - Agent Guide

## Project Overview

Super Minds 是一个面向儿童的互动式英语学习网站，涵盖 Super Minds 2 和 Super Minds 3 的语法、词汇、阅读、故事和作业练习。项目是纯静态站点，托管在 GitHub Pages 上，无需后端服务器。

- 在线访问: https://ben1009.github.io/super-minds/
- 源码仓库: https://github.com/ben1009/super-minds
- 目标用户: 儿童英语学习者
- 课程来源: Super Minds 2 / Super Minds 3 教材与 PDF 资料

## Technology Stack

- HTML5 + CSS3 + 原生 JavaScript
- Tailwind CSS CDN
- Lucide Icons CDN
- Font Awesome CDN on baseball-themed pages
- Google Fonts
- Google Analytics via shared `ga.js`
- GitHub Pages

## Project Structure

```text
<project-root>/
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
│   └── unit2/
│       └── assets/
├── README.md
├── TESTING.md
├── todo.md
└── AGENTS.md
```

## Page Inventory

| File | Description |
|------|-------------|
| `index.html` | 主页，展示 SM2、SM3、复习和棒球版入口 |
| `sm2/unit7/present-continuous-course.html` | SM2 Unit 7 现在进行时课程 |
| `sm2/unit7/present-continuous-homework.html` | SM2 Unit 7 作业页面 |
| `sm2/unit8/gerunds-ball-sports.html` | SM2 Unit 8 球类运动与动名词作主语 |
| `sm2/unit8/amazing-vehicles-reading.html` | SM2 Unit 8 交通工具阅读与 There be |
| `sm2/unit8/fun-things-we-do-reading.html` | SM2 Unit 8 兴趣爱好阅读 |
| `sm2/unit8/question-words-grammar-homework.html` | SM2 Unit 8 疑问词语法作业 |
| `sm2/unit9/holiday-plans-grammar-review.html` | SM2 Unit 9 假期计划语法复习 |
| `sm2/unit9/fairy-tales-reading.html` | SM2 Unit 9 Fairy Tales 阅读 |
| `sm2/review/review-units-1-3.html` | SM2 Units 1-3 复习 |
| `sm2/review/review-unit-4.html` | SM2 Unit 4 复习 |
| `sm2/review/review-unit-5.html` | SM2 Unit 5 复习 |
| `sm2/review/review-unit-5-lecture2.html` | SM2 Unit 5 第二讲复习 |
| `sm2/baseball/index.html` | 棒球主题首页 |
| `sm2/baseball/unit7/baseball-present-continuous-course.html` | 棒球版 SM2 Unit 7 课程 |
| `sm2/baseball/unit7/baseball-present-continuous-homework.html` | 棒球版 SM2 Unit 7 作业 |
| `sm2/baseball/unit8/baseball-gerunds-ball-sports.html` | 棒球版 SM2 Unit 8，由脚本生成 |
| `sm3/unit0/explorers-be-good-at.html` | SM3 Unit 0 Explorers 与 `be good at` |
| `sm3/unit1/school-subjects-like-doing.html` | SM3 Unit 1 school subjects 与 like doing |
| `sm3/unit1/story-part.html` | SM3 Unit 1 story part，基于新增 PDF |
| `sm3/unit2/there-is-there-are-picnic.html` | SM3 Unit 2 picnic / food / `There is` / `There are`，基于新增 PDF |

## Shared Architecture

### CSS

- Shared styles live in `css/common.css`.
- Baseball-themed shared styles live in `css/baseball-theme.css`.
- Baseball Unit 7 shared styles live in `css/baseball-unit7.css`.
- Page-specific styles may remain inline when they are tightly coupled to one page.

### JavaScript

`js/common.js` owns shared behavior:

- `renderNav(config)` renders shared nav when `window.NAV_CONFIG` and `<nav id="site-nav"></nav>` are present.
- `toggleMobileMenu()` opens/closes the generated mobile menu.
- `buildNavPatternA()` and `buildNavPatternB()` generate desktop dropdown nav and compact mobile nav.
- Mobile nav uses native `<details>` sections for `SM2` and `SM3`; the active course family is open by default.
- `data-action` is reserved for shared nav actions such as `toggle-mobile-menu`.
- Page-specific delegated actions should use a separate attribute, such as `data-lesson-action`, to avoid nav conflicts.
- Shared lesson helpers include translation toggles, answer reveals, todo progress, copy helpers, speech, keyboard binding, and progress restore.

### Navigation Patterns

- Pattern A: SM2 Unit 7 pages with blue styling.
- Pattern B: SM2 Unit 8/9 and SM3 pages with green/baseball-themed styling.
- Pattern C: Baseball Unit 7 flat navigation.
- Pattern D: Baseball Unit 8 generated page.

When adding a page, prefer `window.NAV_CONFIG` plus `<nav id="site-nav"></nav>` instead of copying nav HTML.

## SM3 Unit 2 Notes

`sm3/unit2/there-is-there-are-picnic.html` was generated from the newly added Unit 2 PDF.

Required content:

- Two source pictures at the top of the lesson:
  - `sm3/unit2/assets/unit2-source-000.jpg`
  - `sm3/unit2/assets/unit2-source-001.jpg`
- Food vocabulary for countable and uncountable nouns.
- `There is`, `There are`, question, and negative grammar cards.
- Picnic song with clickable translations.
- Reading comprehension with correct/wrong feedback.
- Picnic basket cloze and Chinese-to-English translation practice.
- Supermarket story reading and comprehension cards.
- Todo list using localStorage key `sm3Unit2ThereBeTodos`.

Implementation rule:

- Lesson controls on this page use `data-lesson-action`.
- Do not use `data-action` for lesson controls because `data-action` is used by shared mobile navigation.

## Baseball Generation

`sm2/baseball/unit8/baseball-gerunds-ball-sports.html` is generated from `sm2/unit8/gerunds-ball-sports.html`.

Run after changing the source page:

```bash
python3 scripts/generate-baseball.py
python3 scripts/test_generate_baseball.py
```

Do not directly edit the generated baseball Unit 8 page unless changing the generator or tests at the same time.

## Adding A New Lesson

1. Add the page under the right product folder, for example `sm3/unit3/`.
2. Reuse the closest existing lesson page as the template.
3. Use `window.NAV_CONFIG` and shared nav rendering.
4. Add homepage links in `index.html`.
5. Add or update focused tests, especially in `scripts/test_sm3_pages.py` for SM3 pages.
6. Update `README.md`, `TESTING.md`, `AGENTS.md`, and `todo.md` when the course inventory or workflow changes.
7. Run local checks before committing.

## Development Guidelines

- Use semantic HTML (`header`, `main`, `section`, `footer`).
- Keep class names kebab-case.
- Use Tailwind utility classes where practical.
- Keep custom CSS local unless it is clearly shared.
- Prefer event listeners and delegated handlers over inline `onclick`.
- Add `role="button"` and keyboard activation support for clickable non-button elements.
- Keep localStorage keys page-specific when progress state should not overlap.
- Preserve the bilingual English/Chinese lesson format.
- Avoid direct pushes to `master`; use feature branches and PRs.

## Local Testing

```bash
PYTHONDONTWRITEBYTECODE=1 ./test.sh
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest scripts/test_sm3_pages.py
python3 scripts/test_generate_baseball.py
node --check js/common.js
```

For browser preview:

```bash
python3 -m http.server 8000
```

Then visit http://localhost:8000.

## Deployment

GitHub Pages deploys from the protected branch after PR merge. Do not push directly to `master`.
