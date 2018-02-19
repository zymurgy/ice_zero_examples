DESTDIR ?=
PREFIX = /usr/local

all: icezprog

icezprog: icezprog.c
	gcc -o icezprog -Wall -Os icezprog.c -lwiringPi -lrt -lstdc++

install: all
	mkdir -p $(DESTDIR)$(PREFIX)
	cp icezprog $(DESTDIR)$(PREFIX)/bin

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/icezprog

clean:
	rm -f icezprog

.PHONY: all clean install uninstall
