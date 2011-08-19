/*-------------------------------------------------------------------------
 *
 * Component.oz
 *
 *    Provides a component creator with an asynchronous procedure to send
 *    messages to it.
 *
 * LICENSE
 *
 *    Beernet is released under the Beerware License (see file LICENSE) 
 * 
 * IDENTIFICATION 
 *
 *    Author: Boriss Mejias <boriss.mejias@uclouvain.be>
 *
 *    Last change: $Revision: 403 $ $Author: boriss $
 *
 *    $Date: 2011-05-19 21:45:21 +0200 (Thu, 19 May 2011) $
 *
 * NOTES
 *      
 *    This is a module with a very basic event-driven component model. To
 *    create a component, the programmer has to provide a set of events and
 *    the representation of the state. Both are tuples. The component has a
 *    port as input mechanism. It runs on its own light thread and loops over
 *    the stream associated to the port. Every message received is an event to
 *    handle using the state as extra parameter.
 *
 *-------------------------------------------------------------------------
 */

functor

import
   System

export
   New
   NewTrigger
   Dummy

define

   %% New returns a record with the procedure to trigger events on it,
   %% which is equivalent to a regular component. But it also include a field
   %% with the default listener
   fun {New Events}
      CarryOn        % Status of the object
      CompPort       % Receive events from other components
      CompListener   % Default component to trigger messages

      %% This is the way to trigger an event on a component. It just send a
      %% message using the port. It is an asynchronous procedure.
      proc {Trigger Msg}
         {Port.send CompPort Msg}
      end

      proc {Killer}
         CarryOn := _
      end

      %% Loop through the EventStream. Every event is handle with the state as
      %% extra parameter and a new state is returned.
      proc {UponEvent EventStream}
         {Wait @CarryOn}
         case EventStream
         of Event|NewStream then
            EventName = {Label Event}
         in
            try
               {Events.EventName Event} % Handle the event
               {UponEvent NewStream} % Loop for new events
            catch error(kernel('.' events(...) _) debug:_) then
               %% Use default events
               case Event
               of setListener(NewListener) then
                  CompListener := NewListener
                  {UponEvent NewStream} % Loop for new events
               [] signalDestroy then % Ends the loop
                  skip
               else
                  %% Use the any event if it is implemented
                  try
                     {Events.any Event}
                  catch error(kernel('.' events(...) _) debug:_) then
                     {System.show '#'('Unknown event' Event
                                      'Possible events' {Arity Events})}
                  [] E then
                     raise E end
                  end
                  {UponEvent NewStream} % Loop for new events
               end
            [] E then
               raise E end
            end
         [] nil then %% Component close
            skip
         end
      end

   in
      local
         CompStream
      in
         {Port.new CompStream CompPort}
         thread 
            {UponEvent CompStream}
         end
      end
      CarryOn     = {NewCell unit}
      CompListener= {NewCell Dummy} 

      component(trigger:Trigger
                listener:CompListener
                killer:Killer)
   end

   %% This is the function to use if you do not want to use the default
   %% Listener of the full component.
   fun {NewTrigger Events}
      FullComponent
   in
      FullComponent = {New Events}
      FullComponent.trigger
   end

   %% This component is useful when you want to discard events triggered by
   %% another component
   proc {Dummy _}
      skip
   end
end
