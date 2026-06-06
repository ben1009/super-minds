#!/usr/bin/env python3
"""Unit tests for review/review-unit-5-lecture2.html content, structure, and cross-references."""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
HTML_FILE = ROOT / 'review' / 'review-unit-5-lecture2.html'
COMMON_JS = ROOT / 'js' / 'common.js'
INDEX_HTML = ROOT / 'index.html'


def read(path):
    return path.read_text(encoding='utf-8')


class TestFileExistence(unittest.TestCase):
    """Test that all required files exist."""

    def test_html_file_exists(self):
        self.assertTrue(HTML_FILE.exists())

    def test_common_js_exists(self):
        self.assertTrue(COMMON_JS.exists())

    def test_index_html_exists(self):
        self.assertTrue(INDEX_HTML.exists())


class TestHTMLStructure(unittest.TestCase):
    """Test basic HTML structure and dependencies."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_lang(self):
        self.assertIn('lang="zh-CN"', self.html)

    def test_charset(self):
        self.assertIn('charset="UTF-8"', self.html)

    def test_viewport(self):
        self.assertIn('name="viewport"', self.html)

    def test_title(self):
        self.assertIn('Unit 5 第二讲', self.html)

    def test_favicon(self):
        self.assertIn('favicon.svg', self.html)

    def test_tailwind(self):
        self.assertIn('cdn.tailwindcss.com', self.html)

    def test_font_awesome(self):
        self.assertIn('font-awesome', self.html)

    def test_common_js(self):
        self.assertIn('../js/common.js', self.html)

    def test_footer(self):
        self.assertIn('<footer', self.html)

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestContentPart0(unittest.TestCase):
    """Test Part 0: intro overview of special questions."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_intro_heading(self):
        self.assertIn('一般现在时的特殊疑问句 · 问什么答什么', self.html)

    def test_all_8_question_words(self):
        for w in ['What', 'Where', 'When', 'Which', 'Who', 'Whose', 'How', 'Why']:
            with self.subTest(word=w):
                self.assertIn(f'<strong>{w}</strong>', self.html)

    def test_non_third_person_what(self):
        self.assertIn('What</strong> do you do on Sunday', self.html)

    def test_third_person_what(self):
        self.assertIn('What</strong> does he do on Sunday', self.html)

    def test_non_third_person_where(self):
        self.assertIn('Where</strong> do you play basketball', self.html)
        self.assertIn('Where</strong> do they play basketball', self.html)

    def test_third_person_where(self):
        self.assertIn('Where</strong> does Shannon play basketball', self.html)
        self.assertIn('Where</strong> does he go swimming', self.html)


class TestContentPart1(unittest.TestCase):
    """Test Part 1: be-verb special questions."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('有 be 动词 (am/is/are)', self.html)

    def test_when(self):
        self.assertIn('When</strong> is your birthday', self.html)

    def test_which(self):
        self.assertIn('Which</strong> is your pen', self.html)

    def test_who(self):
        self.assertIn('Who</strong> is that girl', self.html)

    def test_whose(self):
        self.assertIn('Whose</strong> book is this', self.html)
        self.assertIn('Whose</strong> ruler is this', self.html)

    def test_how_old(self):
        self.assertIn('How old</strong> are you', self.html)

    def test_why(self):
        self.assertIn('Why</strong> is he late', self.html)


class TestContentPart2(unittest.TestCase):
    """Test Part 2: do/does special questions."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('有实义动词 (do/does)', self.html)

    def test_when_do(self):
        self.assertIn('When</strong> do you get up', self.html)

    def test_when_does(self):
        self.assertIn('When</strong> does Tiantian get up', self.html)
        self.assertIn('When</strong> does Mary go to bed', self.html)

    def test_which(self):
        self.assertIn('Which one</strong> does she like', self.html)


class TestContentPart3(unittest.TestCase):
    """Test Part 3: Let's Recycle reading passage."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_exists(self):
        self.assertIn("Let's Recycle", self.html)

    def test_reading_passage_keywords(self):
        self.assertIn('landfills', self.html)
        self.assertIn('rubbish', self.html)

    def test_what_can_we_recycle(self):
        self.assertIn('What can we recycle', self.html)
        for item in ['Paper', 'Plastic', 'Glass', 'Metal']:
            with self.subTest(item=item):
                self.assertIn(item, self.html)

    def test_how_do_we_recycle(self):
        self.assertIn('How do we recycle', self.html)
        self.assertIn('recycling bin', self.html)
        self.assertIn('recycling centre', self.html)

    def test_why_recycling_important(self):
        self.assertIn('Why is recycling important', self.html)
        self.assertIn('saves energy', self.html)


class TestContentPart4(unittest.TestCase):
    """Test Part 4: homework questions."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('作业：阅读回答问题', self.html)

    def test_all_6_questions(self):
        questions = [
            'When do you usually recycle',
            'Which bin do you put',
            'Who takes out the recycling',
            'Whose job is it',
            'How do you clean',
            'Why is recycling better',
        ]
        for q in questions:
            with self.subTest(question=q):
                self.assertIn(q, self.html)


class TestContentPart5(unittest.TestCase):
    """Test Part 5: 16 fill-in-the-blank exercises."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('特殊疑问句练习题（共 16 题）', self.html)

    def test_exercise_count(self):
        count = len(re.findall(r'data-answer="[^"]+"', self.html))
        self.assertGreaterEqual(count, 16)

    def test_answers(self):
        expected = {
            '1': 'When', '2': 'Whose', '3': 'How', '4': 'Who',
            '5': 'Why', '6': 'Where', '7': 'Which', '8': 'When',
            '9': 'Who', '10': 'How', '11': 'Whose', '12': 'Why',
            '13': 'Where', '14': 'What', '15': 'What', '16': 'When',
        }
        for num, ans in expected.items():
            with self.subTest(question=num, answer=ans):
                pattern = rf'{num}\.\s*<span[^>]*data-answer="{ans}"'
                self.assertRegex(self.html, pattern)

    def test_q15_second_blank(self):
        self.assertIn('data-answer="sunny"', self.html)

    def test_q16_second_blank(self):
        self.assertIn("data-answer=\"o'clock\"", self.html)


class TestContentPart6(unittest.TestCase):
    """Test Part 6: comparison table."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('对比总结表', self.html)

    def test_table_rows(self):
        section = self.html[self.html.index('对比总结表'):]
        self.assertIn('When is the party', section)
        self.assertIn('Which is your seat', section)
        self.assertIn('Who is your teacher', section)
        self.assertIn('Whose bag is this', section)
        self.assertIn('How is your dad', section)


class TestContentPart7(unittest.TestCase):
    """Test Part 7: mnemonic rhyme."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_section_heading(self):
        self.assertIn('记忆小口诀', self.html)

    def test_rhyme_lines(self):
        self.assertIn('be 哥', self.html)
        self.assertIn('往前站', self.html)
        self.assertIn('情态大哥', self.html)
        self.assertIn('Do/Does', self.html)
        self.assertIn('来帮忙', self.html)
        self.assertIn('动词三单要', self.html)
        self.assertIn('问号', self.html)


class TestContentPart8(unittest.TestCase):
    """Test Part 8: supplementary content."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_label(self):
        self.assertIn('以下未讲', self.html)

    def test_section_heading(self):
        self.assertIn('Who / Whose / How + 实义动词', self.html)


class TestSpeakableWords(unittest.TestCase):
    """Test speakable months and days with translations."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_months_speakable(self):
        months = ['January', 'February', 'March', 'April', 'May', 'June',
                  'July', 'August', 'September', 'October', 'November', 'December']
        for m in months:
            with self.subTest(month=m):
                self.assertIn(f'class="speakable" data-speak="{m}"', self.html)

    def test_days_speakable(self):
        days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
                'Friday', 'Saturday', 'Sunday']
        for d in days:
            with self.subTest(day=d):
                self.assertIn(f'class="speakable" data-speak="{d}"', self.html)

    def test_month_translations(self):
        cn = ['一月', '二月', '三月', '四月', '五月', '六月',
              '七月', '八月', '九月', '十月', '十一月', '十二月']
        for t in cn:
            with self.subTest(translation=t):
                self.assertIn(t, self.html)

    def test_day_translations(self):
        cn = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
        for t in cn:
            with self.subTest(translation=t):
                self.assertIn(t, self.html)


class TestClickToTranslate(unittest.TestCase):
    """Test click-to-translate functionality."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_translation_css(self):
        self.assertIn('.reading-passage .translation', self.html)
        self.assertIn('.translation.show', self.html)

    def test_main_passage_translations(self):
        section = self.html[self.html.index('Reading Passage'):self.html.index('What can we recycle')]
        count = section.count('toggleTranslation')
        self.assertGreaterEqual(count, 2)

    def test_how_section_translations(self):
        section = self.html[self.html.index('How do we recycle'):self.html.index('Why is recycling important')]
        count = section.count('toggleTranslation')
        self.assertEqual(count, 4)

    def test_toggle_function_referenced(self):
        self.assertIn('toggleTranslation', self.html)

    def test_chinese_translations_present(self):
        self.assertIn('垃圾填埋场', self.html)
        self.assertIn('回收利用', self.html)
        self.assertIn('回收中心', self.html)


class TestNavigation(unittest.TestCase):
    """Test navigation config and cross-references."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)
        cls.common = read(COMMON_JS)
        cls.index = read(INDEX_HTML)

    def test_nav_config_pattern(self):
        self.assertIn("pattern:'B'", self.html)

    def test_nav_config_active(self):
        self.assertIn("active:'review-unit-5-lecture2'", self.html)

    def test_get_unit_from_active(self):
        self.assertIn("active.startsWith('review')", self.common)

    def test_b_review_has_key(self):
        self.assertIn("key: 'review-unit-5-lecture2'", self.common)

    def test_a_section_has_link(self):
        section = self.common[self.common.index('A:'):self.common.index('B_unit8:')]
        self.assertIn('review-unit-5-lecture2', section)

    def test_b_unit8_has_link(self):
        section = self.common[self.common.index('B_unit8:'):self.common.index('B_unit9:')]
        self.assertIn('review-unit-5-lecture2', section)

    def test_b_unit9_has_link(self):
        section = self.common[self.common.index('B_unit9:'):self.common.index('B_review:')]
        self.assertIn('review-unit-5-lecture2', section)

    def test_index_card_link(self):
        self.assertIn('href="review/review-unit-5-lecture2.html"', self.index)

    def test_index_bottom_link(self):
        bottom = self.index[self.index.rfind('review-unit-5-lecture2'):]
        self.assertIn('Unit 5 第二讲', bottom)


class TestCSSStyles(unittest.TestCase):
    """Test that required CSS styles are defined."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_speakable(self):
        self.assertIn('.speakable', self.html)
        self.assertIn('cursor: pointer', self.html)

    def test_speakable_hover(self):
        self.assertIn('.speakable:hover', self.html)

    def test_speakable_speaking(self):
        self.assertIn('.speakable.speaking', self.html)

    def test_exercise_blank(self):
        self.assertIn('.exercise-blank', self.html)
        self.assertIn('border-bottom: 2px dashed', self.html)

    def test_exercise_blank_revealed(self):
        self.assertIn('.exercise-blank.revealed', self.html)

    def test_grammar_formula(self):
        self.assertIn('.grammar-formula', self.html)

    def test_sentence_example(self):
        self.assertIn('.sentence-example', self.html)

    def test_rhyme_box(self):
        self.assertIn('.rhyme-box', self.html)


class TestTodoSystem(unittest.TestCase):
    """Test todo system configuration."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_localstorage_key(self):
        self.assertIn("'unit5Lecture2Todos'", self.html)

    def test_todo_item_count(self):
        count = len(re.findall(r'data-todo="\d+"', self.html))
        self.assertEqual(count, 5)

    def test_reset_button(self):
        self.assertIn('resetTodoItems', self.html)

    def test_progress_bar(self):
        self.assertIn('progressBar', self.html)

    def test_dom_content_loaded(self):
        self.assertIn("localStorage.getItem('unit5Lecture2Todos')", self.html)


class TestGrammarAccuracy(unittest.TestCase):
    """Test grammar and content accuracy fixes."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(HTML_FILE)

    def test_why_tense_consistent(self):
        self.assertIn('Because he is', self.html)
        self.assertNotIn('Because he missed', self.html)

    def test_summer_lowercase(self):
        self.assertIn('in summer', self.html)
        self.assertNotIn('in Summer', self.html)

    def test_who_note(self):
        self.assertIn('Who做主语时不用do/does', self.html)

    def test_whose_note(self):
        self.assertIn('Whose+名词做主语时不用do/does', self.html)

    def test_earth_consistent(self):
        self.assertIn('bad for the Earth', self.html)

    def test_homework_reference_note(self):
        self.assertIn('答案仅供参考', self.html)


if __name__ == '__main__':
    unittest.main(verbosity=2)
