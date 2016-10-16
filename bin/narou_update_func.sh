#!/bin/bash
# -*- coding:utf-8 -*-

wait_other_script () {
    while  [ `ps -ef|grep "$NAROU"|grep -v grep|wc -l` -ge 1 ]
    do
	echo "waiting"
	sleep 30
    done
}

tag_add_noconv () {
    UPD_ID=`egrep "DL開始" $1 | perl -pe 's/ID:(\d+).*/\1/g'`
    if [ ! "$UPD_ID" = "" ]; then
	$NAROU tag -a $NOCONV_TAG -c red `echo $UPD_ID`
    fi
}

send_notification () {
    FLG=NG
    RES=`egrep "(DL開始|第[0-9]+部分.*\(新着\)|完結したようです)" $2 | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g' | perl -pe 's/ID:[0-9]+　(.*) のDL開始/\n\1/g'`
    while [ $FLG = "NG" ]
    do
	case "$NOTIFY_TYPE" in
	    "PUSHBULLET")
		send_notification_pushbullet "$1" "$RES"
		;;
	    "LINE")
		send_notification_line "$1" "$RES"
		;;
	    "SLACK")
		send_notification_slack "$1" "$RES"
	esac
	if [ $? -eq 0 ]; then
	    FLG=OK
	fi
    done
}

send_notification_pushbullet () {
    BODY=`echo "$2" | perl -pe 's/\n/\\\n/g'`
    /usr/bin/curl --header "Access-Token: $PUSHBULLET_TOKEN" --header "Content-Type: application/json" \
		  --data-binary "{\"title\":\"$1\",\"body\":\"$BODY\",\"type\":\"note\"}" \
		  --request POST https://api.pushbullet.com/v2/pushes

}

send_notification_line () {
    BODY="$2"
    /usr/bin/curl https://notify-api.line.me/api/notify -X POST -H "Authorization: Bearer $LINE_TOKEN" \
		  -F "message=$1
$BODY"
}

send_notification_slack () {
    BODY="$2"
    curl -X POST --data-urlencode "payload={\"channel\": \"#general\", \"username\": \"narou_update\", \"text\": \"$1
$BODY\", \"icon_emoji\": \":books:\"}" $SLACK_WEBHOOK

}

# EOF
