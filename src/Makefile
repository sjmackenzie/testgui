MAKE = make
DESTDIR = ../../lib/
SUBDIRS = commons corecomp logger

all: sublibs

install: check_destdir installlibs

clean: cleanlibs
	rm -rf *ozf

check_destdir:
	if ! test -d $(DESTDIR); then mkdir $(DESTDIR); fi

sublibs:$(foreach subdir, $(SUBDIRS), sub_$(subdir))

installlibs:$(foreach subdir, $(SUBDIRS), subinstall_$(subdir))

cleanlibs:$(foreach subdir, $(SUBDIRS), subclean_$(subdir))

sub_%:
	$(MAKE) -C $(subst sub_,,$@) all

subinstall_%:
	$(MAKE) -C $(subst subinstall_,,$@) install

subclean_%:
	$(MAKE) -C $(subst subclean_,,$@) clean

.PHONY: all