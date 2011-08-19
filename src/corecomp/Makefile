MAKE = make
INSTALL = install
INSTALL_FUNCTOR = $(INSTALL) -m 644
DESTDIR = ../../lib/corecomp/
SRCS = Board Component

all: $(foreach source, $(SRCS), src_$(source))

install: check_destdir $(foreach source, $(SRCS), install_$(source))

check_destdir:
	if ! test -d $(DESTDIR); then mkdir $(DESTDIR); fi

install_%:
	$(INSTALL_FUNCTOR) $(subst install_,,$@).ozf $(DESTDIR)

src_%:
	ozc -c $(subst src_,,$@).oz -o $(subst src_,,$@).ozf

tester: Tester.oz
	ozc -x Tester.oz -o tester

clean:
	rm -rf *ozf
	rm -rf tester

.PHONY: all clean
