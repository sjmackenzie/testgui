MAKE = make
INSTALL = install
INSTALL_FUNCTOR = $(INSTALL) -m 644
DESTDIR = ../bin/
DESTDIR_FUNCTOR = ../lib/tools/
SRCS = Bootstrap BaseArgs
EXECS = handpassed

all: $(foreach source, $(SRCS), src_$(source)) $(EXECS)

install: check_destdir install_functors install_execs

install_execs: $(foreach bin, $(EXECS), install_exec_$(bin))

install_functors: $(foreach source, $(SRCS), install_func_$(source))

install_exec_%:
	$(INSTALL) $(subst install_exec_,,$@) $(DESTDIR)

install_func_%:
	$(INSTALL_FUNCTOR) $(subst install_func_,,$@).ozf $(DESTDIR_FUNCTOR)

check_destdir:
	if ! test -d $(DESTDIR); then mkdir $(DESTDIR); fi
	if ! test -d $(DESTDIR_FUNCTOR); then mkdir $(DESTDIR_FUNCTOR); fi

handpassed: Handpassed.oz
	ozc -x Handpassed.oz -o $@

src_%:
	ozc -c $(subst src_,,$@).oz -o $(subst src_,,$@).ozf

clean: $(foreach bin, $(EXECS), clean_$(bin))
	rm -rf *ozf

clean_%:
	rm -f $(subst clean_,,$@)

.PHONY: all clean
