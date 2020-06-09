# -*- coding: utf-8 -*-
# vim:fenc=utf-8
## ---------------------------
## TestClass.R
##
## Author: Julian Bustamante
##
## Date Created: 2020-03-06
##

student <- setRefClass(
    "student",

    fields = list(
        name = "character",
        age  = "numeric",
        GPA  = "numeric"),

    methods = list(
        inc_age = function(x) {
            age <<- age + x
        },

        dec_age = function(x) {
            age <<- age - x
        }
    )
)
