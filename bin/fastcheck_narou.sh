#!/bin/bash
# -*- coding:utf-8 -*-

# Check NID
NID="n4830bu n9902bn n0885dc"

# Set Pushbullet token
PUSHBULLET_TOKEN=<PUSHBULLET TOKEN>

# Set "narou init" dir
NAROU_DIR=~/narou


####
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP
####

### main ###
pushd $NAROU_DIR >/dev/null 2>&1
/usr/local/bin/narou update $NID >/dev/null 2>&1
LOGFILE=$NAROU_DIR/log/`/bin/ls -1tr $NAROU_DIR/log | /usr/bin/tail -1`
RES=`egrep "(DL開始|第[0-9]+部分)" < $LOGFILE`

if [ "$RES" != "" ]; then 
    /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
		  --data-binary "{\"body\":\"$RES\",\"title\":\"小説更新\",\"type\":\"note\"}" \
		  --request POST https://api.pushbullet.com/v2/pushes >/dev/null 2>&1
    /usr/local/bin/narou mail $NID >/dev/null 2>&1
fi

popd >/dev/null 2>&1
# EOF
