#!/usr/bin/env python3
"""Unit tests for SM3 pages, folder restructure, nav system, and index page."""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
COMMON_JS = ROOT / 'js' / 'common.js'
INDEX_HTML = ROOT / 'index.html'
SM3_U0 = ROOT / 'sm3' / 'unit0' / 'explorers-be-good-at.html'
SM3_U1 = ROOT / 'sm3' / 'unit1' / 'school-subjects-like-doing.html'
SM3_U1_STORY = ROOT / 'sm3' / 'unit1' / 'story-part.html'
SM3_U2 = ROOT / 'sm3' / 'unit2' / 'there-is-there-are-picnic.html'
SM3_U2_BREAKFAST = ROOT / 'sm3' / 'unit2' / 'breakfast-foods-simple-present.html'

# SM2 sample pages for cross-ref checks
SM2_U7_COURSE = ROOT / 'sm2' / 'unit7' / 'present-continuous-course.html'
SM2_U8_SPORTS = ROOT / 'sm2' / 'unit8' / 'gerunds-ball-sports.html'
SM2_U9_GRAMMAR = ROOT / 'sm2' / 'unit9' / 'holiday-plans-grammar-review.html'
SM2_REVIEW = ROOT / 'sm2' / 'review' / 'review-units-1-3.html'
SM2_BASEBALL_U8 = ROOT / 'sm2' / 'baseball' / 'unit8' / 'baseball-gerunds-ball-sports.html'


def read(path):
    return path.read_text(encoding='utf-8')


# ============================================================
# File Existence & Folder Structure
# ============================================================

class TestFolderStructure(unittest.TestCase):
    """Verify the sm2/ and sm3/ folder separation."""

    def test_sm2_dir_exists(self):
        self.assertTrue((ROOT / 'sm2').is_dir())

    def test_sm3_dir_exists(self):
        self.assertTrue((ROOT / 'sm3').is_dir())

    def test_sm2_unit_dirs(self):
        for d in ['unit7', 'unit8', 'unit9', 'review', 'baseball']:
            with self.subTest(dir=d):
                self.assertTrue((ROOT / 'sm2' / d).is_dir())

    def test_sm3_unit_dirs(self):
        for d in ['unit0', 'unit1', 'unit2']:
            with self.subTest(dir=d):
                self.assertTrue((ROOT / 'sm3' / d).is_dir())

    def test_no_old_dirs(self):
        """Old flat directories should not exist."""
        for d in ['unit7', 'unit8', 'unit9', 'review', 'super-minds-baseball',
                   'sm3-unit0', 'sm3-unit1']:
            with self.subTest(dir=d):
                self.assertFalse((ROOT / d).is_dir(), f'Old dir {d} should not exist')

    def test_all_sm2_html_files_exist(self):
        files = [
            SM2_U7_COURSE, ROOT / 'sm2' / 'unit7' / 'present-continuous-homework.html',
            SM2_U8_SPORTS, ROOT / 'sm2' / 'unit8' / 'amazing-vehicles-reading.html',
            ROOT / 'sm2' / 'unit8' / 'fun-things-we-do-reading.html',
            ROOT / 'sm2' / 'unit8' / 'question-words-grammar-homework.html',
            SM2_U9_GRAMMAR, ROOT / 'sm2' / 'unit9' / 'fairy-tales-reading.html',
            SM2_REVIEW, ROOT / 'sm2' / 'review' / 'review-unit-4.html',
            ROOT / 'sm2' / 'review' / 'review-unit-5.html',
            ROOT / 'sm2' / 'review' / 'review-unit-5-lecture2.html',
            ROOT / 'sm2' / 'baseball' / 'index.html',
            ROOT / 'sm2' / 'baseball' / 'unit7' / 'baseball-present-continuous-course.html',
            ROOT / 'sm2' / 'baseball' / 'unit7' / 'baseball-present-continuous-homework.html',
            SM2_BASEBALL_U8,
        ]
        for f in files:
            with self.subTest(file=str(f.relative_to(ROOT))):
                self.assertTrue(f.exists())

    def test_all_sm3_html_files_exist(self):
        self.assertTrue(SM3_U0.exists())
        self.assertTrue(SM3_U1.exists())
        self.assertTrue(SM3_U1_STORY.exists())
        self.assertTrue(SM3_U2.exists())
        self.assertTrue(SM3_U2_BREAKFAST.exists())


# ============================================================
# SM3 Unit 0 Page Tests
# ============================================================

class TestSM3Unit0Structure(unittest.TestCase):
    """Test basic HTML structure of sm3/unit0/explorers-be-good-at.html."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U0)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_lang_zh_CN(self):
        self.assertIn('lang="zh-CN"', self.html)

    def test_title(self):
        self.assertIn('Super Minds 3 Unit 0', self.html)
        self.assertIn('Explorers', self.html)

    def test_favicon_depth(self):
        self.assertIn('../../favicon.svg', self.html)

    def test_ga_js_depth(self):
        self.assertIn('../../ga.js', self.html)

    def test_common_js_depth(self):
        self.assertIn('../../js/common.js', self.html)

    def test_css_depth(self):
        self.assertIn('../../css/baseball-theme.css', self.html)

    def test_nav_config(self):
        self.assertIn("active:'sm3-unit0'", self.html)
        self.assertIn("brandIcon: 'fa-compass'", self.html)
        self.assertIn('id="site-nav"', self.html)

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestSM3Unit0Vocabulary(unittest.TestCase):
    """Test vocabulary section content."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U0)

    def test_all_12_vocab_words(self):
        words = ['meet', 'explorers', 'find lost treasure', 'museums',
                 'exciting', 'start', 'new adventure', 'castle', 'look for',
                 'tells the secret', 'some lost treasure', 'only people']
        for w in words:
            with self.subTest(word=w):
                self.assertIn(w, self.html)

    def test_story_paragraphs(self):
        self.assertIn('Meet Ben and Lucy', self.html)
        self.assertIn('they are the explorers', self.html)
        self.assertIn('find lost treasure', self.html)

    def test_translation_toggle(self):
        self.assertIn('toggleTranslation(this)', self.html)
        self.assertIn('class="translation"', self.html)


class TestSM3Unit0Grammar(unittest.TestCase):
    """Test be good at + verb-ing grammar section."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U0)

    def test_verb_ing_table(self):
        pairs = [('ride', 'riding'), ('fly', 'flying'), ('climb', 'climbing'),
                 ('swim', 'swimming'), ('do', 'doing'), ('play', 'playing'),
                 ('skate', 'skating'), ('run', 'running')]
        for base, ing in pairs:
            with self.subTest(verb=base):
                self.assertIn(base, self.html)
                self.assertIn(ing, self.html)

    def test_fill_blanks_exist(self):
        self.assertIn('riding', self.html)
        self.assertIn('swimming', self.html)
        self.assertIn('running', self.html)

    def test_rewrite_sentences(self):
        self.assertIn('She is not good at playing chess', self.html)
        self.assertIn('They are good at climbing trees', self.html)

    def test_unscramble(self):
        self.assertIn('I\'m good at riding bikes', self.html)

    def test_word_quiz_section(self):
        self.assertIn('汉译英', self.html)
        self.assertIn('英译汉', self.html)

    def test_todo_section(self):
        self.assertIn('Today\'s Todo', self.html)
        self.assertIn('progressBar', self.html)
        self.assertIn('sm3Unit0Todos', self.html)


# ============================================================
# SM3 Unit 1 Page Tests
# ============================================================

class TestSM3Unit1Structure(unittest.TestCase):
    """Test basic HTML structure of sm3/unit1/school-subjects-like-doing.html."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_title(self):
        self.assertIn('Super Minds 3 Unit 1', self.html)
        self.assertIn('School Subjects', self.html)

    def test_favicon_depth(self):
        self.assertIn('../../favicon.svg', self.html)

    def test_nav_config(self):
        self.assertIn("active:'sm3-unit1'", self.html)
        self.assertIn("brandIcon: 'fa-graduation-cap'", self.html)

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestSM3Unit1Subjects(unittest.TestCase):
    """Test school subjects vocabulary."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_all_7_subjects(self):
        subjects = ['English', 'geography', 'music', 'history', 'dance', 'art', 'PE']
        for s in subjects:
            with self.subTest(subject=s):
                self.assertIn(s, self.html)


class TestSM3Unit1Grammar(unittest.TestCase):
    """Test like/love/hate/dislike + doing grammar section."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_four_patterns(self):
        self.assertIn('like + doing', self.html)
        self.assertIn('likes + doing', self.html)
        self.assertIn("don't like + doing", self.html)
        self.assertIn("doesn't like + doing", self.html)

    def test_summary_table(self):
        self.assertIn('I / You / We / They', self.html)
        self.assertIn('He / She / 单个人名', self.html)

    def test_common_mistakes_table(self):
        self.assertIn('I likes', self.html)
        self.assertIn('danceing', self.html)
        self.assertIn('runing', self.html)
        self.assertIn('studing', self.html)

    def test_mcq_section_exists(self):
        self.assertIn('likes watching', self.html)
        self.assertIn('like playing', self.html)

    def test_auxiliary_mcq_section_exists(self):
        self.assertIn('Does / playing', self.html)
        self.assertIn("don't / dancing", self.html)


class TestSM3Unit1StoryStructure(unittest.TestCase):
    """Test basic HTML structure of sm3/unit1/story-part.html."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1_STORY)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_title(self):
        self.assertIn('Super Minds 3 Unit 1', self.html)
        self.assertIn('Story Part', self.html)

    def test_asset_paths(self):
        self.assertIn('../../favicon.svg', self.html)
        self.assertIn('../../ga.js', self.html)
        self.assertIn('../../css/common.css', self.html)
        self.assertIn('../../css/baseball-theme.css', self.html)
        self.assertIn('../../js/common.js', self.html)

    def test_nav_config(self):
        self.assertIn("active:'sm3-unit1-story'", self.html)
        self.assertIn("brandIcon: 'fa-book-open'", self.html)
        self.assertIn('id="site-nav"', self.html)

    def test_pdf_derived_content(self):
        for text in [
            'When + 句子, 句子.',
            'show a film about China',
            'the lifecycle of butterflies',
            'Miss Burton shows a film about China.',
            'Johnny flies along the Great Wall.',
            'sm3Unit1StoryTodos',
        ]:
            with self.subTest(text=text):
                self.assertIn(text, self.html)

    def test_pdf_source_images_exist(self):
        for asset in ['assets/unit2-source-000.jpg', 'assets/unit2-source-001.jpg']:
            with self.subTest(asset=asset):
                self.assertTrue((SM3_U2.parent / asset).is_file())

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestSM3Unit2Structure(unittest.TestCase):
    """Test basic HTML structure of sm3/unit2/there-is-there-are-picnic.html."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U2)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_title(self):
        self.assertIn('Super Minds 3 Unit 2', self.html)
        self.assertIn('There Is / There Are', self.html)

    def test_asset_paths(self):
        self.assertIn('../../favicon.svg', self.html)
        self.assertIn('../../ga.js', self.html)
        self.assertIn('../../css/common.css', self.html)
        self.assertIn('../../css/baseball-theme.css', self.html)
        self.assertIn('../../js/common.js', self.html)

    def test_nav_config(self):
        self.assertIn("active:'sm3-unit2'", self.html)
        self.assertIn("brandIcon: 'fa-basket-shopping'", self.html)
        self.assertIn('id="site-nav"', self.html)

    def test_lesson_actions_do_not_shadow_mobile_nav(self):
        self.assertNotIn('data-action=', self.html)
        self.assertIn('data-lesson-action="toggle-translation"', self.html)
        self.assertRegex(
            self.html,
            r"(?s)addEventListener\('click'.*?closest\('\[data-lesson-action\]'\)",
        )
        self.assertRegex(
            self.html,
            r"(?s)addEventListener\('keydown'.*?closest\('\[data-lesson-action\]'\)",
        )

    def test_pdf_derived_content(self):
        for text in [
            'assets/unit2-source-000.jpg',
            'assets/unit2-source-001.jpg',
            'Source Pictures',
            'There is + 可数名词单数',
            'D. A shopping list',
            'D. us',
            'D. Drinks',
            'Look at our picnic basket! It is so big.',
            'They are red and sweet.',
            'They are my favourite.',
            "Let's eat it!",
            'A Picnic Song',
            'A Supermarket Food Adventure',
            'four happy friends are ready for an adventure',
            'broccoli soldiers',
            'vegetable aisle',
            'shiny glaze',
            'casting spells',
            'rows of fizzy soda cans',
            'every flavor of juice',
            'bag like a treasure',
            'eyes sparkling',
            'There are four hungry friends ready for a big picnic',
            'they find a king, fairies, and dancing strawberries',
            'cook a big feast together',
            'laughter, friendship, and endless imagination',
            'There are some apples in the picnic basket.',
            'How much bread is there?',
            '复述故事 26-27 页',
            'sm3Unit2ThereBeTodos',
        ]:
            with self.subTest(text=text):
                self.assertIn(text, self.html)

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestSM3Unit2BreakfastStructure(unittest.TestCase):
    """Test basic HTML structure of sm3/unit2/breakfast-foods-simple-present.html."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U2_BREAKFAST)

    def test_doctype(self):
        self.assertTrue(self.html.startswith('<!DOCTYPE html>'))

    def test_title(self):
        self.assertIn('Super Minds 3 Unit 2', self.html)
        self.assertIn('Breakfast &amp; Simple Present', self.html)

    def test_asset_paths(self):
        self.assertIn('../../favicon.svg', self.html)
        self.assertIn('../../ga.js', self.html)
        self.assertIn('../../css/common.css', self.html)
        self.assertIn('../../css/baseball-theme.css', self.html)
        self.assertIn('../../js/common.js', self.html)

    def test_nav_config(self):
        self.assertIn("active:'sm3-unit2-breakfast'", self.html)
        self.assertIn("brandIcon: 'fa-utensils'", self.html)
        self.assertIn('id="site-nav"', self.html)

    def test_lesson_actions_do_not_shadow_mobile_nav(self):
        self.assertNotIn('data-action=', self.html)
        self.assertIn('data-lesson-action="toggle-translation"', self.html)
        self.assertRegex(
            self.html,
            r"(?s)addEventListener\('click'.*?closest\('\[data-lesson-action\]'\)",
        )
        self.assertRegex(
            self.html,
            r"(?s)addEventListener\('keydown'.*?closest\('\[data-lesson-action\]'\)",
        )

    def test_pdf_derived_content(self):
        for text in [
            'Breakfast Around the World',
            'Britain',
            'Brazil',
            'Mexico',
            'make',
            'a special breakfast',
            'have breakfast',
            'have lunch',
            'call',
            'café-da-manhã',
            'scrambled eggs',
            'special cake',
            'eat',
            'fried tomatoes',
            'tortillas',
            'sausage',
            'bacon',
            'beans',
            'fried eggs',
            'toast',
            'tea',
            'orange juice',
            'bread',
            'cheese',
            'mango',
            'watermelon',
            'olives',
            'honey',
            'black tea',
            'At the Pizza Place (order pizza)',
            'Waiter</strong>（服务员）：Student A',
            'Customer</strong>（顾客）：Student B',
            "I'd like a pizza with chicken and mushrooms.",
            "Have you got any onions?",
            'Can I have...?',
            'Customer:</strong> Thank you!',
            "We haven't got any yellow ones. How about a red one?",
            'A Busy Saturday at Home',
            'Dad does the shopping at the supermarket.',
            'She sweeps the floor and tidies up the living room.',
            'He is very happy today because he gets a big bone!',
            'What does Dad do on Saturday?',
            'What does Lucy do after she sweeps the floor?',
            'A Helping Hand at Home',
            "What is the problem at the Johnson family's house every Sunday?",
            "Because she doesn't tidy her room.",
            'Because she gives chocolate cake to the dog.',
            'Who does the shopping?',
            "Lucy's feeling about chores changes",
            'dogs cannot eat chocolate',
            'Lucy feels sorry and quickly gives him his dog food instead.',
            'She buys vegetables, meat and bread.',
            'They also dry all the dishes and put them away.',
            'Dad feels very proud.',
            'Finally, the house is clean, the dog is happy, and the family enjoys a wonderful meal.',
            'fun when doing them together',
            'Simple Present Grammar',
            'do → does',
            'tidy → tidies',
            'Everyone',
            '11. (shout)',
            '12. (feel)',
            '13. (give)',
            '16. (return)',
            '17. (see)',
            '21. (say)',
            '27. (think)',
            "Can I have...?, How about...?",
            'sm3Unit2BreakfastTodos',
        ]:
            with self.subTest(text=text):
                self.assertIn(text, self.html)

    def test_section_tags_balanced(self):
        opens = len(re.findall(r'<section[\s>]', self.html))
        closes = len(re.findall(r'</section>', self.html))
        self.assertEqual(opens, closes)


class TestSM3Unit1Cloze(unittest.TestCase):
    """Test the inline cloze passage section."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_cloze_heading(self):
        self.assertIn('School Is Great', self.html)

    def test_inline_options(self):
        """Each blank should have quiz-option elements right after its sentence."""
        self.assertIn('playing', self.html)   # Q1 answer
        self.assertIn('having', self.html)    # Q2 answer
        self.assertIn('ends', self.html)      # Q4 answer
        self.assertIn('faces', self.html)     # Q10 answer

    def test_chorus_lines(self):
        self.assertIn("School is great. School's for everyone", self.html)
        self.assertIn("And it's lots of fun", self.html)


class TestSM3Unit1Homework(unittest.TestCase):
    """Test homework section."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_homework_date(self):
        self.assertIn('7.11.2026', self.html)

    def test_homework_items(self):
        self.assertIn('复习 like/likes 语法', self.html)
        self.assertIn('Page 14-15', self.html)
        self.assertIn('Page 16-17', self.html)


# ============================================================
# Navigation System Tests (common.js)
# ============================================================

class TestCommonJSNavStructure(unittest.TestCase):
    """Verify the shared nav system supports SM2 and SM3."""

    @classmethod
    def setUpClass(cls):
        cls.js = read(COMMON_JS)

    def test_get_unit_from_active_has_sm3(self):
        self.assertIn("startsWith('sm3-unit0')", self.js)
        self.assertIn("startsWith('sm3-unit1')", self.js)
        self.assertIn("startsWith('sm3-unit2')", self.js)

    def test_nav_links_has_sm3_patterns(self):
        self.assertIn('B_sm3_unit0:', self.js)
        self.assertIn('B_sm3_unit1:', self.js)
        self.assertIn('B_sm3_unit2:', self.js)

    def test_sm3_patterns_have_sm2_cross_refs(self):
        """SM3 patterns should have sm2/ prefix in cross-refs."""
        self.assertIn('../../sm2/unit7/', self.js)
        self.assertIn('../../sm2/unit8/', self.js)
        self.assertIn('../../sm2/unit9/', self.js)
        self.assertIn('../../sm2/review/', self.js)

    def test_sm3_patterns_have_sibling_refs(self):
        """SM3 unit0 should link to ../unit1/ and vice versa."""
        self.assertIn('../unit1/school-subjects-like-doing.html', self.js)
        self.assertIn('../unit1/story-part.html', self.js)
        self.assertIn('../unit0/explorers-be-good-at.html', self.js)
        self.assertIn('../unit2/there-is-there-are-picnic.html', self.js)

    def test_data_speak_has_keyboard_support(self):
        self.assertIn("closest('[data-speak]')", self.js)
        self.assertIn("e.key !== 'Enter'", self.js)
        self.assertIn("window.speak(text, el)", self.js)

    def test_sm2_patterns_have_sm3_section(self):
        """All SM2 NAV_LINKS patterns should have sm3: section."""
        sm3_count = len(re.findall(r'^\s+sm3:\s*\{', self.js, re.MULTILINE))
        # A, B_unit8, B_unit9, B_review, B_baseball-unit8, B_sm3_unit0, B_sm3_unit1, B_sm3_unit2 = 8
        self.assertGreaterEqual(sm3_count, 8)

    def test_build_pattern_b_has_sm3_rendering(self):
        self.assertIn('hasSm3', self.js)
        self.assertIn('isSm3', self.js)

    def test_build_pattern_a_has_sm3_rendering(self):
        self.assertIn('isSm2', self.js)
        self.assertIn('isSm3', self.js)

    def test_sm2_mega_dropdown(self):
        """Build functions should render SM2 mega-dropdown."""
        self.assertIn('sm2Group', self.js)
        self.assertIn('Unit 7', self.js)
        self.assertIn('复习 Review', self.js)

    def test_sm3_dropdown_matches_sm2_group_pattern(self):
        """SM3 dropdown should use grouped unit headings like SM2."""
        self.assertIn('var sm3Groups', self.js)
        self.assertIn("sm2Group('Unit 0'", self.js)
        self.assertIn("sm2Group('Unit 1'", self.js)
        self.assertIn("sm2Group('Unit 2'", self.js)
        self.assertIn('mobileSm3Groups', self.js)

    def test_sm3_desktop_dropdown_is_right_aligned(self):
        """SM3 desktop dropdown should not clip at the right viewport edge."""
        self.assertIn('absolute right-0 top-full min-w-72', self.js)
        self.assertIn('whitespace-normal break-words leading-snug', self.js)

    def test_sm2_desktop_dropdown_uses_columns(self):
        """SM2 desktop dropdown should be compact enough to show all groups."""
        self.assertIn('w-[42rem] max-w-[calc(100vw-2rem)]', self.js)
        self.assertIn('group-hover:grid grid-cols-2 lg:grid-cols-4', self.js)
        self.assertIn('gap-x-6', self.js)

    def test_desktop_dropdowns_are_height_constrained(self):
        """Long desktop dropdowns should scroll inside the menu."""
        self.assertIn('max-h-[calc(100vh-5rem)]', self.js)
        self.assertIn('overflow-y-auto', self.js)
        self.assertIn('overscroll-contain', self.js)

    def test_mobile_nav_uses_collapsible_sections(self):
        self.assertIn('function mobileSection', self.js)
        self.assertIn('<details class="rounded-lg bg-white/5"', self.js)
        self.assertIn('<summary class="cursor-pointer select-none px-3 py-2 text-sm font-bold text-white list-none">', self.js)
        self.assertIn("mobileSection('SM2', mobileSm2Content, isSm2)", self.js)
        self.assertIn("mobileSection('SM3', mobileSm3Groups, isSm3)", self.js)

    def test_mobile_nav_action_remains_common_only(self):
        self.assertIn('button[data-action="toggle-mobile-menu"]', self.js)
        self.assertNotIn('toggle-mobile-menu', read(SM3_U2))

    def test_brand_label(self):
        """Brand should be 'Super Minds' not 'Super Minds 2'."""
        self.assertIn('Super Minds', self.js)

    def test_home_href_depth(self):
        """SM2 patterns should use ../../index.html for home."""
        self.assertIn("../../index.html", self.js)


# ============================================================
# HTML Asset Path Depth Tests
# ============================================================

class TestAssetPathsDepth(unittest.TestCase):
    """Verify correct relative path depth for all page levels."""

    def test_sm2_unit_pages_depth2(self):
        """SM2 unit pages are at depth 2, use ../../ for root."""
        pages = [SM2_U7_COURSE, SM2_U8_SPORTS, SM2_U9_GRAMMAR, SM2_REVIEW]
        for p in pages:
            html = read(p)
            with self.subTest(file=p.name):
                self.assertIn('../../favicon.svg', html)
                self.assertIn('../../ga.js', html)
                self.assertIn('../../js/common.js', html)

    def test_sm3_pages_depth2(self):
        """SM3 pages are at depth 2, use ../../ for root."""
        for p in [SM3_U0, SM3_U1, SM3_U1_STORY, SM3_U2, SM3_U2_BREAKFAST]:
            html = read(p)
            with self.subTest(file=p.name):
                self.assertIn('../../favicon.svg', html)
                self.assertIn('../../ga.js', html)
                self.assertIn('../../js/common.js', html)

    def test_baseball_index_depth2(self):
        """Baseball index at sm2/baseball/ is depth 2."""
        html = read(ROOT / 'sm2' / 'baseball' / 'index.html')
        self.assertIn('../../favicon.svg', html)
        self.assertIn('../../ga.js', html)

    def test_baseball_unit_pages_depth3(self):
        """Baseball unit pages at sm2/baseball/unit*/ are depth 3."""
        pages = [
            ROOT / 'sm2' / 'baseball' / 'unit7' / 'baseball-present-continuous-course.html',
            ROOT / 'sm2' / 'baseball' / 'unit7' / 'baseball-present-continuous-homework.html',
            SM2_BASEBALL_U8,
        ]
        for p in pages:
            html = read(p)
            with self.subTest(file=p.name):
                self.assertIn('../../../favicon.svg', html)
                self.assertIn('../../../ga.js', html)
                self.assertIn('../../../js/common.js', html)


# ============================================================
# Index Page Tests
# ============================================================

class TestIndexPage(unittest.TestCase):
    """Verify index.html organization."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(INDEX_HTML)

    def test_sm2_cards_exist(self):
        self.assertIn('SM2 · Unit 7', self.html)
        self.assertIn('SM2 · Unit 8', self.html)
        self.assertIn('SM2 · Unit 9', self.html)
        self.assertIn('SM2 · Review', self.html)

    def test_sm3_cards_exist(self):
        self.assertIn('SM3 · Unit 0', self.html)
        self.assertIn('SM3 · Unit 1', self.html)
        self.assertIn('SM3 · Unit 2', self.html)

    def test_sm3_links(self):
        self.assertIn('sm3/unit0/explorers-be-good-at.html', self.html)
        self.assertIn('sm3/unit1/school-subjects-like-doing.html', self.html)
        self.assertIn('sm3/unit1/story-part.html', self.html)
        self.assertIn('sm3/unit2/there-is-there-are-picnic.html', self.html)
        self.assertIn('sm3/unit2/breakfast-foods-simple-present.html', self.html)

    def test_sm2_card_order(self):
        """SM2 cards should appear before SM3 cards."""
        sm2_first = self.html.find('SM2 · Unit 7')
        sm2_last = self.html.rfind('SM2 · Review')
        sm3_first = self.html.find('SM3 · Unit 0')
        self.assertLess(sm2_first, sm3_first)
        self.assertLess(sm2_last, sm3_first)

    def test_sm2_links_use_sm2_prefix(self):
        self.assertIn('sm2/unit7/', self.html)
        self.assertIn('sm2/unit8/', self.html)
        self.assertIn('sm2/unit9/', self.html)
        self.assertIn('sm2/review/', self.html)


# ============================================================
# Cross-Page Navigation Tests
# ============================================================

class TestCrossPageNavigation(unittest.TestCase):
    """Verify pages can navigate between SM2 and SM3."""

    def test_sm3_u0_links_to_sm3_u1(self):
        """SM3 unit0 page should have a link to SM3 unit1."""
        html = read(SM3_U0)
        # The NAV_CONFIG will generate the link, so check NAV_LINKS in common.js
        js = read(COMMON_JS)
        self.assertIn('../unit1/school-subjects-like-doing.html', js)

    def test_sm2_pages_have_sm3_in_navlinks(self):
        """Every SM2 B-pattern should have sm3 entries in NAV_LINKS."""
        js = read(COMMON_JS)
        # SM3 link paths in SM2 depth-2 context should point to ../../sm3/unit0/...
        self.assertIn('../../sm3/unit0/explorers-be-good-at.html', js)
        self.assertIn('../../sm3/unit1/school-subjects-like-doing.html', js)
        self.assertIn('../../sm3/unit1/story-part.html', js)
        self.assertIn('../../sm3/unit2/there-is-there-are-picnic.html', js)
        self.assertIn('../../sm3/unit2/breakfast-foods-simple-present.html', js)

    def test_baseball_sm3_paths_at_depth_3(self):
        """B_baseball-unit8 SM3 paths must use ../../../sm3/ (depth 3)."""
        js = read(COMMON_JS)
        self.assertIn("../../../sm3/unit0/explorers-be-good-at.html", js,
                      "B_baseball-unit8 SM3 paths must use ../../../sm3/ for depth 3")
        self.assertIn("../../../sm3/unit1/school-subjects-like-doing.html", js)
        self.assertIn("../../../sm3/unit1/story-part.html", js)
        self.assertIn("../../../sm3/unit2/there-is-there-are-picnic.html", js)
        self.assertIn("../../../sm3/unit2/breakfast-foods-simple-present.html", js)
        self.assertIn("🍳 SM3 Unit 2 Breakfast", js)

    def test_sm3_pages_have_sm2_in_navlinks(self):
        """SM3 patterns should have cross-references to SM2 pages."""
        js = read(COMMON_JS)
        self.assertIn('../../sm2/unit7/present-continuous-course.html', js)
        self.assertIn('../../sm2/unit8/gerunds-ball-sports.html', js)
        self.assertIn('../../sm2/review/review-units-1-3.html', js)


# ============================================================
# Accessibility Tests
# ============================================================

class TestAccessibility(unittest.TestCase):
    """Verify accessibility attributes on SM3 pages."""

    def test_sm3_u0_aria_hidden_on_speaker_icons(self):
        html = read(SM3_U0)
        # All speaker icons should have aria-hidden
        speakers = re.findall(r'<span class="speaker-icon"', html)
        aria_hidden = re.findall(r'<span class="speaker-icon" aria-hidden="true"', html)
        self.assertEqual(len(speakers), len(aria_hidden))

    def test_sm3_u0_aria_hidden_on_float_anims(self):
        html = read(SM3_U0)
        floats = re.findall(r'class="float-anim"', html)
        aria_floats = re.findall(r'class="float-anim".*aria-hidden="true"', html)
        self.assertEqual(len(floats), len(aria_floats))

    def test_sm3_u1_aria_hidden_on_speaker_icons(self):
        html = read(SM3_U1)
        speakers = re.findall(r'<span class="speaker-icon"', html)
        aria_hidden = re.findall(r'<span class="speaker-icon" aria-hidden="true"', html)
        self.assertEqual(len(speakers), len(aria_hidden))

    def test_sm3_u1_aria_hidden_on_float_anims(self):
        html = read(SM3_U1)
        floats = re.findall(r'class="float-anim"', html)
        aria_floats = re.findall(r'class="float-anim".*aria-hidden="true"', html)
        self.assertEqual(len(floats), len(aria_floats))

    def test_sm3_u1_story_aria_hidden_on_speaker_icons(self):
        html = read(SM3_U1_STORY)
        speakers = re.findall(r'<span class="speaker-icon"', html)
        aria_hidden = re.findall(r'<span class="speaker-icon" aria-hidden="true"', html)
        self.assertEqual(len(speakers), len(aria_hidden))

    def test_sm3_u1_story_aria_hidden_on_float_anims(self):
        html = read(SM3_U1_STORY)
        floats = re.findall(r'class="float-anim"', html)
        aria_floats = re.findall(r'class="float-anim".*aria-hidden="true"', html)
        self.assertEqual(len(floats), len(aria_floats))

    def test_sm3_u2_aria_hidden_on_speaker_icons(self):
        html = read(SM3_U2)
        speakers = re.findall(r'<span class="speaker-icon"', html)
        aria_hidden = re.findall(r'<span class="speaker-icon" aria-hidden="true"', html)
        self.assertEqual(len(speakers), len(aria_hidden))

    def test_sm3_u2_aria_hidden_on_float_anims(self):
        html = read(SM3_U2)
        floats = re.findall(r'class="float-anim"', html)
        aria_floats = re.findall(r'class="float-anim".*aria-hidden="true"', html)
        self.assertEqual(len(floats), len(aria_floats))

    def test_sm3_pages_have_tabindex_on_interactive(self):
        for p in [SM3_U0, SM3_U1, SM3_U1_STORY, SM3_U2]:
            html = read(p)
            with self.subTest(file=p.name):
                self.assertIn('tabindex="0"', html)
                self.assertIn('role="button"', html)


# ============================================================
# Cloze Inline Format Tests
# ============================================================

class TestClozeInlineFormat(unittest.TestCase):
    """Verify cloze passage uses inline quiz-option format."""

    @classmethod
    def setUpClass(cls):
        cls.html = read(SM3_U1)

    def test_quiz_options_in_cloze(self):
        """The cloze section should have quiz-option elements (not word-quiz-blank)."""
        # Find the cloze section between "School Is Great" and the next section
        cloze_start = self.html.find('School Is Great')
        cloze_end = self.html.find('Homework · 作业', cloze_start)
        cloze_section = self.html[cloze_start:cloze_end]

        # Should have quiz-option elements
        self.assertIn('quiz-option', cloze_section)
        self.assertIn('quiz-answer-box', cloze_section)

    def test_each_blank_has_inline_options(self):
        """Verify all 10 blanks have A/B/C/D options."""
        cloze_start = self.html.find('School Is Great')
        cloze_end = self.html.find('Homework · 作业', cloze_start)
        cloze_section = self.html[cloze_start:cloze_end]

        # Count quiz-answer-box elements (one per blank)
        answer_boxes = re.findall(r'quiz-answer-box', cloze_section)
        self.assertEqual(len(answer_boxes), 10)


if __name__ == '__main__':
    unittest.main()
