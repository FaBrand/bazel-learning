from some_important_py_lib import py_lib
from another_important_py_lib import py_lib as another
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('launch')
    args = parser.parse_args()
    print("Reading within python script:")
    with open(args.launch) as l:
        print(l.read())

    print(py_lib.SOME_IMPORTANT_CONSTANT)
    print(another.ANOTHER_IMPORTANT_CONSTANT)
