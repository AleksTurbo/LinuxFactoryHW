#!/bin/bash
TARGET="bashdays.com";
MAINDIR=/tmp;
METRICS=ssl_sert_expire_day.prom;

expirationdate=$(date -d "$(: | openssl s_client -connect $TARGET:443 -servername $TARGET 2>/dev/null \
                              | openssl x509 -text \
                              | grep 'Not After' \
                              | awk '{print $4,$5,$7,$6}')" '+%s'); 

echo "                                  Today: $(date +%s) - $(date '+%Y-%m-%d')" 

echo "Certificate for $TARGET expires on: $expirationdate - $(date -d @$expirationdate '+%Y-%m-%d')" 

EXPSEC=$((($expirationdate) - $(date +%s)));
EXPDAY=$(($EXPSEC/86400))

echo $EXPDAY

echo "ssl_sert_expire_day{site=\"$TARGET\"} $EXPDAY" | sed 's/null/0/' > $MAINDIR/$METRICS