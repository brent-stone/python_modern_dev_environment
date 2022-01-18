#!/usr/bin/env python
"""
Dev Demo
---------
Demonstrate the ability to implement the following statistical measures:

Mean
"""


def mean(data: list[str] = None) -> float:
    """
    Calculate the mean of a vector of scalar values

    Args:
        data (list[str]): A vector of scalar numerical data

    Returns:
        The mean of the data

    Raises:
        TypeError: An error occurred if a value is non-numerical

    """
    if not data or len(data) <= 0:
        return 0.0

    the_sum: float = 0.0

    for item in data:
        if isinstance(item, str) and item.isdigit():
            the_sum += float(item)
        else:
            raise TypeError("Non numerical value in mean().\n")

    return the_sum / len(data)
