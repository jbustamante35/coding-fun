#=
    pca function
    Copyright © 2020 jbustamante <jbustamante@wisc.edu>

    Distributed under terms of the MIT license.
=#

module Pcajb
using LinearAlgebra, Statistics, Printf
export meanSubtract,covarMatrix,eigens,PCAScores,SimData,VarExplained

function meanSubtract(X::Array)
    u = mean(X, dims=1)
    M = X .- u
    M,u
end

function covarMatrix(X)
    M,u = meanSubtract(X)
    C   = (M' * M) / size(M,1)
    return C
end

function eigens(X, neigs)
    if neigs == 0
        neigs = size(X)[2]
    end

    C = covarMatrix(X)
    w = eigvals(C)
    v = eigvecs(C)

    w[1:neigs],v[:,1:neigs]
end

function PCAScores(X, ndims=0, neigs=0)
    if ndims == 0
        ndims = 1 : size(X)[1]
    end

    if neigs == 0
        neigs = size(X)[2]
    end

    X   = X[ndims,:]
    M,u = meanSubtract(X)
    w,v = eigens(X, neigs)
    S   = (X .- u) * v
    return S
end

function SimData(X, ndims=0, neigs=0)
    if ndims == 0
        ndims = 1 : size(X)[1]
    end

    if neigs == 0
        neigs = size(X)[2]
    end

    M,u = meanSubtract(X)
    w,v = eigens(X,neigs)
    S   = PCAScores(X[ndims,:],0,neigs)
    XX  = (S * v') .+ u
    return XX
end

function VarExplained(X, pct=0, neigs=0)
    if pct == 0
        pct = 1.0
    end

    if neigs == 0
        neigs = size(X)[2]
    end

    w,v = eigens(X,neigs)
    V   = cumsum(w / sum(w))
    T   = length(V[V .<= pct]) + 1

    V,T
end

function pcaProject(X, v, u, req::String)
    if req == "scr2sim"
        S = (X * v') .+ u
    elseif req == "sim2scr"
        S = (X .- u) * v
    else
        @printf("Error evaluating request %F\n", req)
        return
    end

    return S
end

end
