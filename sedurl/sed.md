# The 'sed' replacement on URLs

## the most URL patteRP_ID

`
    http://10.10.10.10
    http://10.10.10.11/
    http://10.10.10.12/some/thing/
    http://sb@10.10.10.12/some/thing/
    https://10.10.10.10
    https://10.10.10.11/
    https://10.10.10.12/some/thing/
    https://sb@10.10.10.12/some/thing/
    http://my-own.example.site_0.com
    http://my-own.example.site_0.com/
    http://my-own.example.site_0.com/some/thing/
    http://sb@my-own.example.site_0.com/some/thing/
    https://my-own.example.site_0.com
    https://my-own.example.site_0.com/
    https://my-own.example.site_0.com/some/thing/
    https://sb@my-own.example.site_0.com/some/thing/
`

## get hostname from URLs
RP_ID='[^\.\/@]\{1,\}'
RP_DOMAINROOT='[a-zA-Z]\{1,\}'
RP_IP='\([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\)'
RP_HOST='\('$RP_ID'\.\)\{0,\}\('$RP_ID'\.'$RP_DOMAINROOT'\)'
RP_USER='\(\(\('$RP_ID'\)@\)\{0,1\}\)'
RP_PORT='\(\(\:[0-9]\{1,\}\)\{0,1\}\)'
RP_PATH='\(\(/.*\)\{0,1\}\)'
RIP='s#^|https\{0,1\}\://'$RP_USER$RP_IP$RP_PORT$RP_PATH'$#\4#g'
RHOST='s#^|https\{0,1\}\://'$RP_USER$RP_HOST$RP_PORT$RP_PATH'$#\4#g'
echo $RIP
echo $RHOST


sed -e 's#^|https\{0,1\}\://\(\([^\.\/\@]\{1,\}\)\@\)\{0,1\}\(\([^\.\/\@]\{1,\}\.\)\{0,\}\)\([^\.\/\@]\{1,\}\.[a-zA-Z]\{1,\}\)\(\/.*\)\{0,1\}$#\2 @ \3\5#g' test.txt