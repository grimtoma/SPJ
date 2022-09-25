"""
    polynomial(a, x)

Returns value of a polynomial with coefficients `a` at point `x`.
"""
function polynomial(a, x)
    if eltype(a) != Char
        accumulator = 0
        for (i,a) in enumerate(a)
            accumulator += x^(i-1) * a[i] # ! 1-based indexing for arrays
        end
        return accumulator
    else
        throw(ArgumentError("Invalid coefficients $(a) of type Char!"))
    end
end

a = [-19, 7, -4, 6] # list coefficients a from a^0 to a^n
x = 3.               # point of evaluation
acumulator = 0

c = collect(2:2:42)
d = copy(c)
d[7] = 13


function addone(a)
    a + 1
end

af = [-19.0, 7.0, -4.0, 6.0];
at = (-19, 7, -4, 6)
ant = (a₀ = -19, a₁ = 7, a₂ = -4, a₃ = 6)
a2d = [-19 -4; 7 6]
ac = [2i^2 + 1 for i in -2:1]
ach = ['1', '2', '3', '4']
