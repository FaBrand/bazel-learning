from __future__ import print_function
import sys
import os
import json
from pprint import pprint


def load_json(json_file):
    with open(json_file) as jsn:
        data = json.load(jsn)
    print('Name loaded from json:', data['name'])


def print_env_info():
    print('pwd', os.getcwd())
    print('dir contents', os.listdir(os.getcwd()))
    print('python-version', sys.version)


if __name__ == "__main__":
    print_env_info()
    load_json('runfile.json')
