from __future__ import print_function

import argparse
import sys
import os
import random


def main(out_directory, number):
    possible_artifacts = ['Main_%s'%c for c in 'abcdefghijklmnobqrstuvwxyz']
    os.makedirs(out_directory)
    for i, artifact in enumerate(random.sample(possible_artifacts, k=number)):
            print('Generating', i, artifact)
            with open(os.path.join(out_directory, '{}.cc'.format(artifact)), 'w') as f:
                f.write("""
                        // Sample content: {i} - {art}
                        """.format(i=i, art=artifact))




def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--output_directory", default=None)
    parser.add_argument("-n", "--number_of_outs", default=1, type=int)
    return parser.parse_args()

if __name__ == "__main__":
    args = get_arguments()
    print(args)
    main(args.output_directory, args.number_of_outs)
