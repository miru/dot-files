#!/bin/bash
# -*- coding:utf-8 -*-

# Get Settings
. `dirname $0`/narou_update.settings

# Load function
. `dirname $0`/narou_update_func.sh

# run check
wait_other_script

pushd $NAROU_DIR

$NAROU s hotentry.auto-mail=false

$NAROU u -n `$NAROU list -t 未読 -f nonfrozen | cat` > $NAROU_LOG
tag_add_noconv ./log/`ls -1t log | head -1`

$NAROU u -n `$NAROU list -t 切 -f nonfrozen | cat` > $NAROU_LOG
tag_add_noconv ./log/`ls -1t log | head -1`


$NAROU s hotentry.auto-mail=true

$NAROU freeze --on end
$NAROU freeze --on 404

popd

# EOF

