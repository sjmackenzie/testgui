functor
import
   Application
   Education at 'Education.ozf'
   PackageFlow at 'PackageFlow.ozf'
   Needs at 'Needs.ozf'
   Request at 'Request.ozf'
   Console at 'Console.ozf'
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

   Data=[name#"Roger"
	 surname#"Rabbit"
	 age#14]

   L1 R1 L2 R2 L3 R3 L4 R4
   TextHandle TR
   InputHandle IR
   P C
   ConsoleView={Console.console_view Data}
   RequestView={Request.request_view Data}
   MainWindow = lr(title:"Handpassed - a resource based economy"
		   tdspace(glue:ns width:20)
		   tdrubberframe(glue:nswe
				 td(glue:nswe
				    lrspace(glue:we width:10)
				    label(handle: StatusLabel glue:nwe)
				    lrspace(glue:we width:10)
				    lr(glue:we
				       button(text:"Make a Request"
					      action:RequestItem
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Share Something"
					      action:ShareItem
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Post a Package"
					      action:PostItem
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Give a class"
					      action:GiveClass
					      glue:nwe)
				       tdspace(glue:ns width:5)
				       button(text:"Locations"
					      action:ManageLocations
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
						   glue:we)
					     tdspace(glue:ns width:5)
					     button(text:"send"
						    glue:e
						    action:proc{$} {TextHandle insert('end' {Console.input {String.toAtom {InputHandle get($)}}})} end))))
				    tdspace(glue:we width:5))
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
				    lrspace(glue:we width:20)))
		   tdspace(glue:ns width:20))
   StatusLabel

   Window = {QTk.build MainWindow}
   {P set(RequestView.spec)}
   {P set(ConsoleView.spec)}

   fun {InsertText Text}
      {TextHandle insert('end'{Console.input Text})}
   end

   proc {RequestItem}
      {TextHandle insert('end' "\nWhat do you wish to request form the community?")}
   end

   proc {ShareItem}
      {TextHandle insert('end' "\nWhat do you wish to share with the community?")}
   end

   proc {PostItem}
      {TextHandle insert('end' "\nTo whom would you like to post this package?")}
   end

   proc {GiveClass}
      {TextHandle insert('end' "\nBased on the needs of the people which class would you like to give?")}
   end

   proc {ManageLocations}
      {TextHandle insert('end' "\nWould you like to add a location?")}
   end

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