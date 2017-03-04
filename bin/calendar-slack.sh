#!/bin/bash

SLACK_WEBHOOK="https://hooks.slack.com/services/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"
LANG=C

BODY=`date +http://miniature-calendar.com/wp-content/uploads/%Y/%m/%y%m%d%a.jpg | tr '[A-Z]' '[a-z]'`
/usr/bin/curl -X POST --data-urlencode "payload={\"channel\": \"#general\", \"username\": \"MINIATURE CALENDAR\", \"text\": \"$BODY\", \"icon_emoji\": \":date:\"}" $SLACK_WEBHOOK

# EOF

