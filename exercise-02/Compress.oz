declare

fun {ApplyRules Ms}
    case Ms of nil then
        nil
    [] trackA(N) | trackA(M) | Ns then
        trackA(N+M) | {ApplyRules Ns}
    [] trackB(N) | trackB(M) | Ns then
        trackB(N+M) | {ApplyRules Ns}
    [] trackA(0) | Ns then
        {ApplyRules Ns}
    [] trackB(0) | Ns then
        {ApplyRules Ns}
    [] M | Ns then
        M | {ApplyRules Ns}
    end
end

fun {Compress Ms}
    Ns = {ApplyRules Ms}
    in
    if Ns == Ms then
       Ns
    else
       {Compress Ns}
    end
end

{Show {Compress [trackB(1) trackA(~1) trackA(1) trackB(~1)]}}
