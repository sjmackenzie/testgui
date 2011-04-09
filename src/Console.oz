functor
import
export
   'input':Input
   'widget':Widget
   'edit_widget':EditWidget
define
   fun {Input Text}
      case Text
      of clear then
	 clear
      [] _ then Text
      end
   end

   fun {Widget Data}
      Hd1 In={NewCell Data}
      HR={MakeRecord hr {Map Data fun {$ D#_} D end}}
   in
      r(spec: {Adjoin
		{List.toTuple td
		 {Map Data fun {$ D#V}
			      label(glue:we handle:HR.D text:D#":"#V) end}}
		td(glue:nswe handle:Hd1)}
	 handle: Hd1
	 set: proc {$ Ds}
		 In:=Ds
		 for D#V in Ds do {HR.D set(text:D#":"#V)} end
	      end
	 get:fun {$} @In end)
   end

   fun {EditWidget Data}
      Hd1 Feats={Map Data fun {$ D#_} D end}
      HR={MakeRecord hr Feats}
      fun {Loop Ds}
	 case Ds of D#V|Dr then
	    label(glue:e text:D#":") |
	    entry(handle:HR.D init:V glue:we) |
	    newline | {Loop Dr}
	 else nil end
      end
   in
      r(spec: {Adjoin
	       {List.toTuple lr {Loop Data}}
	       lr(glue:nswe handle:Hd1)}
	handle:Hd1
	set: proc{$ Ds}
		for D#V in Ds do {HR.D set(V)} end end
	get: fun {$}
		{Map Feats fun {$ D} D#{HR.D get($)} end} end)
   end
  

end