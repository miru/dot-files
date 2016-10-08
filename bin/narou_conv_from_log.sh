#!/bin/bash
# -*- coding:utf-8 -*-

# NOTIFY_TYPE:
#  PUSHBULLET: PushBullet
#  LINE: LINE
NOTIFY_TYPE=LINE

# Get TOKEN
. `dirname $0`/narou_update.token


# Set "narou init" dir
NAROU_DIR=~/narou

####
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP
####

# run check
while  [ `ps -ef|grep /usr/local/bin/narou|wc -l` -ne 1 ]
do
    echo "waiting"
    sleep 30
done
       
### main ###
pushd $NAROU_DIR

# Check NID
NAME=`cat log/update_log_**.txt | egrep "^ID.*DL開始" | perl -pe 's/(ID:\d+.*) のDL開始/\1/g' | sort -n | uniq`
NID=`echo $NAME | perl -pe 's/ID:/\n/g' | perl -pe 's/^(\d+).*/\1/g' | sort`


# Convert
/usr/local/bin/narou convert $NID

# Send push notification if update
FLG=NG
while [ $FLG = "NG" ]
do
    case "$NOTIFY_TYPE" in
	"PUSHBULLET")
	    /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
			  --data-binary "{\"body\":\"$NAME\",\"title\":\"小説変換 - 完了\",\"type\":\"note\"}" \
			  --request POST https://api.pushbullet.com/v2/pushes
	    ;;
	"LINE")
	    /usr/bin/curl https://notify-api.line.me/api/notify -X POST -H "Authorization: Bearer $LINE_TOKEN" \
			  -F "message=小説変換 - 完了
$NAME"
	    ;;
    esac
    if [ $? -eq 0 ]; then
	FLG=OK
    fi
done


popd
# EOF
