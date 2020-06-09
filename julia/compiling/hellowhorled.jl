#=
    HelloWhorled module
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#


module HelloWhorled

Base.@ccallable function julia_main(ARGS::Vector{String})::Cint
    println("hellow, whorled")
    @show sin(0.0)
    return 0
end
end
