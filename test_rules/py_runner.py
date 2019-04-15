from some_important_py_lib import py_lib
import argparse
from pprint import pprint

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('launch')
    args = parser.parse_args()
    print("Reading within python script:")
    with open(args.launch) as l:
        print(l.read())

    print(py_lib.SOME_IMPORTANT_CONSTANT)
