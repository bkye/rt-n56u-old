SRC_NAME=PadavanThemePack_v2.4.26_lite
THISDIR = $(shell pwd)

all: config_test

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( test -d $(SRC_NAME) || unzip -oq $(SRC_NAME).zip -d $(SRC_NAME) )

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done
	rm -rf install

romfs:
	cp -af $(THISDIR)/$(SRC_NAME)/* $(INSTALLDIR)/www
