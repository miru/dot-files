#!/bin/bash

PUSHBULLET_TOKEN=<PUSHBULLET token>

CACHE_DIR=~/tmp/fastcheck_narou_cache
CHECK_ID="372556:n4830bu 282802:n9902bn"
NAROU_DIR=~/narou

###
if [ ! -d $CACHE_DIR ]; then
    mkdir $CACHE_DIR
fi

###
pushd $NAROU_DIR >/dev/null 2>&1


###
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
    DIFF_NUM=`echo $?`

    if [ $DIFF_NUM -ne 0 ]; then
	#narou up $NID >/dev/null 2>&1
	RES=`narou up $NID`
	curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
	     --data-binary "{\"body\":\"$RES\",\"title\":\"小説更新\",\"type\":\"note\"}" \
	     --request POST https://api.pushbullet.com/v2/pushes >/dev/null 2>&1
	narou ma $NID >/dev/null 2>&1
    fi
    
    cp -f $CACHE_FILE.new $CACHE_FILE
    rm -f $CACHE_FILE.new
    
done

popd >/dev/null 2>&1
# EOF
