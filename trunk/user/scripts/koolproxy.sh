#!/bin/sh

koolproxydir=`nvram get dlna_src1`
koolproxyenable=`nvram get koolproxy_enable`
koolproxyhttps=`nvram get koolproxy_https`
[ ! -d "$koolproxydir" ] && logger -t "koolproxy" "未检测到挂载硬盘" && exit 0

if [ "$koolproxyenable" != 1 -a -n "`pidof koolproxy`" ]; then
killall koolproxy
[ "$koolproxyhttps" = "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,443,8080 -j REDIRECT --to-ports 3000
[ "$koolproxyhttps" != "1" ] && logger -t "koolproxy" "关闭代理端口" && iptables -t nat -D PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
sed -i '/koolproxy/d' /etc/storage/post_wan_script.sh
logger -t "koolproxy" "已关闭。"
exit 0
fi
[ "$koolproxyenable" != 1 ] && logger -t "koolproxy" "未开启" && exit 0

if [ ! -f "$koolproxydir/koolproxy/koolproxy" ]; then
	mkdir -p "$koolproxydir/koolproxy/"
	tar -xzvf "/etc_ro/koolproxy.tar.gz" -C "$koolproxydir/koolproxy/"
	logger -t "[koolproxy]" "成功解压至：$koolproxydir/koolproxy/"
fi

sleep 2

	if [ ! -f $koolproxydir/koolproxy/data/private/ca.key.pem ]; then
		logger -t "【koolproxy】" "检测到首次运行https，开始生成koolproxy证书，用于https过滤！大约需要20S以上的时间，请耐心等待！"
chmod 777 $koolproxydir/koolproxy/data/gen_ca.sh
$koolproxydir/koolproxy/data/gen_ca.sh
	fi
	logger -t "【koolproxy】" "koolproxy证书位于$koolproxydir/koolproxy/data/private"
	
	chmod 777 $koolproxydir/koolproxy/koolproxy

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
sed -i '/koolproxy/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/koolproxy.sh&
EOF
fi
if [ "$koolproxyhttps" != "1" ]; then
logger -t "koolproxy" "找不到透明代理3000端口，添加代理端口"
iptables -t nat -A PREROUTING -p tcp -m multiport --dport 80,8080 -j REDIRECT --to-ports 3000
sed -i '/koolproxy/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/koolproxy.sh&
EOF
logger -t "koolproxy" "端口添加成功。"
fi
