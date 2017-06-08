/*
 * event_mask 
 */

#ifndef _COMMON_H_
#define _COMMON_H_

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef ABS
#define	ABS(a)			(((a) < 0)?-(a):(a))
#endif /* ABS */

#ifndef MIN
#define	MIN(a, b)		(((a) < (b))?(a):(b))
#endif /* MIN */

#ifndef MAX
#define	MAX(a, b)		(((a) > (b))?(a):(b))
#endif /* MAX */

typedef u_int64_t u64;
typedef u_int32_t u32;
typedef u_int16_t u16;
typedef u_int8_t u8;

#define EVM_RESTART_FIREWALL		(1ULL <<  0)
#define EVM_RESTART_DHCPD		(1ULL <<  1)
#define EVM_RESTART_RADV		(1ULL <<  2)
#define EVM_RESTART_DDNS		(1ULL <<  3)
#define EVM_RESTART_UPNP		(1ULL <<  4)
#define EVM_RESTART_TIME		(1ULL <<  5)
#define EVM_RESTART_NTPC		(1ULL <<  6)
#define EVM_RESTART_SYSLOG		(1ULL <<  7)
#define EVM_RESTART_NETFILTER		(1ULL <<  8)
#define EVM_REAPPLY_VPNSVR		(1ULL <<  9)
#define EVM_RESTART_VPNSVR		(1ULL << 10)
#define EVM_RESTART_VPNCLI		(1ULL << 11)
#define EVM_RESTART_WIFI2		(1ULL << 12)
#define EVM_RESTART_WIFI5		(1ULL << 13)
#define EVM_RESTART_SWITCH_CFG		(1ULL << 14)
#define EVM_RESTART_SWITCH_VLAN		(1ULL << 15)
#define EVM_RESTART_LAN			(1ULL << 17)
#define EVM_RESTART_WAN			(1ULL << 18)
#define EVM_RESTART_IPV6		(1ULL << 19)
#define EVM_RESTART_HTTPD		(1ULL << 20)
#define EVM_RESTART_TELNETD		(1ULL << 21)
#define EVM_RESTART_SSHD		(1ULL << 22)
#define EVM_RESTART_WINS		(1ULL << 23)
#define EVM_RESTART_LLTD		(1ULL << 24)
#define EVM_RESTART_ADSC		(1ULL << 25)
#define EVM_RESTART_IPTV		(1ULL << 26)
#define EVM_RESTART_CROND		(1ULL << 27)
#define EVM_RESTART_SYSCTL		(1ULL << 28)
#define EVM_RESTART_TWEAKS		(1ULL << 29)
#define EVM_RESTART_WDG			(1ULL << 30)
#define EVM_RESTART_DI			(1ULL << 31)
#define EVM_RESTART_SPOOLER		(1ULL << 32)
#define EVM_RESTART_MODEM		(1ULL << 33)
#define EVM_RESTART_HDDTUNE		(1ULL << 34)
#define EVM_RESTART_FTPD		(1ULL << 35)
#define EVM_RESTART_NMBD		(1ULL << 36)
#define EVM_RESTART_SMBD		(1ULL << 37)
#define EVM_RESTART_NFSD		(1ULL << 38)
#define EVM_RESTART_DMS			(1ULL << 39)
#define EVM_RESTART_ITUNES		(1ULL << 40)
#define EVM_RESTART_TRMD		(1ULL << 41)
#define EVM_RESTART_ARIA		(1ULL << 42)
#define EVM_RESTART_XUNLEI		(1ULL << 43) //添加迅雷
#define EVM_RESTART_ADBYBY		(1ULL << 44) //ADBYBY
#define EVM_RESTART_KMS		    (1ULL << 45) //KMS
#define EVM_RESTART_KOOLPROXY		    (1ULL << 46) //KKOOLPROXY
#define EVM_RESTART_DNSQ		    (1ULL << 47) //DNS
#define EVM_RESTART_NGROK		    (1ULL << 48) //DNS
#define EVM_RESTART_REBOOT		(1ULL << 62)

#define EVM_BLOCK_UNSAFE		(1ULL << 63) /* special case */


#define EVT_RESTART_FIREWALL		1
#define EVT_RESTART_DHCPD		1
#define EVT_RESTART_RADV		1
#define EVT_RESTART_DDNS		1
#define EVT_RESTART_UPNP		1
#define EVT_RESTART_TIME		2
#define EVT_RESTART_NTPC		1
#define EVT_RESTART_SYSLOG		1
#define EVT_RESTART_NETFILTER		1
#define EVT_REAPPLY_VPNSVR		1
#define EVT_RESTART_VPNSVR		2
#define EVT_RESTART_VPNCLI		2
#if defined (USE_RT3352_MII)
#define EVT_RESTART_WIFI2		5
#else
#define EVT_RESTART_WIFI2		3
#endif
#define EVT_RESTART_WIFI5		3
#define EVT_RESTART_SWITCH_CFG		3
#define EVT_RESTART_SWITCH_VLAN		3
#define EVT_RESTART_LAN			5
#define EVT_RESTART_WAN			5
#define EVT_RESTART_IPV6		3
#define EVT_RESTART_HTTPD		2
#define EVT_RESTART_TELNETD		1
#define EVT_RESTART_SSHD		1
#define EVT_RESTART_WINS		2
#define EVT_RESTART_LLTD		1
#define EVT_RESTART_ADSC		1
#define EVT_RESTART_CROND		1
#define EVT_RESTART_IPTV		1
#define EVT_RESTART_SYSCTL		1
#define EVT_RESTART_TWEAKS		1
#define EVT_RESTART_WDG			1
#define EVT_RESTART_DI			1
#define EVT_RESTART_SPOOLER		1
#define EVT_RESTART_MODEM		3
#define EVT_RESTART_HDDTUNE		1
#define EVT_RESTART_FTPD		1
#define EVT_RESTART_NMBD		2
#define EVT_RESTART_SMBD		2
#define EVT_RESTART_NFSD		2
#define EVT_RESTART_DMS			2
#define EVT_RESTART_ITUNES		2
#define EVT_RESTART_TRMD		3
#define EVT_RESTART_ARIA		3
#define EVT_RESTART_XUNLEI		3 //添加迅雷
#define EVT_RESTART_ADBYBY		3 //ADBYBY
#define EVT_RESTART_KMS		    3 //KMS
#define EVT_RESTART_KOOLPROXY	3 //KOOLPROXY
#define EVT_RESTART_DNSQ	3 //DNSQ
#define EVT_RESTART_NGROK	3 //DNSQ
#define EVT_RESTART_REBOOT		40

struct variable
{
	const char *name;
	const char *longname;
	char **argv;
	u64 event_mask;
};

struct svcLink
{
	const char *serviceId;
	struct variable *variables;
};

struct evDesc
{
	u64 event_mask;						//名称
	u32 max_time;						//
	const char* notify_cmd;				//通知名称
	u64 event_unmask;
};

#define ARGV(args...) ((char *[]) { args, NULL })

/* API export for UPnP function */
int LookupServiceId(char *serviceId);
const char *GetServiceId(int sid);
struct variable *GetVariables(int sid);


#endif /* _COMMON_H_ */
