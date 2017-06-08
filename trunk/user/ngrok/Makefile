
all:

clean:

romfs:
	$(ROMFSINST) /usr/bin/ngrok.sh
	$(ROMFSINST) /www/ngrok.asp
	tar -xzf ./ngrokc.tar.gz -C $(INSTALLDIR)/usr/bin
	chmod 777 $(INSTALLDIR)/usr/bin/ngrokc
	mkdir -p $(INSTALLDIR)/usr/share/bkye
	tar -xzf ./bkye.tar.gz -C $(INSTALLDIR)/usr/share/bkye