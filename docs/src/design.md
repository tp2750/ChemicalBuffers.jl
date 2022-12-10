# ChemicalBuffers Mental Model

This section is about how the code is organized and which data structures are used.


# Buffers

The package has a library of known buffers.
These can be used by name, as we saw in the tutorial.
Later we will see how to define a new buffer.

The know buffers are listed in Appendix A.

## Buffer Data Structure

A buffer is defined by a vector of buffer components:

```julia
struct Buffer
    name::String
    components::Vector{BufferComponent}
    hazards::Union{Vector{Int64}, Missing}
    precautions::Union{Vector{Int64}, Missing}
    uv_limit::Union{Float64,String,Missing} ## https://www.reachdevices.com/Protein/BiologicalBuffers.html
    notes::String                   ## https://www.reachdevices.com/Protein/BiologicalBuffers.html
end
```

A buffer component is defined by its pKa^0 values:

```julia
struct BufferComponent
    name::String
    pKa0_25C::Vector{Float64}
    dpKa_dt::Float64
    notes::String
end
```

A buffer stock is a list of buffer component solutions

```julia
struct ComponentSolution
    name::String
    buffer_component::BufferComponent
    molarity_M::Float64
    volume_L::Float64
end

struct BufferStock
    name::String
    stock_solutions::Vector{ComponentSolution}
end
```

Finally, a buffer solution is mix of the stocks with water:

```julia
struct BufferSolution
    name::String
    stock_aliquots::Vector{ComponentSolution}
    volume_L::Float64
end
```

The stock_aliquots contain the amount used, and `volume_L` is the total volume of buffer solution.

To compute the recipes, we need to know the possible salts to use

```julia
struct Salt
    name::String
    formula::String
    molecular_weight::Float64
    hydration::Int64
    solubility::Vector{Solubility} ## interpolate between known solubilities. Hint if heating or cooling helps (endothermal / exothermal)
    hazards::Union{Vector{Int64}, Missing}
    precautions::Union{Vector{Int64}, Missing}
    notes::String
end

struct Solubility ## g/L @ temperature
    solubility_g_L::Float64    
    solubility_temp_C::Float64
end
```


# Methods on a buffer solution

## pH
We can check the pH of a buffer solution. The pH depends on the temperature. So we can check the pH at a different temperature, than the one we designed for.

```julia
using ChemicalBuffers
phos = buffer("Phosphate");
phos_stock = buffer_stocks(phos, M = 1.0);
phos_100_6.0 = buffer(phos_stock, pH = 6.0, M = 0.1, T=25);

pH(phos_100_6.0, T=25)
# 6.00
```
## Recipes

We can get the recipe of the buffer solution based on the stock solutions (as a Data Frame):

```julia
recipe(phos_100_6.0, L = 1.0)
```

And we can print it (as markdown, html, text, odt, docx, ods, xlsx) using `print_recipe`:

```julia
print_recipe(phos_100_6.0, L = 1.0, file = "phosphate_buffer.docx")
```

We can also get the recipe of the stock solutions: 

```julia
recipe(phos_stock, L = 1.0)
```

For the stock solutions, there is a default hydration of the salt, but other hydration levels can be specified or all can be printed for information.


```julia
recipe(phos_stock, all_hydrates=true)
recipe(phos_stock, hydrates = [0,0], L = 1.0)
```

## Buffer strength

```julia
buffer_strength(phos_100_6.0)
# 0.1 M
```

## Buffer capacity

Check with https://www.egr.msu.edu/~scb-group-web/buffers/buffers.html

```julia
buffer_capacity(phos_100_6.0)
# 27.01 mM NaOH / pH
```

## Titration Curve
```julia
tc = titration_curve(phos_100_6.0)
using Plots
plot(tc)
```

## Ionic strength

```julia
ionic_strength(phos_100_6.0)
```

## pKa values

The effective pKa values of a component solution. This depends on ionic stregnth and temperature.

We use this internally. 
Several methods can be chosen:

* Debye-Huckel parameters: A


# Functions

Functions used to implement the functionality:



# Appendix A: List of known buffers

* Phospahte
* Britton-Robinson
* Britton-Robinson citric
* Britton-Robinson-Nakagava (https://www.researchgate.net/publication/301623974_Development_of_a_modified_Britton-Robinson_buffer_with_improved_linearity_in_the_alkaline_pH_region)
* Glycine-HCL
* Sodium Acetate
* Cacodylate
* Citrate
* Phosphate-Citrate
* Barbital
* Tris
* Glycine

Goods buffers: https://www.reachdevices.com/Protein/BiologicalBuffers.html
| Buffer             | pKa  | Date added |
| --                 | --   | --         |
| MES                | 6.15 | 1966       |
| Bis-tris methane   | 6.60 |            |
| ADA                | 6.62 | 1966       |
| Bis-tris propane   | 6.80 |            |
| PIPES              | 6.82 | 1966       |
| ACES               | 6.88 | 1966       |
| MOPSO              | 6.95 | 1980       |
| Cholamine chloride | 7.10 | 1966       |
| MOPS               | 7.15 | 1972       |
| BES                | 7.17 | 1966       |
| TES                | 7.5  | 1966       |
| HEPES              | 7.55 | 1966       |
| DIPSO              | 7.6  | 1980       |
| MOBS               | 7.6  |            |
| Acetamidoglycine   | 7.7  | 1966       |
| TAPSO              | 7.6  | 1980       |
| TEA                | 7.8  |            |
| POPSO              | 7.85 | 1980       |
| HEPPSO             | 7.9  | 1980       |
| EPS                | 8.0  |            |
| HEPPS              | 8.1  | 1972       |
| Tricine            | 8.15 | 1966       |
| Tris               | 8.2  | 1966       |
| Glycinamide        | 8.2  | 1966       |
| Glycylglycine      | 8.2  | 1966       |
| HEPBS              | 8.3  |            |
| Bicine             | 8.35 | 1966       |
| TAPS               | 8.55 | 1972       |
| AMPB               | 8.8  |            |
| CHES               | 9.3  |            |
| CAPSO              | 9.6  |            |
| AMP                | 9.7  |            |
| CAPS               | 10.4 |            |
| CABS               | 10.7 |            |


Derived buffers: https://microscopy.berkeley.edu/buffers-and-buffer-tables/

* EDTA
* SSC
* SSPE
* TE
* STE (TNE)
* PBS
* TBS
* TNT
* PBT

