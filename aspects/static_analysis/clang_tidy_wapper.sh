#!/bin/bash
set -euo pipefail
executable=$1
output=$2
arguments=${@:3}
$executable $arguments 2>&1 | tee $output
