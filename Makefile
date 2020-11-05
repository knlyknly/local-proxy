# I'm using this on an ARM linux board, eventually AM3359, so the v2ray is extracted from a v2ray-linux-arm

V2RAY=./v2ray-linux-arm
GFWLIST=./gfwlist

config:
	@V2RAY=${V2RAY} ./config.sh

update-gfw:
	@mkdir tmp
	@cp ${GFWLIST}/gfw tmp/gfw
	@${GFWLIST}/v2sitedat -dat ${V2RAY}/bin/gfw.dat -dir tmp
	@rm -rf tmp

update-online:
	@wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O ${GFWLIST}/gfwlist.txt.base64
	@cat gfwlist/gfwlist.txt.base64 \
		| base64 -d \
		| grep "^[^\!@\[]" \
		| sed -e 's#^\(\.\)\(.*\)$$#\2#g' \
		| sed -e 's#^|https?://\([^\./]*[^\./]\.\)*\([^\./]*[^\./]\.\w\+\)\(/.*\)\?$$#\2#g' \
		| sed -e 's#^\(\|\|\)\(.*\)$$#\2#g' \
		| sed -e 's#^|\(https\{0,1\}\://\)\{0,1\}\(\(\([^\.\/@]\{1,\}\)@\)\{0,1\}\)\(\([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\)\)\(\(\:[0-9]\{1,\}\)\{0,1\}\)\(\(/.*\)\{0,1\}\)$$#\5#g' \
		| sed -e 's#^|\(https\{0,1\}\://\)\{0,1\}\(\(\([^\.\/@]\{1,\}\)@\)\{0,1\}\)\(\([^\.\/@]\{1,\}\.\)\{0,\}\([^\.\/@]\{1,\}\.[a-zA-Z]\{2,\}\)\)\(\(\:[0-9]\{1,\}\)\{0,1\}\)\(\(/.*\)\{0,1\}\)$$#\5#g' \
		| grep '^\([^\.\/\*]\+\.\)\+[a-zA-Z]\+$$' \
		| uniq -u \
		> ${GFWLIST}/online
		@cat ${GFWLIST}/sites/online | wc -l

data:
	@printf "Turn gfwlist into list..."
	@${GFWLIST}/v2sitedat -dat ${GFWLIST}/sites.dat -dir ${GFWLIST}/sites
	@printf "done.\n"

install:
	@printf "Install..."
	@mkdir -p /usr/bin/v2ray /etc/v2ray /var/log/v2ray
	@cp -R ${V2RAY}/etc/*  /etc/v2ray/
	@cp -R ${V2RAY}/bin/*  /usr/bin/v2ray/
	@cp -R ${V2RAY}/systemd/v2ray.service /etc/systemd/system/
	@printf "done.\n"
	@printf "Enable service..."
	@systemctl daemon-reload
	@systemctl enable v2ray.service
	@printf "done.\n"

start:
	@printf "Start service..."
	@mkdir -p /var/log/v2ray
	systemctl start v2ray.service
	@printf "done.\n"

stop:
	@printf "Stop service..."
	@systemctl stop v2ray.service
	@printf "done.\n"

restart:
	@printf "Restart service..."
	@systemctl restart v2ray.service
	@printf "done.\n"

status:
	@systemctl status v2ray.service

uninstall: stop
	@printf "Uninstall..."
	@systemctl disable v2ray.service
	@rm -rf /etc/v2ray/ /usr/bin/v2ray/ /var/log/v2ray /etc/systemd/system/v2ray.service
	@systemctl daemon-reload
	@printf "done.\n"

date:
	@ntpdate pool.ntp.org
	@timedatectl set-timezone Asia/Shanghai
