SRC_NAME=lrzsz-0.12.20

THISDIR = $(shell pwd)

all: config_test
	$(MAKE) -C $(SRC_NAME)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	./configure \
		--prefix=/usr \
		--with-libiconv-prefix=$(STAGEDIR) \
		--with-os-name="Linux" \
		--with-os-version="Linux/Cross_compiled" \
		--with-os-url="http://www.kernel.org/" \
		--host=$(HOST_TARGET) \
		--build=$(HOST_BUILD) ; \
	)

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ; \
	fi ; \
	rm -f config_done

romfs:
	$(ROMFSINST) $(THISDIR)/$(SRC_NAME)/src/lrz /usr/bin/lrz
	$(ROMFSINST) $(THISDIR)/$(SRC_NAME)/src/lsz /usr/bin/lsz

