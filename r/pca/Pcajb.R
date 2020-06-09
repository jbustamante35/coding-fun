# -*- coding: utf-8 -*-
# vim:fenc=utf-8
## ---------------------------
## Pcajb.R
## Purpose of script:
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
##
##
## ---------------------------
library('pracma')

Pcajb <- setRefClass(
    # Class name
    "Pcajb",

    # Slots
    fields = list(
        Data = "matrix",
        npc  = "numeric"
    ),

    # Methods
    methods = list(
        meanSubtract = function() {
            x = Data
            u = colMeans(x)
            M = x - u
            Mu <- list(M,u)
            return(Mu)
        },

        covarMatrix = function() {
            mu = meanSubtract()
            m  = Reshape(unlist(mu[1]), size(Data,1), size(Data,2))
            c  = t(m) * m / size(m,1)
            return(c)
        },

        eigens = function(neigs=0) {
            if (neigs == 0) {
                 neigs = npc
            }

            c  = covarMatrix()
            mu = meanSubtract()
            wv = eigen(c)
            w  = Reshape(unlist(wv[1]), 1, size(Data,1))
            v  = Reshape(unlist(wv[2]), size(Data,1), size(Data,2))
            w  = w[1:neigs]
            v  = v[,1:neigs]
            wv = list(w,v)
            return(wv)
        },

        PCAScores = function(ndims=0,neigs=0) {
             if (ndims == 0) {
                 ndims = 1:size(Data,1)
             }

             if (neigs == 0) {
                 neigs = npc
             }

            x  = Data[ndims,]
            mu = meanSubtract()
            wv = eigens(neigs)

            u  = Reshape(unlist(mu[2]), 1, size(Data,2))
            v  = Reshape(unlist(wv[2]), size(Data,1), neigs)
            s  = pcaProject(x,v,u,'sim2scr')
            return(s)
        },

        SimData = function(ndims=0,neigs=0) {
             if (ndims == 0) {
                 ndims = 1:size(Data,1)
             }

             if (neigs == 0) {
                 neigs = npc
             }

            mu = meanSubtract()
            wv = eigens(neigs)
            s  = PCAScores(ndims,neigs)

            u  = Reshape(unlist(mu[2]), 1, size(Data,2))
            v  = Reshape(unlist(wv[2]), size(Data,1), neigs)
            xx = pcaProject(s,v,u,'scr2sim')
            return(xx)
        },

        VarExplained = function(pct=0,neigs=0) {
            if (pct == 0) {
                pca = 1.0
            }

            if (neigs == 0) {
                neigs = npc
            }

            wv = eigens(neigs)
            w  = Reshape(unlist(wv[1]), 1, neigs)
            V  = cumsum(w / sum(w))
            T  = length(V[V <= pct]) + 1
            VT = list(V,T)
            return(VT)
        },

        pcaProject = function(x,v,u,req) {
            if (req == 'scr2sim') {
                m = x %*% t(v)
                return(m + c(u))

            } else if (req == 'sim2scr') {
                m = x - c(u)
                return(m %*% v)

            } else {
                return("Invalid projection")
            }
        }
    )
)
