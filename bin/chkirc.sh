#!/bin/csh

setenv CMD1CMD "~/app/tiarra/tiarra"
setenv CMD1OPT "--config=/home/miru/app/tiarra/tiarra.conf"
setenv CMD2CMD "tiarra"

@ CMD1NO=`ps aux | grep miru | grep $CMD2CMD | grep -v grep | wc -l | sed s/" "//g`

if ( $CMD1NO == 0 ) then
  echo "Detect lost $CMD1CMD ..."

  sleep 3
  echo "Execute $CMD1CMD..."
  echo $CMD1CMD $CMD1OPT
  nohup $CMD1CMD $CMD1OPT &
endif

