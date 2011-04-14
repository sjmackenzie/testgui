functor
import
export
   'share_view':ShareView
define
   fun {ShareView Data}
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

end