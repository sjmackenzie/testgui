functor
import
   Application
   Education at 'Education.ozf'
   PackageFlow at 'PackageFlow.ozf'
   Needs at 'Needs.ozf'
   Request at 'Request.ozf'
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
   TextHandle TR
   InputHandle IR
   Desc = td(title:"Handpassed - a resource based economy"
	     lr(glue: nwe
		label(handle: StatusLabel glue:nwe)
	       )
	     lr(button(text:"Make a Request" bg:white glue:nwe)
		button(text: "Share Something" bg:white glue:nwe)
		button(text: "Post a Package" bg:white glue:nwe)
		button(text: "Give a class" bg:white glue:nwe)
		button(text: "Locations" bg:white glue:nwe)
	       )
	     lr(
		td(text(tdscrollbar:true
			init:"This is a text widget"
			handle:TextHandle
			return:TR
			glue:we
		       )
		   lr(entry(init:"type here"
			    handle:InputHandle
			    return:IR
			    glue:we
			   )
		      button(text:"send"
			     glue:w
			     action:proc{$} {TextHandle insert({InputHandle get($)})} end
			    )
		      )
		   )
		  )
	     lr(glue: nswe
		td(glue: nswe
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