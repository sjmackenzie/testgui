/*-------------------------------------------------------------------------
 *
 * Board.oz
 *
 *   A board is like a uni-directional channel. Only one component publish and
 *   the others subscribe to the board to receive the messages. 
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
 *    The idea of this board is the allow the composition of three or more
 *    components. If two components are connected, the triggering of the
 *    messages can be done directly. If you want that two or more components
 *    listen to the events triggered by another one, then you can build a
 *    Board, where one component publish messages, and the board triggers them
 *    in the list of subscribed components. A Board is a component itself, but
 *    it uses its own way of handling events, because it needs to handle 'any'
 *    event.
 *
 *-------------------------------------------------------------------------
 */

functor

export
   New 

define

   fun {New}
      Key
      Subscribers %% Dictionary of lists. Dictionary keys are tags
      BoardPort
      BoardStream
      
      %% Local proceduresto modify the state. Note that the component structure
      %% provides exclusive access to the state. There is no risk of race 
      %% conditions
      proc {AddSubscriber Client Tag}
         OldList
      in
         OldList = {Dictionary.condGet Subscribers Tag nil}
         Subscribers.Tag := Client|OldList
      end

      %% This is how other components will publish messages on the board
      proc {Publisher Msg}
         {Port.send BoardPort Msg}
      end

      proc {Subscriber Subscription}
         case Subscription
         of tagged(Client Tag) then
            {Port.send BoardPort subscribe(Key Client Tag)}
         [] Client then
            {Port.send BoardPort subscribe(Key Client notag)}
         end
      end

      %% Handle events for subscription and forward any other event to the
      %% subscribers
      proc {UponEvent BoardStream}
         case BoardStream
         of subscribe(!Key Client Tag)|NewStream then
            {AddSubscriber Client Tag}
            {UponEvent NewStream}
         [] AnyEvent|NewStream then
            TargetSubscribers
         in
            if {HasFeature AnyEvent tag} then
               SubsToTag = {Dictionary.condGet Subscribers AnyEvent.tag nil}
            in
               if SubsToTag == nil then
                  TargetSubscribers = Subscribers.notag
               else
                  TargetSubscribers = SubsToTag
               end
            else
               TargetSubscribers = Subscribers.notag
            end
            for Client in TargetSubscribers do
               {Client AnyEvent}
            end
            {UponEvent NewStream}
         [] nil then
            skip
         end
      end
   in
      Key         = {Name.new}
      Subscribers = {Dictionary.new}
      Subscribers.notag := nil
      BoardPort   = {Port.new BoardStream}
      thread
         {UponEvent BoardStream}
      end
      [Publisher Subscriber]
   end

end
