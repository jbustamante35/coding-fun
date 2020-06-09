#=
imageprocessing: practice functions for image processing and machine vision
Following various tutorials, but starting with https://juliaimages.org/latest/
and using the Images package (https://github.com/JuliaImages/Images.jl), the
ImageView package (https://github.com/JuliaImages/ImageView.jl), the
ImageInTerminal package (https://github.com/JuliaImages/ImageInTerminal.jl),
and finally the TestImages package
(https://github.com/JuliaImages/TestImages.jl).


IMPORTANT: Be sure to have the ImageMagick package installed!

To install the image processing packages, run the following:
```
    using Pkg
    Pkg.add("Images" , "ImageView" , "ImageInTerminal" , "TestImages"])
```

And then test it out with:
```
    using Gtk, ImageMagick, FileIO, Images, ImageView, TestImages, ImageInTerminal
    imgdir   = "/home/jbustamante/Dropbox/ComputerProgramming/programminglanguages/julia/imageprocessing/examples/"
    # imgpik = "cry1_BL_smaller.gif"
    # imgpik = "WT_BL_full_smaller.gif"
    imgpik   = "WT_Blue_t72.png"
    imgpth   = string(imgdir, imgpik)
    img      = load(imgpth)
```

Copyright © 2020 Julian Bustamante <jbustamante35@gmail.com>
Distributed under terms of the MIT license.
=#

#using Gtk, ImageMagick, Images, ImageView, TestImages, ImageInTerminal
#using Images, ImageView, TestImages, ImageInTerminal
using Images,  ImageView, ImageInTerminal
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




