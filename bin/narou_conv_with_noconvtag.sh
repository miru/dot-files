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
NAME=`$NAROU list -t $NOCONV_TAG -e | grep -v "タイトル" | awk -F\| '{print $3}'`
NID=`$NAROU list -t $NOCONV_TAG | cat`


# Convert
$NAROU convert $NID

# edit tag
$NAROU tag -d $NOCONV_TAG $NID
$NAROU tag -a $NOSEND_TAG -c yellow $NID

# Send push notification if update
case "$NOTIFY_TYPE" in
    "PUSHBULLET")
	send_notification_pushbullet "【変換完了】" "$NAME"
	;;
    "LINE")
	send_notification_line "【変換完了】" "$NAME"
	;;
    "SLACK")
	send_notification_slack "【変換完了】" "$NAME"
	;;
esac

popd
# EOF
