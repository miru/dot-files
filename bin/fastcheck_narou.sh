#!/bin/bash
# -*- coding:utf-8 -*-

# Set check ID "ATOMID:nID"
CHECK_ID="372556:n4830bu 282802:n9902bn 615833:n0885dc"

# Set Pushbullet token
PUSHBULLET_TOKEN=<PUSHBULLET token>

# Set "narou init" dir
NAROU_DIR=~/narou

# Set cache dir
CACHE_DIR=~/tmp/fastcheck_narou_cache

####
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP
####

### main ###
if [ ! -d $CACHE_DIR ]; then
    mkdir $CACHE_DIR
fi
###
pushd $NAROU_DIR >/dev/null 2>&1
###

### loop ###
for ID in $CHECK_ID
do
    AID=`echo $ID | awk -F: '{print $1}'`
    NID=`echo $ID | awk -F: '{print $2}'`
    CACHE_FILE=$CACHE_DIR/$NID.cdata

    if [ ! -f $CACHE_FILE ]; then
	touch $CACHE_FILE
    fi
    
    curl -s  http://api.syosetu.com/writernovel/$AID.Atom | grep CDATA > $CACHE_FILE.new

    diff $CACHE_FILE $CACHE_FILE.new >/dev/null 2>&1
    if [ $? -ne 0 ]; then
	RES=`/usr/local/bin/narou up $NID | egrep ".mobi" | sed "s/.mobi を出力しました//g"`
	TIT=`echo $RES | sed "s/\[.*\] //g"`
	curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
	     --data-binary "{\"body\":\"$RES が更新されました\",\"title\":\"小説更新 $TIT\",\"type\":\"note\"}" \
	     --request POST https://api.pushbullet.com/v2/pushes >/dev/null 2>&1
	/usr/local/bin/narou ma $NID >/dev/null 2>&1
    fi
    
    cp -f $CACHE_FILE.new $CACHE_FILE
    rm -f $CACHE_FILE.new
    
done

popd >/dev/null 2>&1
# EOF
