declare
fun {Max X Y}
   if X == 0 then
     Y
   else
      if Y == 0 then
	 X
      else
      1+{Max X-1 Y-1}
      end
   end
end