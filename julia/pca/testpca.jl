#=
    testpca
    Test out my Pcajb module
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#

include("Pcajb.jl")
include("magic.jl")
using Plots, ImageView
using .Pcajb

# Set initial data
x = magic(99)
n = 3

# Run the pipeline
xx = SimData(x,0,n)

# Show results
plot(x[:,1], xx[:,1])
sleep(5)
