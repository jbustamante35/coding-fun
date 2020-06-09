classdef SimpleCylinder
    properties
        R
        Height
    end
    
    methods
        function V = volume(C)
            V = pi .* [C.R].^2 .* [C.Height];
        end
    end
end