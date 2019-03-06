from __future__ import print_function

import sys
import os

__import__('pprint').pprint(os.environ['PYTHONPATH'].split(':'))
__import__('pprint').pprint(sys.path)

from py_library import lib_module

lib_module.doo_stuff()
