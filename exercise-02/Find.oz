\insert 'List.oz'

declare

fun {Find Xs Ys}
    case Ys of nil then
        nil
    [] Y | Yrest then Hs Ts in
        Hs#Ts = {SplitTrain Xs Y}
        trackA({Length Ts}+1) | trackB({Length Hs}) | trackA(~({Length Ts}+1)) | trackB(~{Length Hs}) | {Find {Append Ts Hs} Yrest}
    end
end

fun {SplitTrain Xs Y}
    {Take Xs {Position Xs Y}-1}#{Drop Xs {Position Xs Y}}
end

{Show {Find [a b] [b a]}}
