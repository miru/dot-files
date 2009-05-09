#!/bin/sh

ID=matomatter

PASS=enamor

curl -s --basic --user "$ID:$PASS" --data-ascii "status=$*" "http://twitter.com/statuses/update.json"

