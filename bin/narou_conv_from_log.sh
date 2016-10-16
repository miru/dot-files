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

# Check NID
NAME=`cat log/update_log_**.txt | egrep "^ID.*DL開始" | perl -pe 's/(ID:\d+.*) のDL開始/\1/g' | sort | uniq`
NID=`echo $NAME | perl -pe 's/ID:/\n/g' | perl -pe 's/^(\d+).*/\1/g' | sort -n`

# Convert
/usr/local/bin/narou convert $NID

# Send push notification if update
send_notification 【変換完了】 "$NAME"

popd
# EOF
