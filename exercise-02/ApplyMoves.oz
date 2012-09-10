\insert 'List.oz'

declare

fun {ApplyMoves State Moves}
   case Moves of trackA(N)|MovesRest then
      if N > 0 then
	 State|{ApplyMoves state(main: {Take State.main {Length State.main} - N} trackA: {Append {Drop State.main {Length State.main} - N} State.trackA} trackB: State.trackB) MovesRest}
      elseif N < 0 then
	 State|{ApplyMoves state(main: {Append State.main {Take State.trackA N}} trackA: {Drop State.trackA N}  trackB: State.trackB) MovesRest}
      else
	 State|{ApplyMoves State MovesRest}
      end
   [] trackB(N)|MovesRest then
      if N > 0 then
	 State|{ApplyMoves state(main: {Take State.main {Length State.main} - N} trackA: State.trackA trackB: {Append {Drop State.main {Length State.main} - N} State.trackB}) MovesRest}
      elseif N < 0 then
	 State|{ApplyMoves state(main: {Append State.main {Take State.trackB N}} trackA: State.trackA trackB: {Drop State.trackB N}) MovesRest}
      else
	 State|{ApplyMoves State MovesRest}
      end
   else State
   end
end

{Show {ApplyMoves state(main:[a b] trackA:nil trackB:nil) [trackA(1) trackB(1) trackA(~1)]}} 
