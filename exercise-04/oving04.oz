% Task 2
declare
fun lazy {StreamMap S F}
    case S of nil then
        nil
    [] A|B then
        {F A} | {StreamMap B F}
    end
end

fun lazy {StreamZip S1 S2 F}
    case S1 of nil then
        nil
    [] A|B then
        {F A S2.1} | {StreamZip B S2.2 F}
    end
end

fun lazy {StreamScale SF Factor}
    local
        fun {MultiplyByFactor A}
            A*Factor
        end
    in
        {StreamMap SF MultiplyByFactor}
    end
end

fun lazy {StreamAdd S1 S2}
    local
        fun {Add A B}
            A+B
        end
    in
        {StreamZip S1 S2 Add}
    end
end

fun lazy {StreamIntegrate S InitValue Dt}
    case S of nil then
        nil
    [] A|B then
        InitValue | {StreamIntegrate B InitValue+A*Dt Dt}
    end
end

fun lazy {MakeRC R C Dt}
    local
        fun {RC SF V0}
            {StreamAdd
                {StreamIntegrate {StreamScale SF 1.0/C} V0 Dt}
                {StreamScale SF R}
            }
        end
    in
        RC
    end
end
