declare
local
Radius Area Diameter
% Circle is defined for floats (by design)
proc {Circle R}
   Radius = R
   Area = 3.14159265*R*R
   Diameter = 2.0*R
end

in

{Circle 1.0}
{Show Radius}
{Show Area}
{Show Diameter}

end