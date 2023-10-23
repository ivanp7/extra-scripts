#!/bin/sh
curl -s 'https://devexcuses.ru/' | sed '/^<meta property="og:description"/!d; s/.* content="\([^"]*\)".*/\1/'

