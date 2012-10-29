%TODO Handle pseudochars, octal, hex etc.

declare

fun {TokenizeDKL Str}
   case Str
   of nil then nil
   [] H|T then if {Char.isSpace H} orelse H==&\n then {TokenizeDKL T}
          else Rest in {NextToken Str Rest}|{TokenizeDKL Rest} end
   else raise errorInTokenizeDKL({String.toAtom Str}) end end
end

fun {NextToken Str Rest}
   case Str
  % of &=|&=|L then Rest=L '=='
  % [] &\\|&=|L then Rest=L '\\='
  % [] &=|&<|L then Rest=L '=<'
  % [] &>|&=|L then Rest=L '>='
  % [] &<|L then Rest=L '<'
  % [] &>|L then Rest=L '>'
  % [] &+|L then Rest=L '+'
  % [] &-|L then Rest=L '-'
  % [] &*|L then Rest=L '*'
  % [] &/|L then Rest=L '/'
  % [] &.|L then Rest=L '.'
   of &(|L then Rest=L '('
   [] &)|L then Rest=L ')'
   [] &{|L then Rest=L '{'
   [] &}|L then Rest=L '}'
   [] &=|L then Rest=L '='
   [] &$|L then Rest=L '$'
   [] &:|L then Rest=L ':'
   [] C|Cs then if {Char.isUpper C} then
         ident({String.toAtom C|{GetRestOfIdent Cs Rest}})
      elseif C==&` then
         ident({String.toAtom {GetRestOfMarkedIdent Cs Rest}})
      elseif {Char.isLower C} then
         AorK = {String.toAtom C|{GetRestOfAtomOrKeyword Cs Rest}}
      in if {IsKeyword AorK} then AorK
         elseif {IsBoolean AorK} then AorK
         else atom(AorK) end
      elseif C==&' then
         atom({String.toAtom {GetRestOfMarkedAtom Cs Rest}})
      elseif C==&" then
         string({GetRestOfString Cs Rest})
      elseif {Char.isDigit C} orelse C==&~ then
         {GetNumber Str Rest}
      else raise errorInNextToken({String.toAtom Str} Rest) end
      end
   end
end

fun {GetRestOfIdent Str Rest}
   case Str
   of nil then Rest = Str nil
   [] C|Cs then if {Char.isAlNum C} then C|{GetRestOfIdent Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end

fun {GetRestOfMarkedIdent Str Rest}
   case Str
   of &`|Cs then Rest = Cs nil
   [] C|Cs then if {IsVariableChar C} orelse {IsPseudoChar C}
      then C|{GetRestOfMarkedIdent Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end


fun {GetRestOfAtomOrKeyword Str Rest}
   case Str
   of nil then Rest = Str nil
   [] C|Cs then if {Char.isAlNum C} then C|{GetRestOfAtomOrKeyword Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end

fun {GetRestOfMarkedAtom Str Rest}
   case Str
   of &'|Cs then Rest = Cs nil
   [] C|Cs then if {IsAtomChar C} orelse {IsPseudoChar C}
      then C|{GetRestOfMarkedAtom Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end

fun {GetRestOfString Str Rest}
   case Str
   of &"|Cs then Rest = Cs nil
   [] C|Cs then if {IsStringChar C} orelse {IsPseudoChar C}
      then C|{GetRestOfString Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end

fun {GetNumber Str Rest}
   Num = {GetRestOfNumber Str Rest}
in
   if {String.isInt Num} then int({String.toInt Num})
   elseif {String.isFloat Num} then float({String.toFloat Num})
   end
end

fun {GetRestOfNumber Str Rest}
   case Str
   of nil then Rest = Str nil
   [] C|Cs then if C==&~ orelse C==&. orelse {IsDigit C} then
         C|{GetRestOfNumber Cs Rest}
      else Rest = Str nil
      end
   else Rest = Str nil
   end
end

fun {IsBoolean W}
   case W
   of 'true' then true
   [] 'false' then true
   else false
   end
end


fun {IsKeyword W}
   case W
   of 'if' then true
   [] 'then' then true
   [] 'else' then true
   [] 'case' then true
   [] 'of' then true
   [] 'end' then true
   [] 'local' then true
   [] 'in' then true
      [] 'proc' then true
   [] 'skip' then true
%   [] 'mod' then true
%   [] 'div' then true
   else false
   end
end

fun {IsVariableChar C}
   case C
   of &` then false
   [] &\\ then false
   [] 0 then false
   else if {Char.is C} then true else false end
   end
end

fun {IsAtomChar C}
   case C
   of &' then false
   [] &\\ then false
   [] 0 then false
   else if {Char.is C} then true else false end
   end
end

fun {IsStringChar C}
   case C
   of &" then false
   [] &\\ then false
   [] 0 then false
   else if {Char.is C} then true else false end
   end
end

fun {IsCharChar C}
   case C
   of &\\ then false
   [] 0 then false
   else if {Char.is C} then true else false end
   end
end

fun {IsPseudoChar C}
   false
end

fun {IsDigit C}
   case C
   of &0 then true
   [] &1 then true
   [] &2 then true
   [] &3 then true
   [] &4 then true
   [] &5 then true
   [] &6 then true
   [] &7 then true
   [] &8 then true
   [] &9 then true
   else false
   end
end

fun {IsNzDigit C}
   case C
   of &1 then true
   [] &2 then true
   [] &3 then true
   [] &4 then true
   [] &5 then true
   [] &6 then true
   [] &7 then true
   [] &8 then true
   [] &9 then true
   else false
   end
end

fun {IsOctDigit C}
   case C
   of &0 then true
   [] &1 then true
   [] &2 then true
   [] &3 then true
   [] &4 then true
   [] &5 then true
   [] &6 then true
   [] &7 then true
   else false
   end
end

fun {IsHexDigit C}
   case C
   of &a then true
   [] &b then true
   [] &c then true
   [] &d then true
   [] &e then true
   [] &f then true
   [] &A then true
   [] &B then true
   [] &C then true
   [] &D then true
   [] &E then true
   [] &F then true
   else if {IsDigit C} then true else false end
   end
end

fun {IsBinDigit C}
   case C
   of &0 then true
   [] &1 then true
   else false
   end
end

fun {GetText Filename}
   File={New Open.file init(name:Filename flags:[read])} in
   {File read(list:$ size:all)}
end
