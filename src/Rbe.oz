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
   Desc = lr(title:"Handpassed - a resource based economy"
	     tdspace(glue:ns width:10)
	     tdrubberframe(glue:nswe
			   td(glue:nswe
			      lrspace(glue:we width:10)			      
			      label(handle: StatusLabel glue:nwe)
			      lrspace(glue:we width:10)
			      lr(glue:we
				 button(text:"Make a Request"  glue:nwe)
				 tdspace(glue:ns width:5)
				 button(text:"Share Something" glue:nwe)
				 tdspace(glue:ns width:5)				 
				 button(text:"Post a Package"  glue:nwe)
				 tdspace(glue:ns width:5)
				 button(text:"Give a class" glue:nwe)
				 tdspace(glue:ns width:5)				 
				 button(text:"Locations"  glue:nwe))
			      lrspace(glue:we width:10)
			      lr(glue:nswe
				 td(glue:nswe
				    text(tdscrollbar:true
					 init:""
					 handle:TextHandle
					 bg:white
					 return:TR
					 glue:nswe)
				    lrspace(glue:we width:10)
				    lr(glue:nwe
				       entry(init:""
					     handle:InputHandle
					     return:IR
					     bg:white
					     glue:we)
				 tdspace(glue:ns width:5)				       
				       button(text:"send"
					      glue:e
					      action:proc{$} {TextHandle insert({InputHandle get($)})} end))))
     			      lrspace(glue:we width:10))
			   td(glue: nswe
			      lr(glue: nswe
				 td(glue: nswe
				    label(text:"Community Needs" glue:nwe)
				    listbox(init:{InitList network_needs}
					    handle:L1
					    return:R1
					    bg:white
					    tdscrollbar:true
					    glue:nswe))
				 tdspace(glue:ns width:5)				 
				 td(glue: nswe
				    label(text:"Upstream" glue:nwe)
				    listbox(init:{InitList help_pass}
					    handle:L2
					    return:R2
					    bg:white
					    tdscrollbar:true
					    glue:nswe))
				 tdspace(glue:ns width:5)				 
				 td(glue: nswe
				    label(text:"In Hand"  glue:nwe)
				    listbox(init:{InitList pkg_in_hand}
					    handle:L3
					    return:R3
					    bg:white
					    tdscrollbar:true
					    glue:nswe))
				 tdspace(glue:ns width:5)				 
				 td(glue: nswe
				    label(text:"Take a class"  glue:nwe)
				    listbox(init:{InitList take_class}
					    handle:L4
					    return:R4
					    bg:white
					    tdscrollbar:true
					    glue:nswe)))
			      lrspace(glue:we width:10)))
	     tdspace(glue:ns width:10))
   StatusLabel

   Window = {QTk.build Desc}

   proc {ShowStatus}
      {StatusLabel set(text: "Handpassed")}
   end

   thread
      {ShowStatus}
   end

in
   {ShowStatus}
   {Window show(wait:true)}
   {Application.exit 0}
end