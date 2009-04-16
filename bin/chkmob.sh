#!/bin/csh

setenv CMD1CMD "./mobirc"
setenv CMD1OPT "--daemonize"

@ CMD1NO=`ps aux | grep ug3 | grep $CMD1CMD | grep -v grep | wc -l| sed s/" "//g`

if ( $CMD1NO == 0 ) then
  echo "Detect lost $CMD1CMD ..."
  sleep 5
  echo "Execute $CMD1CMD..."
  cd ~/app/mobirc/
  nohup $CMD1CMD $CMD1OPT &
endif

