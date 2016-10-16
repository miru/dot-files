#!/bin/bash
# -*- coding:utf-8 -*-

# Get Settings
. `dirname $0`/narou_update.settings

# Load function
. `dirname $0`/narou_update_func.sh

# run check
wait_other_script

### main ###
pushd $NAROU_DIR

# Update
#$NAROU update -f -n
$HOME/.gem/ruby/2.3.0/bin/narou update -f -n
tag_add_noconv ./log/`ls -1t log | head -1`

popd
# EOF
