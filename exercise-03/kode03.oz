% Opggave 3a)
local Append in
    Append = proc { $ Xs Ys R? }
        case Xs of nil then
            R = Ys
        else
            case Xs of '|'(X Xr) then
                local Return in
                    Ret = {Append Xr Ys}
                    R = '|'(X Ret)
                end
            else % Må denne else-en være her?
                skip
            end
        end
    end
end
