#!/bin/bash
set -euxo pipefail
echo "${1}" > "${2}"
sleep 5s
