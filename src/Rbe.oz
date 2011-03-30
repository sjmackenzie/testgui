functor
import
   Application
   Education at 'Education.ozf'
   PackageFlow at 'PackageFlow.ozf'
   Needs at 'Needs.ozf'
   QTk at 'x-oz://system/wp/QTk.ozf'
   

define
   fun {InitList WhichList}
      case WhichList
      of network_needs then
	 {Needs.init}
      [] help_pass then
	 {PackageFlow.upstream}
      [] pkg_in_hand then
	 {PackageFlow.in_hand}
      [] take_class then
	 {Education.init}
      end
   end
   
   L1 R1 L2 R2 L3 R3 L4 R4
   Desc = td(title:"Handpassed - a resource based economy"
	     lr(glue: nwe
		label(handle: StatusLabel glue:nwe)
	       )
	     lr(glue: nswe
		td(glue: nswe
		   tbbutton(text:"Make a Request" bg:white glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Your Networks Needs" bg:white glue:nwe)
		   listbox(init:{InitList network_needs}
			   handle:L1
			   return:R1
			   bg:white
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Share Something" bg:white glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Packages to help pass" bg:white glue:nwe)
		   listbox(init:{InitList help_pass}
			   handle:L2
			   return:R2
			   bg:white
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Post a Package" bg:white glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Items in hand" bg:white glue:nwe)
		   listbox(init:{InitList pkg_in_hand}
			   handle:L3
			   return:R3
			   bg:white
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Give a class" bg:white glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Take a class" bg:white glue:nwe)
		   listbox(init:{InitList take_class}
			   handle:L4
			   return:R4
			   bg:white
			   tdscrollbar:true
			   glue:nswe)
		  )
	       )
	    )
   StatusLabel

   Window = {QTk.build Desc}

   proc {ShowStatus}
      {StatusLabel set(bg: white text: "Handpassed")}
   end

   thread
      {ShowStatus}
   end

in
   {ShowStatus}
   {Window show(wait:true)}
   {Application.exit 0}
end