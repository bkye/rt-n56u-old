adchange=`nvram get ad_change`
addir=`nvram get ad_dir`
adbybydir=`nvram get dlna_src1`
koolproxyhttps=`nvram get koolproxy_https`
if [ "$addir" -eq 1 ]; then
adbybydir="/tmp"
fi
if [ "$addir" -eq 2 ]; then
adbybydir=`nvram get dlna_src1`
fi
if [ "$adbyby_cpu" = "1" ] && [ ! -f /tmp/cron_adb.lock ] ; then
	CPULoad=`uptime |sed -e 's/\ *//g' -e 's/.*://g' -e 's/,.*//g' -e 's/\..*//g'`
	if [ $((CPULoad)) -ge "2" ] ; then
		logger -t "adbyby" "CPU 负载拥堵, 关闭广告屏蔽程序。"
		
if [ "$adchange" -eq 1 ]; then
touch /tmp/cron_adb.lock
port=$(iptables -t nat -L | grep 'ports 8118' | wc -l)
    logger -t "adbyby" "找到$port个8118透明代理端口，正在关闭。"
    while [[ "$port" -ge 1 ]]
    do
    iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
    port=$(iptables -t nat -L | grep 'ports 8118' | wc -l)
    done
	logger -t "adbyby" "已关闭全部8118透明代理端口。"
killall adbyby
sed -i '/adbyby/d' /etc/storage/post_wan_script.sh
logger -t "adbyby" "adbyby进程已成功关闭。"
fi
if [ "$adchange" -eq 2 ]; then
killall koolproxy
[ "$koolproxyhttps" = "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,443,8080 -j REDIRECT --to-ports 3000
[ "$koolproxyhttps" != "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
sed -i '/koolproxy/d' /etc/storage/post_wan_script.sh
logger -t "koolproxy" "koolproxy进程已成功关闭。"
fi
		processor=`cat /proc/cpuinfo| grep "processor"| wc -l`
		processor=`expr $processor \* 2`
		while [[ "$CPULoad" -gt "$processor" ]] 
		do
			sleep 62
			CPULoad=`uptime |sed -e 's/\ *//g' -e 's/.*://g' -e 's/,.*//g' -e 's/\..*//g'`
		done
		logger -t "adbyby" "CPU 负载正常"
		rm -f /tmp/cron_adb.lock
	fi
fi
if [ "$adchange" -eq 1 ]; then
PIDS=$(ps | grep "$adbybydir/adbyby/bin/adbyby" | grep -v "grep" | wc -l)
	if [ $PIDS -eq 0 ]; then
		echo "注意：adbyby意外关闭，将重启adbyby!"
		$adbybydir/adbyby/bin/adbyby&
		iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
		exit 0
	fi
	if [ $PIDS -gt 6 ]; then
		echo "注意：发现多于6个adbyby进程，将重启adbyby!"
		ps |grep "$adbybydir/adbyby/bin/adbyby" | grep -v 'grep' | awk '{print $1}' |xargs kill -9
		$adbybydir/adbyby/bin/adbyby&
		iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
		exit 0
	fi
port=$(iptables -t nat -L | grep "tcp dpt:www redir ports 8118" | wc -l)
	if [ $port -eq 0 ]; then
		echo "注意：防火墙转发规则丢失，将添加规则！"
		iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
	fi
	while [ $port -gt 1 ]
	do
		echo "注意：发现多条防火墙转发规则，将删除多余规则！"
		iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
		port=$(iptables -t nat -L | grep "tcp dpt:www redir ports 8118" | wc -l)
	done
fi
if [ "$adchange" -eq 2 ]; then
PIDS=$(ps | grep "$adbybydir/koolproxy/koolproxy" | grep -v "grep" | wc -l)
	if [ $PIDS -eq 0 ]; then
		echo "注意：adbyby意外关闭，将重启adbyby!"
		$koolproxydir/koolproxy/koolproxy -d >/dev/null 2>&1 &
		sleep 5
	 if [ ! -z "`pidof koolproxy`" ]; then
	logger -t "【koolproxy】" "启动成功"
	fi
if [ -z "`pidof koolproxy`" ]; then
logger -t "【koolproxy】" "启动失败, 注意检查端口是否有冲突,程序是否下载完整" 
nvram set koolproxy_enable="0"
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
port=$(iptables -t nat -L | grep "tcp dpt:www redir ports 3000" | wc -l)
	if [ $port -eq 0 ]; then
		echo "注意：防火墙转发规则丢失，将添加规则！"
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
	while [ $port -gt 1 ]
	do
		echo "注意：发现多条防火墙转发规则，将删除多余规则！"
		[ "$koolproxyhttps" = "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,443,8080 -j REDIRECT --to-ports 3000
[ "$koolproxyhttps" != "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
		port=$(iptables -t nat -L | grep "tcp dpt:www redir ports 8118" | wc -l)
	done
fi