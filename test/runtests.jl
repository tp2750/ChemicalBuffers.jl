using ChemicalBuffers
using Test

sd(x) = sum(vec(hcat(x...)).^2)

@testset "ChemicalBuffers.jl" begin
    @test ionization_fractions_gamma1(acetic_acid, 4.76) == [.5, .5]
    ca2 = ionization_fractions_gamma1.(Ref(carbonic_acid), [6.35, 10.33])
    @test sd(ca2 - [[.5, .5, 0], [0, .5, .5]]) < 1E-5
end
