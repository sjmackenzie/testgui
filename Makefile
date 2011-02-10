all:
	@ozmake -vn --builddir='bin' --srcdir='src' --bindir='rel'

run:
	@ozengine bin/src/Rbe.ozf

clean:
	@rm -fr bin/* src/*.ozf src/*.exe

relclean:
	@rm -rf rel/*

distclean: clean relclean
