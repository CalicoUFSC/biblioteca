#! /bin/bash

set -e # Exit with nonzero exit code if anything fails

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

python3 $BASE_DIR/verify.py

if [[ $? != 0 ]]; then
    echo "A JSON file contain errors!"
    exit 1
fi

python3 $BASE_DIR/compile.py
