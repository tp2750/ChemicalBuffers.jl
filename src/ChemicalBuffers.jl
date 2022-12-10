module ChemicalBuffers

export ionization_fractions_gamma1
export acetic_acid, carbonic_acid, citric_acid, phosphoric_acid

function ionization_fractions_gamma1(pKa::Vector{T},pH) where T
    ## Formula 17 of https://www.mdpi.com/2624-8549/3/2/34
    x = 10. ^(-pH)
    Ka = 10. .^(-pKa)
    k_j = [1.; cumprod(Ka)]
    x_j = [1.; cumprod(repeat([x], length(pKa)))]
    a0 = 1./sum(k_j ./ x_j)
    a_j = a0 * k_j ./  x_j
    a_j
end

## Data values
struct BufferComponent
    name::String
    pKa0_25C::Vector{Float64}
    dpKa_dt::Float64
    notes::String
end

# https://chem.libretexts.org/Ancillary_Materials/Reference/Reference_Tables/Equilibrium_Constants/E1%3A_Acid_Dissociation_Constants_at_25C
acetic_acid = BufferComponent("Acetic acid", [4.76], 1, "") 
carbonic_acid = BufferComponent("Acrbonic acid", [6.35, 10.33], 1., "")
citric_acid = BufferComponent("Citric acid", [3.13, 4.76, 6.40], 1., "")
phosphoric_acid = BufferComponent("Phosphoric acid", [2.16, 7.21, 12.32], 1. ,"")

end
