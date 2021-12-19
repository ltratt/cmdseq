PREFIX ?= /usr/local
MAN_PREFIX ?= ${PREFIX}/man

all:
# Intentionally empty


install:
	install -d ${PREFIX}/bin
	install -c -m 555 cmdseq ${PREFIX}/bin
	install -d ${MAN_PREFIX}/man1
	install -c -m 444 cmdseq.1 ${MAN_PREFIX}/man1/cmdseq.1


clean:
# Intentionally empty


distrib:
	@read v?'cmdseq version: '; mkdir cmdseq-$$v; \
	cp cmdseq cmdseq.1 cmdseq-$$v; \
	  cp Makefile.cmdseq cmdseq-$$v/Makefile; \
	  tar cfz cmdseq-$$v.tar.gz cmdseq-$$v; \
	  rm -rf cmdseq-$$v
