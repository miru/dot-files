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

# add tag: noconv
tag_add_noconv

# Send push notification if update
RES=`$NAROU update -l 1 | egrep "(DL開始|第[0-9]+部分.*\(新着\)|完結したようです)"`
RES_NEW=`echo -n $RES | egrep "新着" | wc -l`

if [ $RES_NEW -ge 1 ]; then
    send_notification "小説更新 TAG:$TAG" "$RES"
fi

popd
# EOF
