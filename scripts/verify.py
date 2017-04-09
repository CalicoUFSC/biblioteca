#! /usr/bin/env python3

import json
import re
from glob import glob

ID_REGEX = re.compile(r'[A-Z]{3}\d{4}')

PATH = '../src/*.json'

if __name__ == '__main__':
    try:
        for path in sorted(glob(PATH)):
            print(path)

            with open(path) as json_file:
                data = json.load(json_file)

            assert ID_REGEX.match(data['id']) is not None

            assert data['name'] != ''

            assert isinstance(data['term'], int) or data['term'] is None

            for entry in data['entries']:
                assert entry['title'] != ''
                assert entry['link'] != ''

    except (AssertionError, json.decoder.JSONDecodeError) as e:
        raise AssertionError('file {} has an error'.format(path)) from e

    print('All is well')
