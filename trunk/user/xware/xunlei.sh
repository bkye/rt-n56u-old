#!/bin/sh

xunleienable=`nvram get xunlei_enable`
patch=`ls -l /media/ | awk '/^d/ {print $NF}' | sed -n '1p'`
if [ -z $patch ]; then
logger -t "远程迅雷下载" "未检测到挂载硬盘,程序退出。" 
nvram set xunlei_enable="0"
exit 0
else
xunleidir="/media/$patch"
nvram set xunlei_dir="$xunleidir"
fi

if [ "$xunleienable" != 1 -a -n "`pidof ETMDaemon`" ]; then
 killall ETMDaemon EmbedThunderManager
sed -i '/xunlei/d' /etc/storage/post_wan_script.sh 
 logger -t "远程迅雷下载" "已关闭。" 
 nvram set xunlei_enable="0"
 exit 0
fi

if [ "$xunleienable" != 1 ]; then
logger -t "远程迅雷下载" "未开启" 
exit 0
fi

if [ ! -f "$xunleidir/xunlei/portal" ]; then
	mkdir -p "$xunleidir/xunlei/"
	tar -xzvf "/etc_ro/xware.tgz" -C "$xunleidir/xunlei/"
	logger -t "远程迅雷下载" "成功解压至：$xunleidir/xunlei/"
fi

if [ ! -x "$xunleidir/xunlei/portal" ]; then
	chmod 777 "$xunleidir/xunlei/portal"
fi

codeline=""
export LD_LIBRARY_PATH="$xunleidir/xunlei/lib:/lib:/opt/lib:/usr/share/bkye"
while [ -z "$codeline" ]
do
	logger -t "远程迅雷下载" "启动中..."
	$xunleidir/xunlei/portal > /tmp/xunlei.conf
	codeline=`grep "THE ACTIVE CODE IS" /tmp/xunlei.conf`
	if [ -z "$codeline" ]; then
		codeline=`grep "THIS DEVICE HAS BOUND TO USER" /tmp/xunlei.conf`
		if [ -z "$codeline" ]; then
			logger -t "远程迅雷下载" "启动失败，正在重试中，请检查！"
			sleep 5
		fi
	fi
done
code=`expr "$codeline" : '[^\:]*: \([^.]*\)'`
nvram set xunlei_sn="$code"
export LD_LIBRARY_PATH=/lib:/opt/lib
sed -i '/xunlei/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/xunlei.sh&
EOF
logger -t "远程迅雷下载" "守护进程启动在：$xunleidir/xunlei。"
