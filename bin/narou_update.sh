#!/bin/bash
# -*- coding:utf-8 -*-

PUSHBULLET_TOKEN=<PUSHBULLET TOKEN>
NAROU_DIR=~/narou
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP


pushd $NAROU_DIR

/usr/local/bin/narou u 
#cp -fp ./**/*.mobi ~/narou/converted/Kindle
#cp -fp ./**/*.epub ~/narou/converted/EPUB

LOGFILE=$NAROU_DIR/log/`/bin/ls -1tr $NAROU_DIR/log | /usr/bin/tail -1`
#LOGFILE=$NAROU_DIR/updatelog_sample2.txt                                 # for DEBUG
RES=`cat $LOGFILE | egrep "(DL開始|第[0-9]+部分)"`


if [ "$RES" != "" ]; then
    RES=`echo "$RES" | perl -pe 's/^ID:[0-9]+　/\n/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g' | perl -pe 's/ のDL開始//g' | perl -pe 's/\n/\\\n/g'`
    echo "$RES"
    /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
		  --data-binary "{\"body\":\"$RES\",\"title\":\"小説更新\",\"type\":\"note\"}" \
		  --request POST https://api.pushbullet.com/v2/pushes
fi
popd

# EOF
