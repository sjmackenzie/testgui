functor
import
export
   'upstream':Upstream
   'in_hand':InHand
   'downstream':Downstream
   'postal_view':PostalView
define
   fun {Upstream}
      [u p s t r e a m]
   end
   fun {InHand}
      [i n h a n d]
   end
   fun {Downstream}
      [d o w n s t r e a m]
   end
   fun {PostalView Data}
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