local
   fun {InLanguage? Tokens}
      try {A Tokens nil} catch _ then false end
   end
   fun {A Tok RemTok}
      case Tok
      of a|RTok then {A RTok d|RemTok}
      [] x|RTok then RTok2 in {B RTok x|RTok2} andthen {B RTok2 RemTok}
      else false
      end
   end
   fun {B Tok RemTok}
      case Tok
      of b|RTok then {B RTok c|RemTok}
      else RemTok = Tok true
      end
   end
in
   {Show {InLanguage? [a x b c x d] }} %% Insert own string here!
end
