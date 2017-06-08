#!/bin/sh

ngrokenable=`nvram get ngrok_enable`
ngrokip=`nvram get ngrok_ip`
ngrokprot=`nvram get ngrok_prot`
ngroktoken=`nvram get ngrok_token`
ngrokhost=`nvram get ngrok_host`
ngrokxenable0=`nvram get ngrok_x_enable0`
ngrokxenable1=`nvram get ngrok_x_enable1`
ngrokxenable2=`nvram get ngrok_x_enable2`
ngrokxenable3=`nvram get ngrok_x_enable3`
ngrokxenable4=`nvram get ngrok_x_enable4`
ngrokxtype0=`nvram get ngrok_x_type0`
ngrokxtype1=`nvram get ngrok_x_type1`
ngrokxtype2=`nvram get ngrok_x_type2`
ngrokxtype3=`nvram get ngrok_x_type3`
ngrokxtype4=`nvram get ngrok_x_type4`
chkzdy0=`nvram get chk_zdy0`
chkzdy1=`nvram get chk_zdy1`
chkzdy2=`nvram get chk_zdy2`
chkzdy3=`nvram get chk_zdy3`
chkzdy4=`nvram get chk_zdy4`
ngrokxsname0=`nvram get ngrok_x_sname0`
ngrokxsname1=`nvram get ngrok_x_sname1`
ngrokxsname2=`nvram get ngrok_x_sname2`
ngrokxsname3=`nvram get ngrok_x_sname3`
ngrokxsname4=`nvram get ngrok_x_sname4`
ngrokxlip0=`nvram get ngrok_x_lip0`
ngrokxlip1=`nvram get ngrok_x_lip1`
ngrokxlip2=`nvram get ngrok_x_lip2`
ngrokxlip3=`nvram get ngrok_x_lip3`
ngrokxlip4=`nvram get ngrok_x_lip4`
ngrokxlpot0=`nvram get ngrok_x_lpot0`
ngrokxlpot1=`nvram get ngrok_x_lpot1`
ngrokxlpot2=`nvram get ngrok_x_lpot2`
ngrokxlpot3=`nvram get ngrok_x_lpot3`
ngrokxlpot4=`nvram get ngrok_x_lpot4`
ngrokxspot0=`nvram get ngrok_x_spot0`
ngrokxspot1=`nvram get ngrok_x_spot1`
ngrokxspot2=`nvram get ngrok_x_spot2`
ngrokxspot3=`nvram get ngrok_x_spot3`
ngrokxspot4=`nvram get ngrok_x_spot4`

if [ "$ngrokenable" != "1" ]; then
killall ngrokc
sed -i '/ngrok/d' /etc/storage/post_wan_script.sh
logger -t "ngrok" "已停止ngrok"
exit 0
fi

export LD_LIBRARY_PATH="/lib:/usr/share/bkye"
if [ "$ngrokenable" = "1" ] ; then
#第一条协议
check=$(ps | grep "ngrokc" | grep -v "grep" | wc -l)
if [ "$check" != 0 ]; then
    logger -t "ngrok" "重新启动ngrok..."
	killall ngrokc
fi
if [ "$ngrokxenable0" = "1" ] ; then
if [ "$ngrokxtype0" != "tcp" ]; then
if [ "$chkzdy0" = "1" ]; then
if [ "$ngrokhost" = "" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype0,Lhost:$ngrokxlip0,Lport:$ngrokxlpot0,Sdname:$ngrokxsname0] & 
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype0,Lhost:$ngrokxlip0,Lport:$ngrokxlpot0,Hostname:$ngrokhost] & 
fi
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype0,Lhost:$ngrokxlip0,Lport:$ngrokxlpot0,Sdname:$ngrokxsname0] & 
fi
fi
if [ "$ngrokxtype0" = "tcp" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype0,Lhost:$ngrokxlip0,Lport:$ngrokxlpot0,Rport:$ngrokxspot0] & 
fi
logger -t "ngrok" "第一条协议已加载成功"
fi
#第二条协议
if [ "$ngrokxenable1" = "1" ] ; then
if [ "$ngrokxtype1" != "tcp" ]; then
if [ "$chkzdy1" = "1" ]; then
if [ "$ngrokhost" = "" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype1,Lhost:$ngrokxlip1,Lport:$ngrokxlpot1,Sdname:$ngrokxsname1] & 
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype1,Lhost:$ngrokxlip1,Lport:$ngrokxlpot1,Hostname:$ngrokhost] & 
fi
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype1,Lhost:$ngrokxlip1,Lport:$ngrokxlpot1,Sdname:$ngrokxsname1] & 
fi
fi
if [ "$ngrokxtype1" = "tcp" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype1,Lhost:$ngrokxlip1,Lport:$ngrokxlpot1,Rport:$ngrokxspot1] & 
fi
logger -t "ngrok" "第二条协议已加载成功"
fi
if [ "$ngrokxenable2" = "1" ] ; then
if [ "$ngrokxtype2" != "tcp" ]; then
if [ "$chkzdy2" = "1" ]; then
if [ "$ngrokhost" = "" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype2,Lhost:$ngrokxlip2,Lport:$ngrokxlpot2,Sdname:$ngrokxsname2] & 
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype2,Lhost:$ngrokxlip2,Lport:$ngrokxlpot2,Hostname:$ngrokhost] & 
fi
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype2,Lhost:$ngrokxlip2,Lport:$ngrokxlpot2,Sdname:$ngrokxsname2] & 
fi
fi
if [ "$ngrokxtype2" = "tcp" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype2,Lhost:$ngrokxlip2,Lport:$ngrokxlpot2,Rport:$ngrokxspot2] & 
fi
logger -t "ngrok" "第三条协议已加载成功"
fi
if [ "$ngrokxenable3" = "1" ] ; then
if [ "$ngrokxtype3" != "tcp" ]; then
if [ "$chkzdy3" = "1" ]; then
if [ "$ngrokhost" = "" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype3,Lhost:$ngrokxlip3,Lport:$ngrokxlpot3,Sdname:$ngrokxsname3] & 
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype3,Lhost:$ngrokxlip3,Lport:$ngrokxlpot3,Hostname:$ngrokhost] & 
fi
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype3,Lhost:$ngrokxlip3,Lport:$ngrokxlpot3,Sdname:$ngrokxsname3] & 
fi
fi
if [ "$ngrokxtype2" = "tcp" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype3,Lhost:$ngrokxlip3,Lport:$ngrokxlpot3,Rport:$ngrokxspot3] & 
fi
logger -t "ngrok" "第四条协议已加载成功"
fi
if [ "$ngrokxenable4" = "1" ] ; then
if [ "$ngrokxtype4" != "tcp" ]; then
if [ "$chkzdy4" = "1" ]; then
if [ "$ngrokhost" = "" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype4,Lhost:$ngrokxlip4,Lport:$ngrokxlpot4,Sdname:$ngrokxsname4] & 
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype4,Lhost:$ngrokxlip4,Lport:$ngrokxlpot4,Hostname:$ngrokhost] & 
fi
else
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype4,Lhost:$ngrokxlip4,Lport:$ngrokxlpot4,Sdname:$ngrokxsname4] & 
fi
fi
if [ "$ngrokxtype2" = "tcp" ]; then
ngrokc -SER[Shost:$ngrokip,Sport:$ngrokprot,Atoken:$ngroktoken] -AddTun[Type:$ngrokxtype4,Lhost:$ngrokxlip4,Lport:$ngrokxlpot4,Rport:$ngrokxspot4] & 
fi
logger -t "ngrok" "第五条协议已加载成功"
fi
checkok=$(ps | grep "ngrokc" | grep -v "grep" | wc -l)
if [ "$checkok" != 0 ]; then
    logger -t "ngrok" "启动成功！"
sed -i '/ngrok/d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
/usr/bin/ngrok.sh&
EOF
else
logger -t "ngrok" "启动失败，请重试。"
nvram set ngrok_enable="0"
fi
fi
fi
