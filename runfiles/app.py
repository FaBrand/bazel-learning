from __future__ import print_function
import sys
import os
import json
from pprint import pprint


def load_json(json_file):
    try:
        with open(json_file) as jsn:
            data = json.load(jsn)
        print('Loaded json file:', json_file)
    except FileNotFoundError:
        print('File could not be found:', json_file)


def print_env_info():
    print('pwd', os.getcwd())
    print('dir contents', os.listdir(os.getcwd()))
    print('python-version', sys.version)


if __name__ == "__main__":
    print_env_info()
    load_json('runfile.json')
    load_json('default_runfile.json')
    load_json('data_runfile.json')
    load_json('runfile_symlinks_link')
    load_json('runfile_root_symlinks_link')
    load_json('runfile_root_symlinks.json')
