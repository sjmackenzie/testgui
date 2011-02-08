functor
import
   Application
   QTk at 'x-oz://system/wp/QTk.ozf'

define
   L1 R1 L2 R2 L3 R3 L4 R4
   Desc = td(title:"Handpassed - a resource based economy"
	     lr(glue: nswe
		label(handle: StatusLabel glue:nwe)
	       )
	     lrline(glue:we)
	     lr(glue: nswe
		td(glue: nswe
		   tbbutton(text: "Make a Request" glue:we)
		   label(text:"Your Networks Needs" glue:nswe)
		   listbox(init:[a b c d e f g h i j k l m n o p]
			   handle:L1
			   return:R1
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Post a Package" glue:we)
		   label(text:"Packages to help pass" glue:nswe)
		   listbox(init:[a b c d e f g h i j k l m n o p]
			   handle:L2
			   return:R2
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Share Something" glue:we)
		   label(text:"Items in hand" glue:nswe)
		   listbox(init:[a b c d e f g h i j k l m n o p]
			   handle:L3
			   return:R3
			   tdscrollbar:true
			   glue:nswe)
		  )
		td(glue: nswe
		   tbbutton(text: "Give a class" glue:we)
		   label(text:"Take a class" glue:nswe)
		   listbox(init:[a b c d e f g h i j k l m n o p]
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
      {StatusLabel set(bg: white text: "Share Something")}
   end

   thread
      {ShowStatus}
   end

in
   {ShowStatus}
   {Window show(wait:true)}
   {Application.exit 0}
end