#!/usr/bin/env python3
"""
Generate the baseball-themed variant of Unit 8 gerunds page.

Usage:
    python3 scripts/generate-baseball.py

This script reads unit8/gerunds-ball-sports.html and produces
super-minds-baseball/unit8/baseball-gerunds-ball-sports.html with
only the necessary path and branding transformations applied.

The two pages are ~95% identical; this script is the single source
of truth for the transformations.
"""

import re
import sys
from pathlib import Path

SOURCE = Path("unit8/gerunds-ball-sports.html")
OUTPUT = Path("super-minds-baseball/unit8/baseball-gerunds-ball-sports.html")


def transform(content: str) -> str:
    # 1. Fix Chinese right double quotation marks (U+201D) to ASCII quotes
    content = content.replace('”', '"')

    # 2. Update meta description
    content = content.replace(
        'Unit 8 棒球主题英语学习 — 球类运动词汇与动名词作主语语法',
        '棒球版 Unit 8 球类运动 — 动名词作主语语法学习'
    )

    # 3. Path upgrades: ../ → ../../ for assets referenced from super-minds-baseball/unit8/
    content = content.replace('href="../favicon.svg"', 'href="../../favicon.svg"')
    content = content.replace('src="../ga.js"', 'src="../../ga.js"')
    content = content.replace('href="../css/baseball-theme.css"', 'href="../../css/baseball-theme.css"')
    content = content.replace('src="../js/common.js"', 'src="../../js/common.js"')

    # 4. Update NAV_CONFIG active identifier
    content = content.replace(
        "window.NAV_CONFIG = {pattern:'B', active:'unit8-sports'};",
        "window.NAV_CONFIG = {pattern:'B', active:'baseball-unit8-sports'};"
    )

    # 5. Normalize trailing whitespace on blank lines for clean diff
    content = re.sub(r'^[ \t]+$', '', content, flags=re.MULTILINE)

    # 6. Ensure trailing newline
    if not content.endswith('\n'):
        content += '\n'

    return content


def main() -> int:
    if not SOURCE.exists():
        print(f"ERROR: Source file not found: {SOURCE}", file=sys.stderr)
        return 1

    content = SOURCE.read_text(encoding='utf-8')
    transformed = transform(content)

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(transformed, encoding='utf-8')

    print(f"Generated: {OUTPUT}")
    return 0


if __name__ == '__main__':
    sys.exit(main())
