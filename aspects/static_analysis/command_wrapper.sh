#!/bin/bash

# A small shell wrapper script to pipe the output of an arbitrary command
# to a file.
# Usage:
# <executable> <output_file> <arguments...>

set -euo pipefail
executable=$1
output=$2
arguments=${@:3}
$executable $arguments 2>&1 | tee $output
