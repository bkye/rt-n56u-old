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