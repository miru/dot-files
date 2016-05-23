#!/bin/bash
# -*- coding:utf-8 -*-

# tag for check
TAG="fastcheck"

# Set Pushbullet token
PUSHBULLET_TOKEN=<Pushbullet TOKEN>

# Set "narou init" dir
NAROU_DIR=~/narou


####
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP
####

### main ###
pushd $NAROU_DIR

# Check NID
NID=`/usr/local/bin/narou list -t $TAG | cat`

# Update
/usr/local/bin/narou update $NID

# Log check
LOGFILE=$NAROU_DIR/log/`/bin/ls -1tr $NAROU_DIR/log | /usr/bin/tail -1`
#LOGFILE=$NAROU_DIR/updatelog_sample.txt                                  # for DEBUG

RES=`cat $LOGFILE | egrep "(DL開始|第[0-9]+部分)"`

# Send push notification if update
if [ "$RES" != "" ]; then
    RES=`echo "$RES" | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g' | perl -pe 's/\n/\\\n/g'`

    FLG=NG
    while [ $FLG = "NG" ]
    do
	  /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
			--data-binary "{\"body\":\"$RES\",\"title\":\"注目の小説更新\",\"type\":\"note\"}" \
			--request POST https://api.pushbullet.com/v2/pushes
	  if [ $? -eq 0 ]; then
	      FLG=OK
	  fi
    done
fi

popd
# EOF
