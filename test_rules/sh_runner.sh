#!/bin/bash
echo "run python"
${@: 1:1} ${@: 2:1}
echo "Read second"
cat ${@: 2:1}
echo "Read third"
cat ${@: 3}
