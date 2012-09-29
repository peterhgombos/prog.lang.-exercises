% Opggave 3a)
local Append in
    Append = proc { $ Xs Ys ?R }
        case Xs of nil then
            R = Ys
        else
            case Xs of '|'(X Xr) then
                local Return in
                    {Append Xr Ys Return}
                    R = '|'(X Return)
                end
            else % Må denne else-en være her?
                skip
            end
        end
    end
end

% Oppgave 3b)
local Max in
    Max = proc { $ N M ?R }
        local NIsZero in
            {Equals N 0 NIsZero}
            if NIsZero then
                R = M
            else
                local MIsZero in
                    {Equals M 0 MIsZero}
                    if MIsZero then
                        R = N
                    else
                        local NN in
                            local NM in
                                local Return in
                                    {Minus N 1 NN}
                                    {Minus M 1 NM}
                                    {Max NN NM Return}
                                    {Plus Return 1 R}
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
