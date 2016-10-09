#!/bin/bash

wait_other_script () {
    while  [ `ps -ef|grep "$NAROU"|grep -v grep|wc -l` -ge 1 ]
    do
	echo "waiting"
	sleep 30
    done
}

tag_add_noconv () {
    UPD_ID=`$NAROU update -l 1 | egrep "DL開始" | perl -pe 's/ID:(\d+).*/\1/g'`
    if [ `echo -n $UPD_ID | wc -l` -ge 1 ]; then
	$NAROU tag -a noconv `echo $UPD_ID`
    fi
}


send_notification () {
    FLG=NG
    while [ $FLG = "NG" ]
    do
	case "$NOTIFY_TYPE" in
	    "PUSHBULLET")
		send_notification_pushbullet "$1" "$2"
		;;
	    "LINE")
		send_notification_line "$1" "$2"
		;;
	esac
	if [ $? -eq 0 ]; then
	    FLG=OK
	fi
    done
}

send_notification_pushbullet () {
    BODY=`echo "$2" | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g' | perl -pe 's/\n/\\\n/g'`
    /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
		  --data-binary "{\"title\":\"$1\",\"body\":\"$BODY\",\"type\":\"note\"}" \
		  --request POST https://api.pushbullet.com/v2/pushes
    
}

send_notification_line () {
		BODY=`echo "$2" | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g' | perl -pe 's/ \([0-9]+\/[0-9]+\)//g'`
    /usr/bin/curl https://notify-api.line.me/api/notify -X POST -H "Authorization: Bearer $LINE_TOKEN" \
		  -F "message=$1
$BODY"
}

# EOF
