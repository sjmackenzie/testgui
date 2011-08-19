functor
import
   Application
   Property
   System
   BaseArgs    at '../lib/tools/BaseArgs.ozf'
   Bootstrap   at '../lib/tools/Bootstrap.ozf'
define

   Say = System.showInfo
   Args

   proc {HelpMessage}
      {Say "Usage: "#{Property.get 'application.url'}#" <subcommand> [options]"}
      {Say ""}
      {Say '#'("Type '"#{Property.get 'application.url'}#" help <subcommand>' "
               "for help on a specific subcommand.")}
      {Say ""}
      {Say "Available subcommands:"}
      for SubCmd in {Record.arity Subcommands} do
         {Say "   "#SubCmd}
      end
      {Say ""}
   end

   proc {ErrorMsg Msg}
      {Say "----------------------------------------------------"}
      {Say "ERROR: "#Msg}
      {Say ""}
      {HelpMessage}
      {Application.exit 0}
   end

   proc {ThisHelpRun _/*Args*/}
      {HelpMessage}
      {Application.exit 0}
   end

   fun {BuildDefSubCmdArgs Defs}
      fun {Loop SubCmds Acc}
         case SubCmds
         of SubCmd|MoreCmds then
            NewAcc = {BaseArgs.mergeArgs Defs.SubCmd.defArgs Acc}
         in
            {Loop MoreCmds NewAcc}
         [] nil then
            Acc
         end
      end
   in
      {Loop {Record.arity Defs} nil}
   end

   Subcommands = subcmds(bootstrap: Bootstrap
                         help:      rec(defArgs:nil
                                        run:ThisHelpRun))
in

   {Property.put 'print.width' 1000}
   {Property.put 'print.depth' 1000}

   %% Defining input arguments
   Args = {BaseArgs.getArgs {BuildDefSubCmdArgs Subcommands}}

   %% Help message
   if Args.help then
      {HelpMessage}
      {Application.exit 0}
   end

   case Args.1
   of Subcmd|MoreArgs then
      case Subcmd
      of "help" then
         case MoreArgs
         of Subcmd|nil then
            SubCommand = {String.toAtom Subcmd}
         in
            try
               {Subcommands.SubCommand.run optRec(help:true)}
            catch _ then
               {ErrorMsg "Wrong subcommand."}
            end
         else
            {ErrorMsg "Wrong invocation."}
         end
      else
         SubCommand = {String.toAtom Subcmd}
         Run
      in
         Run = try
                  Subcommands.SubCommand
               catch _ then
                  error(run:proc {$ _}
                               {ErrorMsg SubCommand#" is a wrong subcommand."}
                            end)
               end
         {Run.run Args}
      end
   else
      {ErrorMsg "ERROR: Wrong invocation."}
   end

end
