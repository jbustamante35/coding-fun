# -*- coding: utf-8 -*-
# vim:fenc=utf-8
## ---------------------------
## pokemon_team_builder.R
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
##  Analyze Pokemon stats using database
##
## ---------------------------
setwd("/home/jbustamante/Dropbox/ComputerProgramming/programminglanguages/r/pokemon")
P     = read.csv("pokemon.tsv", sep = "\t", header = TRUE)
eIdxs = which("" == P$Type_2)

