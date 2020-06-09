#=
    magic
        Generate odd sized magic squares
        A function to generate odd sized magic squares
        Works only when n is odd
    Copyright © 2020 Julian Bustamante <jbustamante35@gmail.com>

    Distributed under terms of the MIT license.
=#

using LinearAlgebra, Statistics, Printf
export *

function magic(n::Int64)
	# Works exactly as Matlab's magic.m
        modn(x) = mod(x,n)

	if n % 2 == 1
		p = (1:n)
                y = broadcast(+, p', p .- div(n+3, 2))
                z = broadcast(+, p', 2p .- 2)
		M = n * modn.(y) + modn.(z) .+ 1
		return M

	elseif n % 4 == 0
		J = div([1:n] % 4, 2)
		K = J' .== J
		M = broadcast(+, [1:n:(n*n)]', [0:n-1])
		M[K] = n^2 + 1 - M[K]
		return M
	else
		p = div(n, 2)
		M = magic(p)
		M = [M M+2p^2; M+3p^2 M+p^2]
		if n == 2
			return M
		end
		i = (1:p)
		k = (n-2)/4
		j = convert(Array{Int}, [(1:k); ((n-k+2):n)])
		M[[i; i+p],j] = M[[i+p; i],j]
		i = k+1
		j = [1; i]
		M[[i; i+p],j] = M[[i+p; i],j]
		return M
	end
end

function magicshow(magicSquare)
    # Printing magic square
    #print ("Magic Squre for n =", n)
    #print ("Sum of each row or column",
    #        n * (n * n + 1) / 2, "\n")
    n = size(magicSquare)[1]
    for i in 1:n
        for j in 1:n
            @printf(" %d ", magicSquare[i,j])

            # To display output
            # in matrix form
            if j == n
                @printf("\n")
            end
        end
    end
end
