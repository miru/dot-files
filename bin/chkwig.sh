#!/bin/csh

setenv CMD1DIR "~/app/net-irc/"
setenv CMD1CMD "./examples/wig.rb"
setenv CMD2CMD "wig.rb"

@ CMD1NO=`ps aux | grep ug3 | grep $CMD2CMD | grep -v grep | wc -l | sed s/" "//g`

if ( $CMD1NO == 0 ) then
  echo "Detect lost $CMD1CMD ..."

  sleep 1
  echo "Execute $CMD1CMD..."
  echo $CMD1CMD
  cd $CMD1DIR
  nohup ./$CMD1CMD &
endif

