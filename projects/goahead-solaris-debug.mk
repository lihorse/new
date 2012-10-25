#
#   goahead-solaris-debug.mk -- Makefile to build Embedthis GoAhead for solaris
#

ARCH     ?= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/')
OS       ?= solaris
CC       ?= gcc
LD       ?= /usr/bin/ld
PROFILE  ?= debug
CONFIG   ?= $(OS)-$(ARCH)-$(PROFILE)

CFLAGS   += -fPIC  -mtune=generic -w
DFLAGS   += -D_REENTRANT -DPIC 
IFLAGS   += -I$(CONFIG)/inc
LDFLAGS  += '-g'
LIBPATHS += -L$(CONFIG)/bin
LIBS     += -llxnet -lrt -lsocket -lpthread -lm -ldl

CFLAGS-debug    := -DBIT_DEBUG -g
CFLAGS-release  := -O2
LDFLAGS-debug   := -g
LDFLAGS-release := 
CFLAGS          += $(CFLAGS-$(PROFILE))
LDFLAGS         += $(LDFLAGS-$(PROFILE))

all: prep \
        $(CONFIG)/bin/libgo.a \
        $(CONFIG)/bin/goahead \
        $(CONFIG)/bin/goahead-test \
        $(CONFIG)/bin/gopass \
        $(CONFIG)/bin/webcomp \
        test/cgi-bin/cgitest

.PHONY: prep

prep:
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc $(CONFIG)/obj $(CONFIG)/lib $(CONFIG)/bin ; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/goahead-$(OS)-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/goahead-$(OS)-bit.h >/dev/null ; then\
		echo cp projects/goahead-$(OS)-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/goahead-$(OS)-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true

clean:
	rm -rf $(CONFIG)/bin/libgo.a
	rm -rf $(CONFIG)/bin/goahead
	rm -rf $(CONFIG)/bin/goahead-test
	rm -rf $(CONFIG)/bin/gopass
	rm -rf $(CONFIG)/bin/webcomp
	rm -rf test/cgi-bin/cgitest
	rm -rf $(CONFIG)/obj/action.o
	rm -rf $(CONFIG)/obj/alloc.o
	rm -rf $(CONFIG)/obj/auth.o
	rm -rf $(CONFIG)/obj/cgi.o
	rm -rf $(CONFIG)/obj/crypt.o
	rm -rf $(CONFIG)/obj/file.o
	rm -rf $(CONFIG)/obj/http.o
	rm -rf $(CONFIG)/obj/js.o
	rm -rf $(CONFIG)/obj/jst.o
	rm -rf $(CONFIG)/obj/matrixssl.o
	rm -rf $(CONFIG)/obj/openssl.o
	rm -rf $(CONFIG)/obj/options.o
	rm -rf $(CONFIG)/obj/rom-documents.o
	rm -rf $(CONFIG)/obj/rom.o
	rm -rf $(CONFIG)/obj/route.o
	rm -rf $(CONFIG)/obj/runtime.o
	rm -rf $(CONFIG)/obj/socket.o
	rm -rf $(CONFIG)/obj/upload.o
	rm -rf $(CONFIG)/obj/goahead.o
	rm -rf $(CONFIG)/obj/test.o
	rm -rf $(CONFIG)/obj/gopass.o
	rm -rf $(CONFIG)/obj/webcomp.o
	rm -rf $(CONFIG)/obj/cgitest.o

clobber: clean
	rm -fr ./$(CONFIG)

$(CONFIG)/inc/goahead.h: 
	rm -fr $(CONFIG)/inc/goahead.h
	cp -r goahead.h $(CONFIG)/inc/goahead.h

$(CONFIG)/inc/js.h: 
	rm -fr $(CONFIG)/inc/js.h
	cp -r js.h $(CONFIG)/inc/js.h

$(CONFIG)/obj/action.o: \
        action.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/action.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc action.c

$(CONFIG)/obj/alloc.o: \
        alloc.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/alloc.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc alloc.c

$(CONFIG)/obj/auth.o: \
        auth.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/auth.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc auth.c

$(CONFIG)/obj/cgi.o: \
        cgi.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/cgi.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc cgi.c

$(CONFIG)/obj/crypt.o: \
        crypt.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/crypt.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc crypt.c

$(CONFIG)/obj/file.o: \
        file.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/file.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc file.c

$(CONFIG)/obj/http.o: \
        http.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/http.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc http.c

$(CONFIG)/obj/js.o: \
        js.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/js.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc js.c

$(CONFIG)/obj/jst.o: \
        jst.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/jst.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc jst.c

$(CONFIG)/obj/matrixssl.o: \
        matrixssl.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/matrixssl.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc matrixssl.c

$(CONFIG)/obj/openssl.o: \
        openssl.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/openssl.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc openssl.c

$(CONFIG)/obj/options.o: \
        options.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/options.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc options.c

$(CONFIG)/obj/rom-documents.o: \
        rom-documents.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/rom-documents.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc rom-documents.c

$(CONFIG)/obj/rom.o: \
        rom.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/rom.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc rom.c

$(CONFIG)/obj/route.o: \
        route.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/route.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc route.c

$(CONFIG)/obj/runtime.o: \
        runtime.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/runtime.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc runtime.c

$(CONFIG)/obj/socket.o: \
        socket.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/socket.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc socket.c

$(CONFIG)/obj/upload.o: \
        upload.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/upload.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc upload.c

$(CONFIG)/bin/libgo.a:  \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/action.o \
        $(CONFIG)/obj/alloc.o \
        $(CONFIG)/obj/auth.o \
        $(CONFIG)/obj/cgi.o \
        $(CONFIG)/obj/crypt.o \
        $(CONFIG)/obj/file.o \
        $(CONFIG)/obj/http.o \
        $(CONFIG)/obj/js.o \
        $(CONFIG)/obj/jst.o \
        $(CONFIG)/obj/matrixssl.o \
        $(CONFIG)/obj/openssl.o \
        $(CONFIG)/obj/options.o \
        $(CONFIG)/obj/rom-documents.o \
        $(CONFIG)/obj/rom.o \
        $(CONFIG)/obj/route.o \
        $(CONFIG)/obj/runtime.o \
        $(CONFIG)/obj/socket.o \
        $(CONFIG)/obj/upload.o
	/usr/bin/ar -cr $(CONFIG)/bin/libgo.a $(CONFIG)/obj/action.o $(CONFIG)/obj/alloc.o $(CONFIG)/obj/auth.o $(CONFIG)/obj/cgi.o $(CONFIG)/obj/crypt.o $(CONFIG)/obj/file.o $(CONFIG)/obj/http.o $(CONFIG)/obj/js.o $(CONFIG)/obj/jst.o $(CONFIG)/obj/matrixssl.o $(CONFIG)/obj/openssl.o $(CONFIG)/obj/options.o $(CONFIG)/obj/rom-documents.o $(CONFIG)/obj/rom.o $(CONFIG)/obj/route.o $(CONFIG)/obj/runtime.o $(CONFIG)/obj/socket.o $(CONFIG)/obj/upload.o

$(CONFIG)/obj/goahead.o: \
        goahead.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/goahead.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc goahead.c

$(CONFIG)/bin/goahead:  \
        $(CONFIG)/bin/libgo.a \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/goahead.o
	$(CC) -o $(CONFIG)/bin/goahead $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/goahead.o -lgo $(LIBS) $(LDFLAGS)

$(CONFIG)/obj/test.o: \
        test/test.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/test.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc test/test.c

$(CONFIG)/bin/goahead-test:  \
        $(CONFIG)/bin/libgo.a \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/test.o
	$(CC) -o $(CONFIG)/bin/goahead-test $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/test.o -lgo $(LIBS) $(LDFLAGS)

$(CONFIG)/obj/gopass.o: \
        utils/gopass.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/gopass.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc utils/gopass.c

$(CONFIG)/bin/gopass:  \
        $(CONFIG)/bin/libgo.a \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/gopass.o
	$(CC) -o $(CONFIG)/bin/gopass $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/gopass.o -lgo $(LIBS) $(LDFLAGS)

$(CONFIG)/obj/webcomp.o: \
        utils/webcomp.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/webcomp.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc utils/webcomp.c

$(CONFIG)/bin/webcomp:  \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/webcomp.o
	$(CC) -o $(CONFIG)/bin/webcomp $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/webcomp.o $(LIBS) $(LDFLAGS)

$(CONFIG)/obj/cgitest.o: \
        test/cgitest.c \
        $(CONFIG)/inc/bit.h
	$(CC) -c -o $(CONFIG)/obj/cgitest.o -fPIC $(LDFLAGS) -mtune=generic $(DFLAGS) -I$(CONFIG)/inc test/cgitest.c

test/cgi-bin/cgitest:  \
        $(CONFIG)/inc/goahead.h \
        $(CONFIG)/inc/js.h \
        $(CONFIG)/obj/cgitest.o
	$(CC) -o test/cgi-bin/cgitest $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/cgitest.o $(LIBS) $(LDFLAGS)
