#!/bin/sh

adbybydir=`nvram get dlna_src1`
adbybyenable=`nvram get adbyby_enable`
adbyby_cpu=`nvram get adbyby_cpu`
adbyby_whost=`nvram get adbyby_whost`
adbybyretimehour=`nvram get adbyby_retime_hour`
adbybyretimemin=`nvram get adbyby_retime_min`
[ ! -d "$adbybydir" ] && logger -t "adbyby" "未检测到挂载硬盘" && exit 0

if [ "$adbybyenable" != 1 ]; then
PIDS=$(ps | grep "$adbybydir/adbb/bin/adbyby" | grep -v "grep" | wc -l)
if [ "$PIDS" = 0 ]; then
logger -t "adbyby" "adbyby去广告功能未打开，已忽略启动。"
exit 0
else
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
exit 0
fi
fi
if [ ! -f "$adbybydir/adbb/bin/adbyby" ]; then
    logger -t "adbyby" "adbyby程序文件不存在，正在解压..."
	mkdir -p "$adbybydir/adbb/"
	tar -xzvf "/etc_ro/7620n.tar.gz" -C "$adbybydir/adbb/"
	logger -t "adbyby" "成功解压至：$adbybydir/adbb/"
fi

export PATH=/opt/sbin:/opt/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=/opt/lib:/lib

sleep 2

if [ -s "$adbybydir/adbyby/bin/adbyby" ] ;then
	if [ "$adbyby_whost" != "" ] ; then
		logger -t "adbyby" "添加过滤白名单地址"
		logger -t "adbyby" "加白地址:$adbyby_whost"
		chmod 777 "$adbybydir/adbyby/bin/adhook.ini"
		sed -Ei '/whitehost=/d' $adbybydir/adbb/bin/adhook.ini
		echo whitehost=$adbyby_whost >> $adbybydir/adbb/bin/adhook.ini
		else
		logger -t "adbyby" "过滤白名单地址未定义,已忽略。"
	fi
logger -t "adbyby" "正在启动adbyby进程。"
#rm /tmp/adbyby.log
chmod 777 "$adbybydir/adbb/bin/adbyby"
#$adbybydir/adbyby/bin/adbyby > /tmp/adbyby.log&
#adbyby_log=`cat /tmp/adbyby.log`
#logger -t "adbyby" "$adbyby_log"
#killall adbyby
### rm /tmp/data/user.txt
### cp -f /media/AiDisk_a1/adbyby/user.txt /tmp/data/user.txt
$adbybydir/adbb/bin/adbyby&
sleep 5
check=$(ps | grep "$adbybydir/adbb/bin/adbyby" | grep -v "grep" | wc -l)
if [ "$check" = 0 ]; then
    logger -t "adbyby" "adbyby启动失败。"
	nvram set adbyby_enable="0"
	exit 0
else
logger -t "adbyby" "添加8118透明代理端口。"
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
sed -i '/adbyby/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/adbyby.sh&
EOF
logger -t "adbyby" "adbyby进程守护已启动。"
fi
fi
exit 0

#以下代码是没有执行的，需要的话自己修改一下使用。
#守护进程
#echo '*/1 * * * * sh /usr/bin/adbchk.sh' >> /etc/storage/cron/crontabs/admin

cat > "/tmp/cron_adb" <<EOF
logger -t "adbyby" "定时重启..."
killall adbyby
touch /tmp/cron_adb.lock
iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
sleep 3
$adbybydir/adbb/bin/adbyby& > /dev/null
logger -t "adbyby" "定时重启成功"
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
rm /tmp/cron_adb.lock
EOF
chmod 777 "/tmp/cron_adb"

cat > "/etc/storage/cron/crontabs/admin" <<EOF
30 3 * * * /tmp/cron_adb
EOF
chmod 777 "/etc/storage/cron/crontabs/admin"


sleep 2

crond

adbyby_keepcpu () {
if [ "$adbyby_cpu" = "1" ] && [ ! -f /tmp/cron_adb.lock ] ; then
	CPULoad=`uptime |sed -e 's/\ *//g' -e 's/.*://g' -e 's/,.*//g' -e 's/\..*//g'`
	if [ $((CPULoad)) -ge "2" ] ; then
		logger -t "adbyby" "CPU 负载拥堵, 关闭 adbyby"
killall adbyby
touch /tmp/cron_adb.lock
iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
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
}