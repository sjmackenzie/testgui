%% This file is meant to test the functionality of the functors implemented on
%% this module.

functor

import
   Application
   System
   Player      at '../network/TestPlayers.ozf'
   Logger      at 'Logger.ozf'

define

   fun {NewLogListener}
      S P
      proc {Obj Msg}
         case Msg
         of release then
            {System.show 'going to release'#S}
            for X in S do
               {System.show X}
            end
         else
            {Port.send P Msg}
         end
      end
   in
      {NewPort S P}
      Obj
   end

in

   local
      SiteA
      SiteB
      Finish
      ThisLogger
      LogListener
      ThisCloser
      ThisSetListener
   in
      SiteA       = {Player.makeNetworkPingPongPlayer}
      SiteB       = {Player.makeNetworkPingPongPlayer}
      log(logger:ThisLogger
          close:ThisCloser
          setListener:ThisSetListener) = {Logger.new 'none.log'}
      {System.show 'after creating this logger'}
      LogListener = {NewLogListener}
      {System.show 'after creating log listener'}
      {ThisSetListener LogListener}
      {System.show 'after setting loglistener'}
      {SiteA setId(netfoo)}
      {SiteB setId(netbar)}
      {SiteA setFlag(Finish)}
      {SiteB setFlag(Finish)}
      {SiteA setLogger(ThisLogger)}
      {SiteB setLogger(ThisLogger)}
      {System.show 'ready to start'}
      {System.show 'starting NetworkPinPong test'}
      {SiteB setOtherPlayer({SiteA getRef($)})}
      {SiteA initPing(10 {SiteB getRef($)})}
      {Wait Finish}
      {System.show 'no more waiting'}
      {System.show 'finishing NetworkPingPong'}
      {System.show 'letting the log listener do its job'}
      {LogListener release}
      {ThisCloser}
      {System.show 'check also file test.log'}
   end
   {Application.exit 1}
end
