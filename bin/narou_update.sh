#!/bin/bash
# -*- coding:utf-8 -*-

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

# Update
/usr/local/bin/narou update 


popd
# EOF
