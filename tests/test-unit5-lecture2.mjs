import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(__dirname, '..');
const FILE = resolve(ROOT, 'review/review-unit-5-lecture2.html');
const COMMON = resolve(ROOT, 'js/common.js');
const INDEX = resolve(ROOT, 'index.html');

function read(path) {
  return readFileSync(path, 'utf-8');
}

// ─── 1. File Existence ───
describe('File existence', () => {
  it('review-unit-5-lecture2.html exists', () => {
    assert.ok(existsSync(FILE));
  });
  it('common.js exists', () => {
    assert.ok(existsSync(COMMON));
  });
  it('index.html exists', () => {
    assert.ok(existsSync(INDEX));
  });
});

// ─── 2. HTML Structure ───
describe('HTML structure', () => {
  const html = read(FILE);

  it('has DOCTYPE', () => {
    assert.ok(html.startsWith('<!DOCTYPE html>'));
  });
  it('has lang="zh-CN"', () => {
    assert.ok(html.includes('lang="zh-CN"'));
  });
  it('has meta charset UTF-8', () => {
    assert.ok(html.includes('charset="UTF-8"'));
  });
  it('has viewport meta', () => {
    assert.ok(html.includes('name="viewport"'));
  });
  it('title contains Unit 5 第二讲', () => {
    assert.ok(html.includes('Unit 5 第二讲'));
  });
  it('has favicon', () => {
    assert.ok(html.includes('favicon.svg'));
  });
  it('loads tailwindcss', () => {
    assert.ok(html.includes('cdn.tailwindcss.com'));
  });
  it('loads font-awesome', () => {
    assert.ok(html.includes('font-awesome'));
  });
  it('loads common.js', () => {
    assert.ok(html.includes('../js/common.js'));
  });
  it('has footer', () => {
    assert.ok(html.includes('<footer'));
  });
  it('closing tags balanced', () => {
    const opens = (html.match(/<section[\s>]/g) || []).length;
    const closes = (html.match(/<\/section>/g) || []).length;
    assert.equal(opens, closes, `sections: ${opens} opens vs ${closes} closes`);
  });
});

// ─── 3. Content Completeness ───
describe('Content completeness - Sections', () => {
  const html = read(FILE);

  it('Part 0: intro overview exists', () => {
    assert.ok(html.includes('一般现在时的特殊疑问句 · 问什么答什么'));
  });
  it('Part 0: lists all 8 question words', () => {
    for (const w of ['What', 'Where', 'When', 'Which', 'Who', 'Whose', 'How', 'Why']) {
      assert.ok(html.includes(`<strong>${w}</strong>`), `missing question word: ${w}`);
    }
  });
  it('Part 0: has non-third-person What example', () => {
    assert.ok(html.includes('What</strong> do you do on Sunday'));
  });
  it('Part 0: has third-person What example', () => {
    assert.ok(html.includes('What</strong> does he do on Sunday'));
  });
  it('Part 0: has non-third-person Where examples', () => {
    assert.ok(html.includes('Where</strong> do you play basketball'));
    assert.ok(html.includes('Where</strong> do they play basketball'));
  });
  it('Part 0: has third-person Where examples', () => {
    assert.ok(html.includes('Where</strong> does Shannon play basketball'));
    assert.ok(html.includes('Where</strong> does he go swimming'));
  });

  it('Part 1: be-verb section exists', () => {
    assert.ok(html.includes('有 be 动词 (am/is/are)'));
  });
  it('Part 1: has When be-verb example', () => {
    assert.ok(html.includes('When</strong> is your birthday'));
  });
  it('Part 1: has Which be-verb example', () => {
    assert.ok(html.includes('Which</strong> is your pen'));
  });
  it('Part 1: has Who be-verb example', () => {
    assert.ok(html.includes('Who</strong> is that girl'));
  });
  it('Part 1: has Whose be-verb examples', () => {
    assert.ok(html.includes('Whose</strong> book is this'));
    assert.ok(html.includes('Whose</strong> ruler is this'));
  });
  it('Part 1: has How old example', () => {
    assert.ok(html.includes('How old</strong> are you'));
  });
  it('Part 1: has Why example', () => {
    assert.ok(html.includes('Why</strong> is he late'));
  });

  it('Part 2: do/does section exists', () => {
    assert.ok(html.includes('有实义动词 (do/does)'));
  });
  it('Part 2: has When do/does examples', () => {
    assert.ok(html.includes('When</strong> do you get up'));
    assert.ok(html.includes('When</strong> does Tiantian get up'));
    assert.ok(html.includes('When</strong> does Mary go to bed'));
  });
  it('Part 2: has Which do/does example', () => {
    assert.ok(html.includes('Which one</strong> does she like'));
  });

  it('Part 3: Recycle section exists', () => {
    assert.ok(html.includes('Let\'s Recycle'));
  });
  it('Part 3: has reading passage about landfills', () => {
    assert.ok(html.includes('landfills'));
    assert.ok(html.includes('rubbish'));
  });
  it('Part 3: has What can we recycle subsection', () => {
    assert.ok(html.includes('What can we recycle'));
    assert.ok(html.includes('Paper'));
    assert.ok(html.includes('Plastic'));
    assert.ok(html.includes('Glass'));
    assert.ok(html.includes('Metal'));
  });
  it('Part 3: has How do we recycle subsection', () => {
    assert.ok(html.includes('How do we recycle'));
    assert.ok(html.includes('recycling bin'));
    assert.ok(html.includes('recycling centre'));
  });
  it('Part 3: has Why is recycling important subsection', () => {
    assert.ok(html.includes('Why is recycling important'));
    assert.ok(html.includes('saves energy'));
  });

  it('Part 4: homework section exists with 6 questions', () => {
    assert.ok(html.includes('作业：阅读回答问题'));
    assert.ok(html.includes('When do you usually recycle'));
    assert.ok(html.includes('Which bin do you put'));
    assert.ok(html.includes('Who takes out the recycling'));
    assert.ok(html.includes('Whose job is it'));
    assert.ok(html.includes('How do you clean'));
    assert.ok(html.includes('Why is recycling better'));
  });

  it('Part 5: exercise section exists', () => {
    assert.ok(html.includes('特殊疑问句练习题（共 16 题）'));
  });

  it('Part 6: comparison table exists with 5 rows', () => {
    assert.ok(html.includes('对比总结表'));
    const tableSection = html.slice(html.indexOf('对比总结表'));
    assert.ok(tableSection.includes('When is the party'));
    assert.ok(tableSection.includes('Which is your seat'));
    assert.ok(tableSection.includes('Who is your teacher'));
    assert.ok(tableSection.includes('Whose bag is this'));
    assert.ok(tableSection.includes('How is your dad'));
  });

  it('Part 7: mnemonic rhyme exists', () => {
    assert.ok(html.includes('记忆小口诀'));
    assert.ok(html.includes('be 哥'));
    assert.ok(html.includes('往前站'));
    assert.ok(html.includes('情态大哥'));
    assert.ok(html.includes('Do/Does'));
    assert.ok(html.includes('来帮忙'));
    assert.ok(html.includes('动词三单要'));
    assert.ok(html.includes('问号'));
  });

  it('Part 8: supplementary section exists with 以下未讲 label', () => {
    assert.ok(html.includes('以下未讲'));
    assert.ok(html.includes('Who / Whose / How + 实义动词'));
  });
});

// ─── 4. Speakable Words ───
describe('Speakable words', () => {
  const html = read(FILE);

  const months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const monthCn = ['一月', '二月', '三月', '四月', '五月', '六月',
    '七月', '八月', '九月', '十月', '十一月', '十二月'];
  const dayCn = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  for (const m of months) {
    it(`month ${m} is speakable`, () => {
      assert.ok(html.includes(`class="speakable" data-speak="${m}"`), `missing speakable: ${m}`);
    });
  }
  for (const d of days) {
    it(`day ${d} is speakable`, () => {
      assert.ok(html.includes(`class="speakable" data-speak="${d}"`), `missing speakable: ${d}`);
    });
  }
  for (const cn of monthCn) {
    it(`month translation ${cn} present`, () => {
      assert.ok(html.includes(cn), `missing translation: ${cn}`);
    });
  }
  for (const cn of dayCn) {
    it(`day translation ${cn} present`, () => {
      assert.ok(html.includes(cn), `missing translation: ${cn}`);
    });
  }
});

// ─── 5. Exercise Answers ───
describe('Exercise answers (16 questions)', () => {
  const html = read(FILE);
  const answers = [
    ['1', 'When'],
    ['2', 'Whose'],
    ['3', 'How'],
    ['4', 'Who'],
    ['5', 'Why'],
    ['6', 'Where'],
    ['7', 'Which'],
    ['8', 'When'],
    ['9', 'Who'],
    ['10', 'How'],
    ['11', 'Whose'],
    ['12', 'Why'],
    ['13', 'Where'],
    ['14', 'What'],
    ['15', 'What'],
    ['16', 'When'],
  ];

  for (const [num, expected] of answers) {
    it(`Q${num} answer is ${expected}`, () => {
      const pattern = new RegExp(`${num}\\.\\s*<span[^>]*data-answer="${expected}"`);
      assert.ok(pattern.test(html), `Q${num}: expected data-answer="${expected}"`);
    });
  }

  it('Q15 has second blank (sunny)', () => {
    assert.ok(html.includes('data-answer="sunny"'));
  });
  it('Q16 has second blank (o\'clock)', () => {
    assert.ok(html.includes('data-answer="o\'clock"'));
  });
});

// ─── 6. Translations ───
describe('Click-to-translate', () => {
  const html = read(FILE);

  it('has .translation CSS', () => {
    assert.ok(html.includes('.reading-passage .translation'));
  });
  it('has .translation.show CSS', () => {
    assert.ok(html.includes('.translation.show'));
  });
  it('main reading passage has translate-able divs', () => {
    const readingSection = html.slice(html.indexOf('Reading Passage'), html.indexOf('What can we recycle'));
    const onclicks = (readingSection.match(/toggleTranslation/g) || []).length;
    assert.ok(onclicks >= 2, `expected >=2 toggleTranslation in main passage, got ${onclicks}`);
  });
  it('How do we recycle section has 4 translate-able divs', () => {
    const howSection = html.slice(html.indexOf('How do we recycle'), html.indexOf('Why is recycling important'));
    const onclicks = (howSection.match(/toggleTranslation/g) || []).length;
    assert.equal(onclicks, 4, `expected 4 toggleTranslation in How section, got ${onclicks}`);
  });
  it('has toggleTranslation function reference', () => {
    assert.ok(html.includes('toggleTranslation'));
  });
  it('translations have Chinese text', () => {
    assert.ok(html.includes('垃圾填埋场'));
    assert.ok(html.includes('回收利用'));
    assert.ok(html.includes('回收中心'));
  });
});

// ─── 7. Navigation ───
describe('Navigation', () => {
  const html = read(FILE);
  const common = read(COMMON);
  const index = read(INDEX);

  it('NAV_CONFIG has pattern B', () => {
    assert.ok(html.includes("pattern:'B'"));
  });
  it('NAV_CONFIG has active review-unit-5-lecture2', () => {
    assert.ok(html.includes("active:'review-unit-5-lecture2'"));
  });
  it('getUnitFromActive returns review for review-unit-5-lecture2', () => {
    assert.ok(common.includes("active.startsWith('review')"));
  });
  it('B_review NAV_LINKS has the key', () => {
    assert.ok(common.includes("key: 'review-unit-5-lecture2'"));
  });
  it('A section has the nav link', () => {
    const aSection = common.slice(common.indexOf('A:'), common.indexOf('B_unit8:'));
    assert.ok(aSection.includes('review-unit-5-lecture2'));
  });
  it('B_unit8 section has the nav link', () => {
    const section = common.slice(common.indexOf('B_unit8:'), common.indexOf('B_unit9:'));
    assert.ok(section.includes('review-unit-5-lecture2'));
  });
  it('B_unit9 section has the nav link', () => {
    const section = common.slice(common.indexOf('B_unit9:'), common.indexOf('B_review:'));
    assert.ok(section.includes('review-unit-5-lecture2'));
  });
  it('index.html has card link', () => {
    assert.ok(index.includes('href="review/review-unit-5-lecture2.html"'));
  });
  it('index.html has bottom quick-link', () => {
    const bottomSection = index.slice(index.lastIndexOf('review-unit-5-lecture2'));
    assert.ok(bottomSection.includes('Unit 5 第二讲'));
  });
});

// ─── 8. CSS & JS ───
describe('CSS styles', () => {
  const html = read(FILE);

  it('.speakable styles defined', () => {
    assert.ok(html.includes('.speakable'));
    assert.ok(html.includes('cursor: pointer'));
  });
  it('.speakable:hover styles defined', () => {
    assert.ok(html.includes('.speakable:hover'));
  });
  it('.speakable.speaking styles defined', () => {
    assert.ok(html.includes('.speakable.speaking'));
  });
  it('.exercise-blank styles defined', () => {
    assert.ok(html.includes('.exercise-blank'));
    assert.ok(html.includes('border-bottom: 2px dashed'));
  });
  it('.exercise-blank.revealed styles defined', () => {
    assert.ok(html.includes('.exercise-blank.revealed'));
  });
  it('.grammar-formula styles defined', () => {
    assert.ok(html.includes('.grammar-formula'));
  });
  it('.sentence-example styles defined', () => {
    assert.ok(html.includes('.sentence-example'));
  });
  it('.rhyme-box styles defined', () => {
    assert.ok(html.includes('.rhyme-box'));
  });
});

// ─── 9. Todo System ───
describe('Todo system', () => {
  const html = read(FILE);

  it('uses localStorage key unit5Lecture2Todos', () => {
    assert.ok(html.includes("'unit5Lecture2Todos'"));
  });
  it('has 5 todo items', () => {
    const todoCount = (html.match(/data-todo="\d+"/g) || []).length;
    assert.equal(todoCount, 5, `expected 5 todo items, got ${todoCount}`);
  });
  it('has reset button', () => {
    assert.ok(html.includes('resetTodoItems'));
  });
  it('has progress bar', () => {
    assert.ok(html.includes('progressBar'));
  });
  it('DOMContentLoaded reads from localStorage', () => {
    assert.ok(html.includes("localStorage.getItem('unit5Lecture2Todos')"));
  });
});

// ─── 10. Grammar Accuracy ───
describe('Grammar accuracy', () => {
  const html = read(FILE);

  it('Why example uses consistent present tense (is sick, not missed bus)', () => {
    assert.ok(html.includes('Because he is'));
    assert.ok(!html.includes('Because he missed'));
  });
  it('Summer is lowercase', () => {
    assert.ok(html.includes('in summer'));
    assert.ok(!html.includes('in Summer'));
  });
  it('Who row has do/does warning note', () => {
    assert.ok(html.includes('Who做主语时不用do/does'));
  });
  it('Whose row has do/does warning note', () => {
    assert.ok(html.includes('Whose+名词做主语时不用do/does'));
  });
  it('reading passage uses consistent "the Earth"', () => {
    assert.ok(html.includes('bad for the Earth'));
  });
  it('homework notes answers are reference only', () => {
    assert.ok(html.includes('答案仅供参考'));
  });
  it('no "in Summer" typo', () => {
    const lines = html.split('\n');
    for (const line of lines) {
      if (line.includes('in Summer')) {
        assert.fail(`found "in Summer" in line: ${line.trim()}`);
      }
    }
  });
});
