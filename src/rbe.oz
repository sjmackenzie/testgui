functor
import
   Application
   QTk at 'x-oz://system/wp/QTk.ozf'

define
   L1 R1 L2 R2 L3 R3 L4 R4
   List=[a b c d e f g h i j k l m n o p]
   Desc = td(title:"Handpassed - a resource based economy"
	     lr(glue: nwe
		label(handle: StatusLabel glue:nwe)
	       )
	     lr(glue: nswe
		td(glue: nswe
		   tbbutton(text: "Make a Request" glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Your Networks Needs" glue:nwe)
		   listbox(init:List
			   handle:L1
			   return:R1
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Share Something" glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Packages to help pass" glue:nwe)
		   listbox(init:List
			   handle:L2
			   return:R2
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Post a Package" glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Items in hand" glue:nwe)
		   listbox(init:List
			   handle:L3
			   return:R3
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Give a class" glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Take a class" glue:nwe)
		   listbox(init:List
			   handle:L4
			   return:R4
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