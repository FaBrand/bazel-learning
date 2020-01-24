#!/bin/bash

echo 'Arguments:'
echo  "'${@}'"

for script in "${@}"; do
    "${script}"
done
