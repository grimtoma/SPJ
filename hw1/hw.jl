using LinearAlgebra
using GraphRecipes
using Plots

"""
    polynomial(a, x)

Returns value of a polynomial with coefficients `a` at point `x`.
"""
function polynomial(a, x)
    if eltype(a) != Char
        accumulator = 0
        for (i,a_i) in enumerate(a)
            accumulator += x^(i-1) * a_i # ! 1-based indexing for arrays
        end
        return accumulator
    else
        throw(ArgumentError("Invalid coefficients $(a) of type Char!"))
    end
end

function polynomial(a, x::AbstractMatrix)
    accumulator = zeros(size(x))
    for (i,a_i) in enumerate(a)
        accumulator += x^(i-1) * a_i
    end
    return accumulator
end

function circlemat(n)
    A = zeros(n,n)
    A = [((i == j - 1)&&(j > 1))||((i == n)&&(j == 1)) ? 1 : ((i == j + 1)&&(j < n))||((i == 1)&&(j == n)) ? 1 : 0 for i in 1:n, j in 1:n]
    return A
end

A = x -> circlemat(x)


f = x -> I + A(x) + A(x)^2 + A(x)^3

A(10)
polynomial([1 1 1 1],A(10))

graphplot(A(10))
