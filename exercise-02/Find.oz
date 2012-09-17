\insert 'List.oz'

declare

fun {Find Xs Ys} 
    case Xs of nil then
        nil 
    [] Y | Yrest then Hs Ts in
        Hs#Ts = {SplitTrain Xs Y}
        trackA({Position Xs Y}) |
        trackB({Length Xs} - {Position Xs Y}) |
        trackA(~{Position Xs Y}) |
        trackB(~({Length Xs} - {Position Xs Y})) |
        {Find {Append Ts Hs} Yrest}
    end 
end

fun {SplitTrain Xs Y}
    {Take Xs {Position Xs Y}-1}#{Drop Xs {Position Xs Y}}
end

{Show {Find [a b] [b a]}}
