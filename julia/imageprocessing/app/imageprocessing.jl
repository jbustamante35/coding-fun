#=
    ImageProcessing module
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#

module ImageProcessing

using Images,  ImageView, ImageInTerminal

Base.@ccallable function julia_main(ARGS::Vector{String})::Cint

    imgdir   = "/home/jbustamante/Dropbox/ComputerProgramming/programminglanguages/julia/imageprocessing/examples/"
    # imgpik = "cry1_BL_smaller.gif"
    # imgpik = "WT_BL_full_smaller.gif"
    imgpik   = "WT_Blue_t72.png"
    imgpth   = string(imgdir, imgpik)
    img      = load(imgpth)

    # View Image
    iv = ImageView
    iv.imshow(img)
    sleep(5)
    iv.closeall

    return 0
end

end
