#=
    SimpleModule module
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#

module SimpleModule

#using Printf

export sphere_vol, quadratic2, vol

function sphere_vol(r)

    return 4/3 * pi * r^3
end

function quadratic(a, sqr_term, b)
    return (-b + sqr_term) / 2a
end

function quadratic2(a::Float64, b::Float64, c::Float64)
    sqr_term = sqrt(b^2 - 4a * c)
    r1 = quadratic(a, sqr_term, b)
    r2 = quadratic(a, -sqr_term, b)

    r1,r2
end

end
