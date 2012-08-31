declare
fun {SumTo FirstInteger LastInteger}
   if FirstInteger == LastInteger then
      1
   else
      1+{SumTo FirstInteger+1 LastInteger}
   end
end

