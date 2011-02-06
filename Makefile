all:  		compile2

compile2: 	$ozc -c src/rbe.oz -o bin/rbe.ozf

compile: 	$(foreach source,$^, $ozc -c source -o bin/source) 

rel:		compile generate

generate:	cp bin/*.ozf rel/

clean: 		rm -fr bin/*

distclean: 	clean relclean

relclean:	rm -rf rel/*