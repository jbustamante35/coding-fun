# -*- coding: utf-8 -*-
# vim:fenc=utf-8
## ---------------------------
## testpca.R
##
## Author: Julian Bustamante
##
## Date Created: 2020-03-05
##
## Copyright (c) Julian Bustamante, 2020
## Email: <jbustamante35@gmail.com>
##
## Distributed under terms of the MIT license.
##
## ---------------------------
##
## Notes:
##      Use my custom PCA class
##
## ---------------------------

setwd("/home/jbustamante/Dropbox/ComputerProgramming/programminglanguages/r/pca")
library('pracma')
source('Pcajb.R')

N  = 99
n  = 3
x  = magic(N)
px = Pcajb(Data=x, npc=n)

#mu = px$meanSubtract()
#m  = Reshape(unlist(mu[1]), size(x,1), size(x,2))
#u  = Reshape(unlist(mu[2]), 1, size(x,2))
#
#cv = px$covarMatrix()
#
#wv = px$eigens(n)
#w  = Reshape(unlist(wv[1]), 1, n)
#v  = Reshape(unlist(wv[2]), N, n)
#
#s = px$PCAScores()
z = px$SimData()

plot.new()
image(x)
#image(z)



