#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 Julian Bustamante <jbustamante35@gmail.com>
#
# Distributed under terms of the MIT license.

"""
My custom PCA class

"""

import numpy as np
from numpy import linalg as la
from magic import *

class Pcajb:
    def __init__(self, data, npc):
        self.Data        = np.array(data)
        self.NumberOfPCs = npc

    def meanSubtract(self):
        X = self.Data
        u = np.mean(X, axis=0)
        M = np.array(np.subtract(X,u))
        return M,u

    def covarMatrix(self):
        M,u = self.meanSubtract()
        npc = self.NumberOfPCs

        C = np.array(np.dot(np.transpose(M), M) / np.shape(M)[0])
        return C

    def eigens(self, neigs=None):
        if neigs is None:
            neigs = self.NumberOfPCs

        C   = self.covarMatrix()
        w,v = la.eig(C)
        return np.array(w[0:neigs]),np.array(v[:,0:neigs])

    def PCAScores(self, ndims=None, neigs=None):
        if ndims is None:
            sz    = np.shape(self.Data)
            ndims = np.arange(0, sz[0])

        if neigs is None:
            neigs = self.NumberOfPCs

        X   = self.Data[ndims,:]
        M,u = self.meanSubtract()
        w,v = self.eigens(neigs)
        return np.array(self.pcaProject(X,v,u,'sim2scr'))

    def SimData(self, ndims=None, neigs=None):
        if ndims is None:
            sz    = np.shape(self.Data)
            ndims = np.arange(0, sz[0])

        if neigs is None:
            neigs = self.NumberOfPCs

        M,u = self.meanSubtract()
        S   = self.PCAScores(ndims,neigs)
        w,v = self.eigens(neigs)
        return np.array(self.pcaProject(S,v,u,'scr2sim'))

    def VarExplained(self, pct=None, neigs=None):
        if pct is None:
            pct = 1.0

        if neigs is None:
            neigs = self.NumberOfPCs

        w,v = self.eigens(neigs)
        V   = np.array(np.cumsum(w / sum(w)))
        T   = V[V <= pct].size + 1
        return V,T

    def pcaProject(self,X,v,u,req):
        if req == 'scr2sim':
            return np.array(np.dot(X,np.transpose(v)) + u)

        elif req == 'sim2scr':
            return np.array(np.dot(X - u,v))

        else:
            return "Invalid projection"
