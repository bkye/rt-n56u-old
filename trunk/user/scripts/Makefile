
all:

clean:

romfs:
	./makedevlinks $(ROMFSDIR)
	$(ROMFSINST) /sbin/dev_init.sh
	$(ROMFSINST) /sbin/reset_ss.sh
	$(ROMFSINST) /sbin/mtd_storage.sh
ifeq ($(STORAGE_ENABLED),y)
	$(ROMFSINST) /sbin/automount.sh
	$(ROMFSINST) /usr/bin/xunlei.sh
	$(ROMFSINST) /usr/bin/adbyby.sh
	$(ROMFSINST) /usr/bin/adbchk.sh
	$(ROMFSINST) /usr/bin/koolproxy.sh
	$(ROMFSINST) /usr/bin/kms.sh
	$(ROMFSINST) /usr/bin/dnsq.sh
endif
ifdef CONFIG_BLK_DEV_SD
	$(ROMFSINST) /sbin/hddtune.sh
	$(ROMFSINST) /sbin/spindown.sh
endif
	$(ROMFSINST) /etc_ro/ld.so.conf
	$(ROMFSINST) /etc_ro/protocols
	$(ROMFSINST) /etc_ro/services
	$(ROMFSINST) /etc_ro/profile
	$(ROMFSINST) /etc_ro/shells
	$(ROMFSINST) /etc_ro/mdev.conf
	$(ROMFSINST) /etc_ro/xware.tgz
	$(ROMFSINST) /etc_ro/7620n.tar.gz
	$(ROMFSINST) /etc_ro/koolproxy.tar.gz
	$(ROMFSINST) /etc_ro/vlmcsd.kmd
	mkdir -p $(INSTALLDIR)/usr/share/terminfo
	tar -xzf ./terminfo.tar.gz -C $(INSTALLDIR)/usr/share
	tar -xzf ./vlmcsd.tar.gz -C $(INSTALLDIR)/usr/bin
	chmod 777 $(INSTALLDIR)/usr/bin/vlmcsd