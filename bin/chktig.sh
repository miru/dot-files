#!/bin/csh

setenv CMD1DIR "~/app/TwitterIrcGateway/"
setenv CMD1CMD "mono TwitterIrcGatewayCLI.exe"
setenv CMD1OPT "--port=16668 --encoding=utf-8"
setenv CMD2CMD "Twitter"

@ CMD1NO=`ps aux | grep miru | grep $CMD2CMD | grep -v grep | wc -l | sed s/" "//g`

if ( $CMD1NO == 0 ) then
  echo "Detect lost $CMD1CMD ..."

  sleep 1
  cd ~miru
  echo "Execute $CMD1CMD..."
  echo $CMD1CMD $CMD1OPT
  cd $CMD1DIR
  nohup $CMD1CMD $CMD1OPT &
endif

