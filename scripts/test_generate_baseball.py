#!/usr/bin/env python3
"""Unit tests for scripts/generate-baseball.py transform() function."""

import sys
import unittest
from pathlib import Path

# Import the transform function from the hyphenated build script filename
import importlib.util
_script_path = Path(__file__).parent / 'generate-baseball.py'
_spec = importlib.util.spec_from_file_location('generate_baseball', _script_path)
_generate_baseball = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_generate_baseball)
transform = _generate_baseball.transform


class TestTransformPathUpgrades(unittest.TestCase):
    """Test that relative paths are correctly upgraded from ../ to ../../."""

    def test_favicon_path(self):
        source = '<link rel="icon" href="../favicon.svg" type="image/svg+xml">'
        expected = '<link rel="icon" href="../../favicon.svg" type="image/svg+xml">\n'
        self.assertEqual(transform(source), expected)

    def test_ga_js_path(self):
        source = '<script src="../ga.js"></script>'
        expected = '<script src="../../ga.js"></script>\n'
        self.assertEqual(transform(source), expected)

    def test_css_path(self):
        source = '<link rel="stylesheet" href="../css/baseball-theme.css">'
        expected = '<link rel="stylesheet" href="../../css/baseball-theme.css">\n'
        self.assertEqual(transform(source), expected)

    def test_common_js_path(self):
        source = '<script src="../js/common.js"></script>'
        expected = '<script src="../../js/common.js"></script>\n'
        self.assertEqual(transform(source), expected)

    def test_paths_not_double_upgraded(self):
        """Paths that already have ../../ should not be changed."""
        source = '<script src="../../js/common.js"></script>'
        expected = source + '\n'
        self.assertEqual(transform(source), expected)


class TestTransformNavConfig(unittest.TestCase):
    """Test NAV_CONFIG active identifier transformation."""

    def test_active_identifier(self):
        source = "window.NAV_CONFIG = {pattern:'B', active:'unit8-sports'};"
        expected = "window.NAV_CONFIG = {pattern:'B', active:'baseball-unit8-sports'};\n"
        self.assertEqual(transform(source), expected)

    def test_other_identifiers_unchanged(self):
        """Other active values should not be accidentally changed."""
        source = "window.NAV_CONFIG = {pattern:'B', active:'unit7-course'};"
        expected = source + '\n'
        self.assertEqual(transform(source), expected)


class TestTransformMetaDescription(unittest.TestCase):
    """Test meta description text transformation."""

    def test_meta_description(self):
        source = '<meta name="description" content="Unit 8 棒球主题英语学习 — 球类运动词汇与动名词作主语语法">'
        expected = '<meta name="description" content="棒球版 Unit 8 球类运动 — 动名词作主语语法学习">\n'
        self.assertEqual(transform(source), expected)

    def test_other_descriptions_unchanged(self):
        """Other meta descriptions should not be changed."""
        source = '<meta name="description" content="Some other description">'
        expected = source + '\n'
        self.assertEqual(transform(source), expected)


class TestTransformChineseQuotes(unittest.TestCase):
    """Test Chinese right double quotation mark (U+201D) normalization."""

    def test_single_chinese_quote(self):
        source = '他说：”你好！”'
        expected = '他说："你好！"\n'
        self.assertEqual(transform(source), expected)

    def test_multiple_chinese_quotes(self):
        source = '”第一”和”第二”'
        expected = '"第一"和"第二"\n'
        self.assertEqual(transform(source), expected)

    def test_ascii_quotes_unchanged(self):
        """ASCII double quotes should remain unchanged."""
        source = 'He said, "Hello!"'
        expected = source + '\n'
        self.assertEqual(transform(source), expected)


class TestTransformWhitespace(unittest.TestCase):
    """Test blank-line whitespace normalization (lines that are only whitespace)."""

    def test_blank_lines_with_spaces_cleaned(self):
        source = 'line one\n   \nline two'
        expected = 'line one\n\nline two\n'
        self.assertEqual(transform(source), expected)

    def test_blank_lines_with_tabs_cleaned(self):
        source = 'line one\n\t\t\nline two'
        expected = 'line one\n\nline two\n'
        self.assertEqual(transform(source), expected)

    def test_trailing_spaces_on_content_lines_preserved(self):
        """Trailing spaces on lines with content are NOT removed by the script."""
        source = 'line with trailing spaces   \nnext line'
        expected = 'line with trailing spaces   \nnext line\n'
        self.assertEqual(transform(source), expected)

    def test_trailing_tabs_on_content_lines_preserved(self):
        source = 'line with trailing tabs\t\t\nnext line'
        expected = 'line with trailing tabs\t\t\nnext line\n'
        self.assertEqual(transform(source), expected)

    def test_leading_spaces_preserved(self):
        """Leading indentation should be preserved."""
        source = '    indented line\n'
        expected = source
        self.assertEqual(transform(source), expected)


class TestTransformIdempotency(unittest.TestCase):
    """Test that running transform twice produces the same result."""

    def test_idempotent(self):
        source = (
            '<script src="../ga.js"></script>\n'
            "window.NAV_CONFIG = {pattern:'B', active:'unit8-sports'};\n"
            '他说："你好！"\n'
        )
        once = transform(source)
        twice = transform(once)
        self.assertEqual(once, twice)


class TestTransformTrailingNewline(unittest.TestCase):
    """Test that output always ends with a newline."""

    def test_adds_trailing_newline(self):
        source = 'some content without trailing newline'
        result = transform(source)
        self.assertTrue(result.endswith('\n'))

    def test_preserves_existing_trailing_newline(self):
        source = 'some content with trailing newline\n'
        result = transform(source)
        self.assertTrue(result.endswith('\n'))
        self.assertEqual(result.count('\n'), 1)


if __name__ == '__main__':
    unittest.main(verbosity=2)
