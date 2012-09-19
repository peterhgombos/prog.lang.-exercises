\insert 'List.oz'

declare

fun {FewFind Xs Ys}
    case Ys of nil then
        nil
    [] Y | Yrest then Hs Ts in
        if Xs.1 == Y then
            {FewFind Ts Yrest}
        else
            Hs#Ts = {SplitTrain Xs Y}
            trackA({Length Ts}+1) | trackB({Length Hs}) | trackA(~({Length Ts}+1)) | trackB(~{Length Hs}) | {FewFind {Append Ts Hs} Yrest}
        end
    end
end

fun {SplitTrain Xs Y}
    {Take Xs {Position Xs Y}-1}#{Drop Xs {Position Xs Y}}
end

{Show {FewFind [a b] [b a]}}
