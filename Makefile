CC=g++
OBJS=main.o tracker.o acceptor.o worker.o v8funcs.o
CFLAGS=-Wall -DEV_STANDALONE=1 -DEV_MULTIPLICITY=1 `mysql_config --cflags`
LDFLAGS=-lpthread  -lv8 -lev `mysql_config --libs` 


UNAME := $(shell uname)
ifeq ($(UNAME), FreeBSD)
CFLAGS+= -I/usr/local/include
LDFLAGS+= -lexecinfo -L/usr/local/lib
endif

ifeq ($(DEBUG), 1)
CFLAGS += -ggdb -DDEBUG
endif


all: lbtt

lbtt: $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

.cpp.o:
	$(CC) $(CFLAGS) -c -O $*.cpp

install:
	install -d $(DESTDIR)/usr/share/lbtt/
	install -d $(DESTDIR)/usr/sbin/
	install -v -m 755 lbtt $(DESTDIR)/usr/sbin/
	install -v -m 644 lbtt.js $(DESTDIR)/usr/share/lbtt/

clean:
	rm -f *.o lbtt
