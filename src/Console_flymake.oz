functor
import
export
   'input':Input
define
   fun {Input Text}
      case Text
      of clear then
	 clear
      [] _ then Text
      end
   end

   fun {Widget Data}

   in
      r( spec: {

end