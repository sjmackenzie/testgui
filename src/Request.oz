functor
import
export
   'request_view':View
define
   fun {View Data}
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
	       lr(glue:nsw handle:Hd1)}
	handle: Hd1
	set: proc {$ Ds}
		for D#V in Ds do {HR.D set(V)} end end
	get: fun{$}
		{Map Feats fun {$ D} D#{HR.D get($)} end} end)
   end
end