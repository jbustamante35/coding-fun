#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 Julian Bustamante <jbustamante35@gmail.com>
#
# Distributed under terms of the MIT license.

"""
Use my Pcajb class
"""
from magic import *
from Pcajb import Pcajb
import matplotlib.pyplot as plt

N   = 99
nx  = 3
#sel = [0,2,4]
sel = np.arange(0,N)
X   = np.array(magic(N))
Z   = np.append(X, X[0,:]).reshape(N+1, N)
px  = Pcajb(Z,nx)

x   = px.Data
#m,u = px.meanSubtract()
#c   = px.covarMatrix()
#e,v = px.eigens()
#s   = px.PCAScores(sel)
#V,T = px.VarExplained(0.8)
xx  = px.SimData()

#print(np.shape(xx))
#print(xx)
#print(np.shape(x))
#print(x)
#print(V)
#print(T)
#plt.scatter(x[:,1], xx[:,1])
fig,axs = plt.subplots(1,2, constrained_layout=True)
axs[0].imshow(x)
ttl = 'Input Data\n[%d N | %d mag | %d nx]' % (np.shape(Z)[0],N,nx)
axs[0].set_title(ttl)
axs[1].imshow(xx)
ttl = "Simulated Data\n[%d PCs]" % (nx)
axs[1].set_title(ttl)
plt.show()
