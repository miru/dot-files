#!/bin/csh

setenv CMD1DIR "~/app/TwitterIrcGateway/"
setenv CMD1CMD "TwitterIrcGatewayCLI"
setenv CMD1OPT "--port=16668 --interval=30 -interval-directmessage=60 --post-fetch-mode=true --broadcast-update=false --encoding=utf-8 --enable-replies-check=true --interval-replies=30 --ignore-watch-error=true --client-message-wait=100 --broadcast-update-message-is-notice=true"
setenv CMD2CMD "Twitter"

@ CMD1NO=`ps aux | grep ug3 | grep $CMD2CMD | grep -v grep | wc -l | sed s/" "//g`

if ( $CMD1NO == 0 ) then
  echo "Detect lost $CMD1CMD ..."

  sleep 1
  echo "Execute $CMD1CMD..."
  echo $CMD1CMD $CMD1OPT
  cd $CMD1DIR
  nohup ./$CMD1CMD $CMD1OPT &
endif

