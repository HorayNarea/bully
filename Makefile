prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin

W_NAME	= bully
W_ROOT	= src

CFLAGS	+= -I$(W_ROOT) -I$(W_ROOT)/utils/ -I$(W_ROOT)/tls/ -I$(W_ROOT)/wps/ -I$(W_ROOT)/crypto/ -I$(W_ROOT)/common/

LDFLAGS += -lpcap -lssl -lcrypto

HDRS	= $(W_ROOT)/$(W_NAME).h $(W_ROOT)/80211.h $(W_ROOT)/frame.h $(W_ROOT)/iface.h $(W_ROOT)/bswap.h $(W_ROOT)/version.h
SRCS	= $(W_ROOT)/$(W_NAME).c $(W_ROOT)/80211.c $(W_ROOT)/frame.c $(W_ROOT)/iface.c $(W_ROOT)/crc32.c $(W_ROOT)/timer.c $(W_ROOT)/utils.c

all: $(W_NAME)

$(W_NAME): $(HDRS) $(SRCS)
	$(CC) $(CFLAGS) -o $(@) $(W_ROOT)/$(W_NAME).c $(LDFLAGS)

strip: $(W_NAME)
	strip $(W_NAME)

clean:
	-rm -f $(W_NAME) $(W_NAME).o

distclean: clean

install: all
	install -d $(DESTDIR)$(bindir)
	install -m 755 $(W_NAME) $(DESTDIR)$(bindir)

uninstall:
	-rm -f $(DESTDIR)$(bindir)/$(W_NAME)
