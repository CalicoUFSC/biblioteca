#! /bin/sh

python3 verify.py

if [[ $? != 0 ]]; then
    echo "A JSON file contain errors!"
    exit
fi

python3 compile.py
