% Opggave 3a)
local Append in
    Append = proc { $ Xs Ys }
        case Xs of nil then
            Ys % Tror muligens ikke Ys alene er lovlig i denne oppgaven, men finner ikke ut noe annet å skrive
        else
            case Xs of '|'(X Xr) then
                local Return in
                    Return = {Append Xr Ys}
                    '|'(X Return) % Se forrige kommentar
                end
            else
                skip % Usikker på om dette må være her
            end
        end
    end
end
