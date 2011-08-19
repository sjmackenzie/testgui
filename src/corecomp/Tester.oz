%% This file is meant to test the functionality of the functors implemented on
%% this module.

functor

import
   System
   Board       at 'Board.ozf'
   Component   at 'Component.ozf'

define
   
   fun {MakeSpeaker}
      FullComponent
      Listener
      proc {Say Event}
         say(Text) = Event
      in
         {@Listener listen(Text)}
      end
      Events = events(say: Say)
   in
      FullComponent = {Component.new Events}
      Listener = FullComponent.listener
      FullComponent.trigger
   end

   fun {MakeListener Id}
      proc {Listen Event}
         listen(Msg) = Event
      in
         {System.show Id#Msg}
      end
      Events = events(listen: Listen)
   in
      {Component.newTrigger Events}
   end

   Speaker
   Client1
   Client2
   Client3
   BoardA
   SubscriberA
   BoardB
   SubscriberB
in
   %% Initializing
   Speaker = {MakeSpeaker}
   Client1 = {MakeListener 1}
   Client2 = {MakeListener 2}
   Client3 = {MakeListener 3}
   [BoardA SubscriberA] = {Board.new}
   [BoardB SubscriberB] = {Board.new}
   %% Triggering some events and composing components
   {System.showInfo "Saying foo    to no subscribers"}
   {Speaker say(foo)}
   {System.showInfo "              set Client1 as listener"}
   {Speaker setListener(Client1)}
   {Delay 1000}
   {System.showInfo "Saying first  with Client1 as listener"}
   {Speaker say(first)}
   {System.showInfo "     boardA - subscribing Client2"}
   {SubscriberA Client2}
   {System.showInfo "              set BoardA as listener (Client2)"}
   {Speaker setListener(BoardA)}
   {Delay 1000}
   {System.showInfo "Saying second with BoardA (Client2) as listener"}
   {Speaker say(second)}
   {System.showInfo "     boardA - subscribing Client1"}
   {SubscriberA Client1}
   {Delay 1000}
   {System.showInfo "Saying third  with BoardA as listener (Client1 Clien2)"}
   {Speaker say(third)}
   {System.showInfo "              set BoardB as listener (empty)"}
   {Speaker setListener(BoardB)}
   {Delay 1000}
   {System.showInfo "Saying forth  with BoardA as listener (empty)"}
   {Speaker say(forth)}
   {System.showInfo "     boardB - subscribing Client3"}
   {SubscriberB Client3}
   {Delay 1000}
   {System.showInfo "Saying fifth  with BoardB as listener (Client3)"}
   {Speaker say(fifth)}
   {System.showInfo "     boardB - subscribing BoardA"}
   {SubscriberB BoardA}
   {Delay 1000}
   {System.showInfo "Saying sixth  with BoardB as listener (Client3 bA(C1 C2))"}
   {Speaker say(sixth)}
end 
