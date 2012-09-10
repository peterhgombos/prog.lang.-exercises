declare
K = ["local" "in" "if" "then" "else" "end"]
O = ["+" "-" "*" "/" "=" "=="]

fun {Tokenize L}
   case L of nil then nil
   [] H|T then
      Token =
      if {Member H K} then key(H)
      elseif {Member H O} then op(H)
      else case H of C|_ then
          if C >= &a andthen C =< &z then atom(C)
	  elseif C >= &A andthen C =< &Z then id(C)
	  else nil
	  end
      end
      end in
      Token | {Tokenize T}
      end
end

