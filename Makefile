MAKE 	= make
SUBDIRS	= src tools docsrc

all: lib bin

help:
	@echo "Handpassed's main Makefile"
	@echo "To build and install Handpassed and its tools, run:"
	@echo ""
	@echo "make"
	@echo "make install"
	@echo ""
	@echo "To build each part independently run:"
	@echo ""
	@echo "make doc\tto build documentation"
	@echo "make lib\tto build Handpassed's components"
	@echo "make bin\tto build Handpassed's tools"
	@echo ""
	@echo "To install each part independently run:"
	@echo ""
	@echo "make install-doc\t to install documentation"
	@echo "make install-lib\t to install Handpassed's components"
	@echo "make install-bin\t to install Handpassed's tools"
	@echo ""
	@echo "To clean directories docsrc, src and tools run:"
	@echo ""
	@echo "make clean"
	@echo ""
	@echo "To clean everything, including directories bin, lib, and doc, run:"
	@echo ""
	@echo "make veryclean"
	@echo ""
	@echo "Handpassed is released under the MIT License (see file LICENSE)"

doc:
	$(MAKE) -C docsrc all

lib:
	$(MAKE) -C src all

bin:
	$(MAKE) -C tools all


install: install-lib install-bin

install-doc:
	$(MAKE) -C docsrc install

install-lib:
	$(MAKE) -C src install

install-bin:
	$(MAKE) -C tools install

install-java-api:
	$(MAKE) -C java-api/oz-interface install

clean: cleanlibs

cleanlibs:$(foreach subdir, $(SUBDIRS), subclean_$(subdir))

subclean_%:
	$(MAKE) -C $(subst subclean_,,$@) clean

veryclean: clean
	rm -rf bin/*
	rm -rf doc/*
	rm -rf lib/*

.PHONY: all clean doc lib bin