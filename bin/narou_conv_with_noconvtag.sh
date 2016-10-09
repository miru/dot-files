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
NAME=`$NAROU -t noconv -e | | awk -F"|" '{print $3}'`
NID=`$NAROU -t noconv | cat`


# Convert
$NAROU convert $NID

# Send push notification if update
send_notification 変換完了 "$NAME"

popd
# EOF
