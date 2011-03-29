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
		   tbbutton(text:"Make a Request" bg:white glue:nwe)
		   lrline(glue:nwe)
		   label(text:"Your Networks Needs" bg:white glue:nwe)
		   listbox(init:List
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
		   listbox(init:List
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
		   listbox(init:List
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
		   listbox(init:List
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