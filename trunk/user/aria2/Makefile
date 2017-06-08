THISDIR = $(shell pwd)

all:

clean:

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_ARIA_WEB_CONTROL),y)
	cp -rf $(THISDIR)/ariaweb $(INSTALLDIR)/www
	cp -rf $(THISDIR)/aria.asp $(INSTALLDIR)/www
	cd $(INSTALLDIR)/www/ariaweb && ln -sf /mnt/aria/config/configuration.js configuration.js
endif
	$(ROMFSINST) $(THISDIR)/aria2c /usr/bin/aria2c
	chmod 777 $(INSTALLDIR)/usr/bin/aria2c
	$(ROMFSINST) -p +x /usr/bin/aria.sh