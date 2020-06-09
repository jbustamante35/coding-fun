classdef SlowCylinder
    properties
        R
        Height
    end
    methods
        function V = volume(C)
            V = pi .* [C.R].^2 .* [C.Height];
        end
        
        function C = set.R(C, R)
            checkValue(R);
            C.R = R;
        end
        
        function C = set.Height(C, Height)
            checkValue(Height);
            C.Height = Height;
        end
    end
end

function checkValue(x)
    if ~isa(x, 'double') || ~isscalar(x)
        error('value must be a scalar double.');
    end
end

