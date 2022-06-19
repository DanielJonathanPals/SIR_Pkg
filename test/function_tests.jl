include("../src/functions.jl")
using Test
using Random

Random.seed!(1)
x = rand(); y = rand()
Random.seed!(1)
@test add(x,y) ≈ rand()+rand()