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
$NAROU update -f -n
tag_add_noconv

popd
# EOF
