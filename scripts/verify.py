#! /usr/bin/env python3

import json
import re
import os
from glob import glob

ID_REGEX = re.compile(r'[A-Z]{3}\d{4}')

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

PATH = os.path.join(BASE_DIR, 'src/*.json')

if __name__ == '__main__':
    try:
        for path in sorted(glob(PATH)):
            print(path)

            with open(path) as file:
                file_content = file.read()

            assert file_content[-1] == '\n'

            data = json.loads(file_content)

            assert ID_REGEX.match(data['id']) is not None

            assert data['name'] != ''

            term = data['term']

            assert (isinstance(term, int) and 1 <= term <= 8)or term is None

            for entry in data['entries']:
                assert entry['title'] != ''
                assert entry['link'] != ''

    except (AssertionError, json.decoder.JSONDecodeError) as e:
        raise AssertionError('file {} has an error'.format(path)) from e

    print('All is well')
