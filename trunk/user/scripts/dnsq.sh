#!/bin/sh
#last update 20170531 by bkye 
dnsqenable=`nvram get dnsq_enable`
dnsqhour=`nvram get dnsq_hours`
dnsqmin=`nvram get dnsq_min`
dnsqreset=`nvram get dnsq_update_enable`
dnsqfq=`nvram get dnsq_fq_enable`
dnsqad=`nvram get dnsq_ad_enable`
if [ "$dnsqenable" != 1 ]; then
logger -t "dnsmasq" "正在还原dnsmasq规则..."
#删除dnsmasq.conf的修改内容
sed -i -e '/\/dns\//d' /etc/storage/dnsmasq/dnsmasq.conf
#删除定时脚本的修改内容
http_username=`nvram get http_username`
sed -i '/dnsq/d' /etc/storage/cron/crontabs/$http_username
nvram set dnsq_update_enable="0"
#删除自定义脚本里“在 WAN 上行/下行启动后执行”的修改
sed -i '/dnsq/d' /etc/storage/post_wan_script.sh
#删除缓存文件夹
rm -rf /etc/storage/dnsmasq/dns
#rm /tmp/cron_dnsq
#rm /etc/storage/cron/crontabs/admin
#重启dnsmasq
/sbin/restart_dhcpd
logger -t "dnsmasq" "dnsmasq规则还原成功！"
exit 0
else
logger -t "dnsmasq" "正在重新配置dnsmasq规则..."
#mkdir -p /etc/storage/dnsmasq/dns
##在“dnsmasq.conf”配置文件里指向规则文件路径
#指定hosts规则文件
#addn-hosts=/etc/storage/dnsmasq/dns/hosts
#指定dnsmasq规则文件夹
#conf-dir=/etc/storage/dnsmasq/dns/conf
sed -i '/\/dns\//d' /etc/storage/dnsmasq/dnsmasq.conf
cat >> /etc/storage/dnsmasq/dnsmasq.conf << EOF
addn-hosts=/etc/storage/dnsmasq/dns/hosts
conf-file=/etc/storage/dnsmasq/dns/conf/dnsip
conf-file=/etc/storage/dnsmasq/dns/conf/dnsad
conf-file=/etc/storage/dnsmasq/dns/conf/dnsfq
EOF

##到“定时脚本”里写入定时执行任务
#零点一分执行脚本
#1 0 * * * /bin/sh /etc/storage/dnsmasq/dns/start.sh
#http_username=`nvram get http_username`
#sed -i '/\/dns\//d' /etc/storage/cron/crontabs/$http_username
#cat >> /etc/storage/cron/crontabs/$http_username << EOF
#1 0 * * * /bin/sh /etc/storage/dnsmasq/dns/start.sh
#EOF

##到自定义脚本里“在 WAN 上行/下行启动后执行”写入脚本，网络重连自动更新dnsmasq
#sed -i '/\/dns\//d' /etc/storage/post_wan_script.sh
#cat >> /etc/storage/post_wan_script.sh << EOF
#/bin/sh /etc/storage/dnsmasq/dns/start.sh
#EOF

#############################
##▼开始下载文件并重启dnsmasq生效
rm -rf /etc/storage/dnsmasq/dns;cd /etc
mkdir -p /etc/storage/dnsmasq/dns/conf

if [ "$dnsqad" -eq 1 ]; then
#下载hosts
logger -t "dnsmasq" "开始下载相关hosts和规则！"
cd /etc/storage/dnsmasq/dns
wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/hosts -O hosts;sed -i "1 i\## update：$(date "+%Y-%m-%d %H:%M:%S")" hosts
if [ ! -f "hosts" ]; then
logger -t "dnsmasq" "host文件下载失败，可能是地址失效或者网络异常！"
sed -i '/hosts/d' /etc/storage/dnsmasq/dnsmasq.conf
else
logger -t "dnsmasq" "host文件下载完成。"
fi
cd /etc/storage/dnsmasq/dns/conf
wget --no-check-certificate https://raw.githubusercontent.com/sy618/hosts/master/dnsmasq/dnsad -O dnsad;sed -i "1 i\## update：$(date "+%Y-%m-%d %H:%M:%S")" dnsad
if [ ! -f "dnsad" ]; then
logger -t "dnsmasq" "屏蔽广告家族文件下载失败，可能是地址失效或者网络异常！"
sed -i '/dnsad/d' /etc/storage/dnsmasq/dnsmasq.conf
else
logger -t "dnsmasq" "屏蔽广告家族文件下载完成。"
fi
else
sed -i '/dnsad/d' /etc/storage/dnsmasq/dnsmasq.conf
sed -i '/hosts/d' /etc/storage/dnsmasq/dnsmasq.conf
fi
if [ "$dnsqfq" -eq 1 ]; then
#下载dnsmasq规则
cd /etc/storage/dnsmasq/dns/conf
wget --no-check-certificate https://raw.githubusercontent.com/sy618/hosts/master/dnsmasq/dnsfq -O dnsfq;sed -i "1 i\## update：$(date "+%Y-%m-%d %H:%M:%S")" dnsfq
if [ ! -f "dnsfq" ]; then
logger -t "dnsmasq" "GFW翻墙文件下载失败，可能是地址失效或者网络异常！"
sed -i '/dnsfq/d' /etc/storage/dnsmasq/dnsmasq.conf
else
logger -t "dnsmasq" "GFW翻墙文件下载完成。"
fi
else
sed -i '/dnsfq/d' /etc/storage/dnsmasq/dnsmasq.conf
fi
cd /etc/storage/dnsmasq/dns/conf
wget --no-check-certificate https://raw.githubusercontent.com/sy618/hosts/master/dnsmasq/dnsip -O dnsip;sed -i "1 i\## update：$(date "+%Y-%m-%d %H:%M:%S")" dnsip
if [ ! -f "dnsip" ]; then
logger -t "dnsmasq" "屏蔽运营商劫持文件下载失败，可能是地址失效或者网络异常！"
sed -i '/dnsip/d' /etc/storage/dnsmasq/dnsmasq.conf
else
logger -t "dnsmasq" "屏蔽运营商劫持文件下载完成。"
fi

#重启dnsmasq
logger -t "dnsmasq" "正在重启dnsmasq..."
/sbin/restart_dhcpd
sed -i '/dnsq/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/dnsq.sh&
EOF
logger -t "dnsmasq" "dnsmasq规则文件加载完毕。"
sed -i '/dnsq/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/dnsq.sh&
EOF
fi

if [ "$dnsqreset" = 1 ]; then
http_username=`nvram get http_username`
sed -i '/dnsq/d' /etc/storage/cron/crontabs/$http_username
cat >> /etc/storage/cron/crontabs/$http_username << EOF
$dnsqmin $dnsqhour * * * /bin/sh /usr/bin/dnsq.sh
EOF
logger -t "dnsmasq" "每天$dnsqhour:$dnsqmin自动更新dnsmasq规则！"
chmod 777 "/etc/storage/cron/crontabs/$http_username"
else
http_username=`nvram get http_username`
sed -i '/dnsq/d' /etc/storage/cron/crontabs/$http_username
fi
