__version__ = "0.0.1"

from dev_demo.math_demo import mean


def main(args: list[str]) -> int:
    """
    A templated entry point into the dev demo.

    Args:
        args (list[str]): positional arguments from command line

    Returns:
        1 on success, 0 otherwise

    """
    print("Hello, Dev Demo!")

    print("CLI Arguments:")
    if not args:
        print("\tNone.")
    else:
        for arg in args:
            print(f"\t{arg}")
        try:
            mean(args)
        except TypeError:
            print("\tMean cannot be calculated. Non-numbers provided.")
    return 1
