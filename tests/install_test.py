#!/usr/bin/env python
"""
Pytest Example
---------
"""
import sys

from dev_demo import main
from dev_demo import math_demo


def test_start() -> None:
    args: list[str] = sys.argv[1:]
    assert 1 == main(args)
    assert 1 == main([])


def test_mean_empty() -> None:
    assert 0.0 == math_demo.mean([])


def test_mean_simple() -> None:
    assert 5.0 == math_demo.mean(["5", "5", "5"])
