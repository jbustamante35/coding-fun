#=
    Main
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#

#include("./SimpleModule.jl")
#using .SimpleModule
using SimpleModule

vol         = sphere_vol(3)
quad1,quad2 = quadratic2(2.0, -2.0, -12.0)

println("Vol: "  , vol)
println("Quad1: ", quad1)
println("Quad2: ", quad2)
