THISDIR = $(shell pwd)

all:

clean:

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_TRANSMISSION_WEB_CONTROL),y)
	mkdir -p $(INSTALLDIR)/usr/share/transmission
	cp -rf $(THISDIR)/transmission-control/web $(INSTALLDIR)/usr/share/transmission
	#cp -rf $(THISDIR)/transmission-control $(INSTALLDIR)/www
	cp -rf $(THISDIR)/trmd.asp $(INSTALLDIR)/www
else
	cp -rf $(THISDIR)/install/usr/share/transmission $(INSTALLDIR)/usr/share
	rm -f $(INSTALLDIR)/usr/share/transmission/web/LICENSE
endif
	$(ROMFSINST) $(THISDIR)/transmission-daemon /usr/bin/transmission-daemon
	chmod 777 $(INSTALLDIR)/usr/bin/transmission-daemon
	$(ROMFSINST) -p +x /usr/bin/transmission.sh
