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
	cp CHANGES.md cmdseq cmdseq.1 COPYRIGHT LICENSE-* Makefile cmdseq-$$v; \
	  tar cfz cmdseq-$$v.tgz cmdseq-$$v; \
	  rm -rf cmdseq-$$v
