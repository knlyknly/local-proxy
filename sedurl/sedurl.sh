#!/bin/sh
RP_ID='[^\.\/@]\{1,\}'
RP_DOMAINROOT='[a-zA-Z]\{2,\}'
RP_IP='\([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\)'
RP_HOST='\('$RP_ID'\.\)\{0,\}\('$RP_ID'\.'$RP_DOMAINROOT'\)'
RP_USER='\(\(\('$RP_ID'\)@\)\{0,1\}\)'
RP_PORT='\(\(\:[0-9]\{1,\}\)\{0,1\}\)'
RP_PATH='\(\(/.*\)\{0,1\}\)'
RP_PREFIX='\(https\{0,1\}\://\)\{0,1\}'
RIP='s#^|'$RP_PREFIX$RP_USER'\('$RP_IP'\)'$RP_PORT$RP_PATH'$#\5#g'
RHOST='s#^|'$RP_PREFIX$RP_USER'\('$RP_HOST'\)'$RP_PORT$RP_PATH'$#\5#g'
echo $RIP
echo $RHOST

cat $1 | sed -e $RIP | sed -e $RHOST