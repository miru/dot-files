#!/bin/bash

# run check
while  [ `ps -ef|grep /usr/local/bin/narou|wc -l` -ne 1 ]
do
    echo "waiting"
    sleep 30
done

pushd /home/miru/narou

/usr/local/bin/narou s hotentry.auto-mail=false
#/usr/local/bin/narou u    `/usr/local/bin/narou list -t kindle | cat`
/usr/local/bin/narou u -n `/usr/local/bin/narou list -t 未読 | cat`
/usr/local/bin/narou u -n `/usr/local/bin/narou list -t 切 | cat`
/usr/local/bin/narou s hotentry.auto-mail=true
/usr/local/bin/narou freeze --on end
#/usr/local/bin/narou freeze --on 404

popd

# EOF

