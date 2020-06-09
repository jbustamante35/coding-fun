# -*- coding: utf-8 -*-
# vim:fenc=utf-8
## ---------------------------
## comparePandemics.R
##
## Author: Julian Bustamante
##
## Date Created: 2020-03-21
##
## Copyright (c) Julian Bustamante, 2020
## Email: <jbustamante35@gmail.com>
##
## Distributed under terms of the MIT license.
##
## ---------------------------
##
## Notes:
##  Compare deaths and death rates from this century's pandemics with each other
##
## ---------------------------

setwd("/home/jbustamante/Dropbox/ComputerProgramming/programminglanguages/r/covid19/pandemiccomparisons/")

D = read.csv("disease_deaths.csv", sep = ",", header = TRUE)
