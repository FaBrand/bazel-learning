#!/usr/bin/env python3
import sys
from string import Template

s = Template('''#include <iostream>

int main(int, char**) {
    std::cout << "$what" << '\\n';
    return 0;
}
''')

if __name__ == "__main__":
    where = sys.argv[1]
    what = sys.argv[2]

    with open(where, 'w') as f:
        f.write(s.substitute(what=what))
