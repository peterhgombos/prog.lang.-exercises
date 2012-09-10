\insert 'List.oz'

declare

fun {ApplyMoves State Moves}
   case Moves of trackA(N)|MovesRest then
      if N > 0 then
	 State|{ApplyMoves state(main: {Take State.main {Length State.main} - N} trackA: {Append {Drop State.main {Length State.main} - N} State.trackA} trackB: State.trackB) MovesRest}
      elseif N < 0 then
	 State|{ApplyMoves state(main: {Take State.main {Length State.main} - N} trackA: {Append {Drop State.main {Length State.main} - N} State.trackA} trackB: State.trackB) MovesRest}
      else
	 State|{ApplyMoves State MovesRest}
      end
   [] trackB(N)|MovesRest then
      State|{ApplyMoves TransformedState MovesRest}
   else nil
   end
end

{Show {ApplyMoves state(main:[a b] trackA:nil trackB:nil) [trackA(2) trackB(3) two(5)]}} 

