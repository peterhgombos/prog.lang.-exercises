\insert 'List.oz'
% We need SplitTrain from FewFind.oz
\insert 'FewFind.oz'

declare

fun {FewerFind Ms Os Ts Ys}
    case Ys of nil then
        nil
    [] Y | Yrest then
        if {Member Ms Y} then
            if Y == Ms.1 then
                {FewerFind Ms.2 Os Ts Yrest}
            else
                As Bs in
                As#Bs = {SplitTrain Ms Y}
                trackA({Length Bs}+1) | trackB({Length As}) | trackA(~1) | {FewerFind nil {Append Bs Os} {Append As Ts} Yrest}
            end
        elseif {Member Os Y} then As Bs in
            As#Bs = {SplitTrain Os Y}
            trackA(~{Length As}) | trackB({Length As}) | trackA(~1) | {FewerFind nil Bs {Append As Ts} Yrest}
        else As Bs in
            % We assume the cart is in track B
            As#Bs = {SplitTrain Ts Y}
            trackB(~{Length As}) | trackA({Length As}) | trackB(~1) | {FewerFind nil {Append As Os} Bs Yrest}
        end
    end
end

{Show {FewerFind [a b] nil nil [b a]}}
