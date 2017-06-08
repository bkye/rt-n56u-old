#!/bin/sh
addir=`nvram get ad_dir`
#adbybydir=`nvram get dlna_src1`
adenable=`nvram get ad_enable`
adchange=`nvram get ad_change`
adbyby_cpu=`nvram get adbyby_cpu`
adbyby_whost=`nvram get adbyby_whost`
adbybyretimehour=`nvram get adbyby_retime_hour`
adbybyretimemin=`nvram get adbyby_retime_min`
koolproxyhttps=`nvram get koolproxy_https`
http_username=`nvram get http_username`
if [ "$addir" -eq 1 ]; then
adbybydir="/tmp"
fi
if [ "$addir" -eq 2 ]; then
patch=`ls -l /media/ | awk '/^d/ {print $NF}' | sed -n '1p'`
if [ -z $patch ]; then
logger -t "广告屏蔽" "未检测到挂载硬盘,自动切换为临时目录。" 
adbybydir="/tmp"
nvram set ad_dir="1"
else
adbybydir="/media/$patch"
fi
fi
if [ "$adenable" != 1 ]; then
if [ "$adchange" -eq 1 ]; then
port=$(iptables -t nat -L | grep 'ports 8118' | wc -l)
    logger -t "adbyby" "找到$port个8118透明代理端口，正在关闭。"
    while [[ "$port" -ge 1 ]]
    do
    iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
    port=$(iptables -t nat -L | grep 'ports 8118' | wc -l)
    done
	logger -t "adbyby" "已关闭全部8118透明代理端口。"
touch /tmp/cron_adb.lock
killall adbyby
sed -i '/adbyby/d' /etc/storage/post_wan_script.sh
logger -t "adbyby" "adbyby进程已成功关闭。"
fi
if [ "$adchange" -eq 2 ]; then
portkp=$(iptables -t nat -L | grep 'ports 3000' | wc -l)
    logger -t "koolproxy" "找到$portkp个3000透明代理端口，正在关闭。"
    while [[ "$portkp" -ge 1 ]]
    do
	[ "$koolproxyhttps" = "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,443,8080 -j REDIRECT --to-ports 3000
[ "$koolproxyhttps" != "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
portkp=$(iptables -t nat -L | grep 'ports 3000' | wc -l)
done
killall koolproxy
sed -i '/koolproxy/d' /etc/storage/post_wan_script.sh
logger -t "koolproxy" "koolproxy进程已成功关闭。"
fi
sed -i '/adbchk/d' /etc/storage/cron/crontabs/$http_username
exit 0
fi
#选择adbyby时的处理
if [ "$adchange" -eq 1 ]; then
if [ ! -f "$adbybydir/adbb/bin/adbyby" ]; then
    logger -t "adbyby" "adbyby程序文件不存在，正在解压..."
	mkdir -p "$adbybydir/adbb/"
	tar -xzvf "/etc_ro/7620n.tar.gz" -C "$adbybydir/adbb/"
	logger -t "adbyby" "成功解压至：$adbybydir/adbb/"
fi
export PATH=/opt/sbin:/opt/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=/opt/lib:/lib
sleep 2
if [ -s "$adbybydir/adbb/bin/adbyby" ] ;then
	if [ "$adbyby_whost" != "" ] ; then
		logger -t "adbyby" "添加过滤白名单地址"
		logger -t "adbyby" "加白地址:$adbyby_whost"
		chmod 777 "$adbybydir/adbb/bin/adhook.ini"
		sed -Ei '/whitehost=/d' $adbybydir/adbb/bin/adhook.ini
		echo whitehost=$adbyby_whost >> $adbybydir/adbb/bin/adhook.ini
		echo @@\|http://\$domain=$(echo $adbyby_whost | tr , \|) >> $adbybydir/adbb/bin/data/user.txt
		else
		logger -t "adbyby" "过滤白名单地址未定义,已忽略。"
	fi
logger -t "adbyby" "正在启动adbyby进程。"
chmod 777 "$adbybydir/adbb/bin/adbyby"
$adbybydir/adbb/bin/adbyby&
sleep 5
check=$(ps | grep "$adbybydir/adbb/bin/adbyby" | grep -v "grep" | wc -l)
if [ "$check" = 0 ]; then
    logger -t "adbyby" "adbyby启动失败。"
	nvram set ad_enable="0"
	exit 0
else
logger -t "adbyby" "添加8118透明代理端口。"
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
logger -t "adbyby" "adbyby进程守护已启动。"
fi
fi
fi
#adbyby 处理结束
if [ "$adchange" -eq 2 ]; then
#选择koolproxy的处理
if [ ! -f "$adbybydir/koolproxy/koolproxy" ]; then
	mkdir -p "$adbybydir/koolproxy/"
	tar -xzvf "/etc_ro/koolproxy.tar.gz" -C "$adbybydir/koolproxy/"
	logger -t "[koolproxy]" "成功解压至：$adbybydir/koolproxy/"
fi

sleep 2

	if [ ! -f $adbybydir/koolproxy/data/private/ca.key.pem ]; then
		logger -t "【koolproxy】" "检测到首次运行https，开始生成koolproxy证书，用于https过滤！大约需要20S以上的时间，请耐心等待！"
chmod 777 $adbybydir/koolproxy/data/gen_ca.sh
$adbybydir/koolproxy/data/gen_ca.sh
	fi
	logger -t "【koolproxy】" "koolproxy证书位于$adbybydir/koolproxy/data/private"
	
	chmod 777 $adbybydir/koolproxy/koolproxy

	$adbybydir/koolproxy/koolproxy -d >/dev/null 2>&1 &
sleep 5
	 if [ ! -z "`pidof koolproxy`" ]; then
	logger -t "【koolproxy】" "启动成功"
	fi
	
if [ -z "`pidof koolproxy`" ]; then
logger -t "【koolproxy】" "启动失败, 注意检查端口是否有冲突,程序是否下载完整" 
nvram set ad_enable="0"
exit 0
fi
if [ "$koolproxyhttps" = "1" ]; then
logger -t "koolproxy" "找不到透明代理3000端口，添加代理端口" 
iptables -t nat -A PREROUTING -p tcp -m multiport --dport 80,443,8080 -j REDIRECT --to-ports 3000
logger -t "koolproxy" "端口添加成功。"
fi
if [ "$koolproxyhttps" != "1" ]; then
logger -t "koolproxy" "找不到透明代理3000端口，添加代理端口"
iptables -t nat -A PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
logger -t "koolproxy" "端口添加成功。"
fi
fi
sed -i '/adbyby/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/adbyby.sh&
EOF
#koolproxy处理结束
#守护进程

sed -i '/adbchk/d' /etc/storage/cron/crontabs/$http_username
cat >> /etc/storage/cron/crontabs/$http_username << EOF
5 * * * * /bin/sh /usr/bin/adbchk.sh >/dev/null 2>&1
EOF
