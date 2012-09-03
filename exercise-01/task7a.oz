declare 
fun {Length Xs}
   case Xs of nil then 0

   [] H|T then 1+{Length T}
   end
end


fun {Take Xs N}
   if N == 0 then
      nil
   else
   if N >= {Length Xs} then
      Xs
   else
      case Xs of nil then nil
      [] H|T then H|{Take T N-1}
      end
   end
   end
end

fun {Drop Xs N}
   if N == 0 then
      Xs
   else
   if N >= {Length Xs} then
      nil
   else
      case Xs of nil then nil
      [] H|T then {Drop T N-1}
      end
   end
   end
end

fun {Append Xs Ys}
   if Xs == nil then
      Ys
   else
      case Xs of nil then nil
      [] H|T then H|{Append Xs T}
      end
   end
end

fun {Member Xs Y}
   if Xs.1 == nil then
      false
   elseif Y == Xs.1 then
      true
   else
      case Xs of nil then nil
      [] H|T then H|{Member Xs T}
      end
   end
end

{Show {Append [1 2] [3 4]}}
{Show {Append [1 2 3 4 5] [10 11 12 13 14 15]}}

{Show {Member [1 2 3 4] 1}}
{Show {Member [1 2 3 4] 5}}