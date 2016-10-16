#!/bin/bash
# -*- coding:utf-8 -*-

# Get Settings
. `dirname $0`/narou_update.settings

# Load function
. `dirname $0`/narou_update_func.sh

# tag for check
TAG=${1:-fastcheck}


# run check
wait_other_script

### main ###
pushd $NAROU_DIR

# Check NID
NID=`$NAROU list -t $TAG -f nonfrozen | cat`

# Update
$NAROU update -n $NID
NAROU_LOG=./log/`ls -1t log | head -1`

# add tag: no convert
tag_add_noconv $NAROU_LOG

# Send push notification if update
RES_NEW=`egrep "新着" $NAROU_LOG`

if [ ! "$RES_NEW" = "" ]; then
    send_notification "【小説更新】【$TAG】" "$NAROU_LOG"
fi

popd
# EOF
