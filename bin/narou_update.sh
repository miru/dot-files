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
/usr/local/bin/narou update -n
tag_add_noconv ./log/`ls -1t log | head -1`

popd
# EOF
