all:
	@ozmake -vn --builddir='bin'  --bindir='rel'

run:
	@ozengine bin/src/Rbe.ozf

clean:
	@rm -fr bin/*

relclean:
	@rm -rf rel/*

distclean: clean relclean
