#!/bin/bash
# -*- coding:utf-8 -*-

# NOTIFY_TYPE:
#  PUSHBULLET: PushBullet
#  LINE: LINE
NOTIFY_TYPE=LINE

# tag for check
TAG=${1:-fastcheck}

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
NID=`/usr/local/bin/narou list -t $TAG | cat`

# Update
/usr/local/bin/narou update $NID

# Log check
LOGFILE=$NAROU_DIR/log/`/bin/ls -1tr $NAROU_DIR/log | /usr/bin/tail -1`
#LOGFILE=$NAROU_DIR/updatelog_sample.txt                                  # for DEBUG

#RES=`cat $LOGFILE | egrep "(DL開始|第[0-9]+部分)"`
RES=`cat $LOGFILE | egrep "(DL開始|第[0-9]+部分.*\(新着\)|完結したようです)"`
RES_NEW=`echo $RES | egrep "新着" | wc -l`

# Send push notification if update
#if [ "$RES" != "" ]; then
if [ $RES_NEW -ne 0 ]; then

    FLG=NG
    while [ $FLG = "NG" ]
    do
	case "$NOTIFY_TYPE" in
	    "PUSHBULLET")
		RES=`echo "$RES" | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g' | perl -pe 's/\n/\\\n/g'`
		/usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
			      --data-binary "{\"body\":\"$RES\",\"title\":\"小説更新 TAG:$TAG\",\"type\":\"note\"}" \
			      --request POST https://api.pushbullet.com/v2/pushes
		;;
	    "LINE")
		echo "RES_before"
		echo $RES
		echo ""
		RES=`echo "$RES" | perl -pe 's/ID:[0-9]+　(.*) のDL開始/
\1/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g' | perl -pe 's/\n/
/g'`
		echo "RES_after"
		echo $RES
		/usr/bin/curl https://notify-api.line.me/api/notify -X POST -H "Authorization: Bearer $LINE_TOKEN" \
			      -F "message=TAG:$TAG$RES"
		;;
	esac
	if [ $? -eq 0 ]; then
	    FLG=OK
	fi
    done
#    /usr/local/bin/narou freeze --on end
fi

popd
# EOF
