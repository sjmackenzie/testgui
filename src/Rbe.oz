functor
import
   Application
   Education at 'Education.ozf'
   PackageFlow at 'PackageFlow.ozf'
   Needs at 'Needs.ozf'
   Shares at 'Shares.ozf'
   Request at 'Request.ozf'
   Console at 'Console.ozf'
   Location at 'Location.ozf'
   QTk at 'x-oz://system/wp/QTk.ozf'

define
   Data=[name#"Roger"
	 surname#"Rabbit"
	 age#14]
   TextHandle TR
   InputHandle IR
   L1 R1 L2 R2 L3 R3 L4 R4
   P C
   SBH SBV

   proc {ScanEntry Selected}
      case Selected
      of request then {SBH=SBV}
      [] share then {SBH=SBV}
      [] post then {SBH=SBV}
      [] classes then {SBH=SBV}
      [] locations then {SBH=SBV}
%	 [] _ then {
      end
   end

   proc {InsertEntry Text}
      {InputHandle insert('end'{Console.input Text})}
   end

   proc {SetEntry Text}
      {InputHandle set({Console.input Text})}
   end

   ConsoleView={Console.console_view Data}
   RequestView={Request.request_view Data}
   ShareView={Shares.share_view Data}
   PostalView={PackageFlow.postal_view Data}
%   ClassesView={Education.classes_view Data}
   LocationView={Location.location_view Data}

   MainWindow = lr(title:"Handpassed - a resource based economy"
		   tdspace(glue:ns width:20)
		   tdrubberframe(glue:nswe
				 td(glue:nswe
				    lrspace(glue:we width:10)
				    label(handle: StatusLabel glue:nwe)
				    lrspace(glue:we width:10)
				    lr(glue:we
				       button(text:"Make a Request"
					      action:proc{$} {SetEntry request} end
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Share Something"
					      action:proc{$} {SetEntry share} end
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Post a Package"
					      action:proc{$} {SetEntry post} end
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Give a class"
					      action:proc{$} {SetEntry classes} end
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Locations"
					      action:proc{$} {SetEntry locations} end
					      glue:nwe))
				    lrspace(glue:we width:10)
				    lr(glue:nswe
				       td(glue:nswe
					  text(tdscrollbar:true
					       init:""
					       handle:TextHandle
					       bg:white
					       return:TR
					       glue:nswe)
			 		  td(
					     placeholder(glue:nswe handle:P)
					     checkbutton(text:"Edit" init:false handle:C
							 action:
							    proc{$}
							       Old#New=if {C get($)} then
									  ConsoleView#RequestView
								       else RequestView#ConsoleView end
							    in {New.set {Old.get}} {P set(New.handle)} end))
					  lrspace(glue:we width:10)
					  lr(glue:nwe
					     entry(init:""
						   handle:InputHandle
						   return:IR
						   bg:white
						   glue:we
						   action:proc{$} {ScanEntry {String.toAtom{InputHandle get($)}}} end)
					     tdspace(glue:ns width:5)
					     button(text:"send"
						    glue:e
						    action:proc{$} {TextHandle insert('end' {Console.input {String.toAtom {InputHandle get($)}}})} end))))
				    tdspace(glue:we width:5))
				 td(glue: nswe
				    lr(glue: nswe
				       td(glue: nswe
					  label(text:"Community Needs" glue:nwe)
					  listbox(init:{Needs.init}
						  handle:L1
						  return:R1
						  bg:white
						  tdscrollbar:true
						  glue:nswe))
				       tdspace(glue:ns width:5)
				       td(glue: nswe
					  label(text:"Upstream" glue:nwe)
					  listbox(init:{PackageFlow.upstream}
						  handle:L2
						  return:R2
						  bg:white
						  tdscrollbar:true
						  glue:nswe))
				       tdspace(glue:ns width:5)
				       td(glue: nswe
					  label(text:"In Hand"  glue:nwe)
					  listbox(init:{PackageFlow.in_hand}
						  handle:L3
						  return:R3
						  bg:white
						  tdscrollbar:true
						  glue:nswe))
				       tdspace(glue:ns width:5)
				       td(glue: nswe
					  label(text:"Take a class"  glue:nwe)
					  listbox(init:{Education.init}
						  handle:L4
						  return:R4
						  bg:white
						  tdscrollbar:true
						  glue:nswe)))
				    lrspace(glue:we width:20)))
		   tdspace(glue:ns width:20))
   StatusLabel

   Window = {QTk.build MainWindow}
   {P set(RequestView.spec)}
   {P set(ConsoleView.spec)}

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