using ChemicalBuffers
using Documenter

DocMeta.setdocmeta!(ChemicalBuffers, :DocTestSetup, :(using ChemicalBuffers); recursive=true)

makedocs(;
    modules=[ChemicalBuffers],
    authors="Thomas Poulsen",
    repo="https://github.com/tp2750/ChemicalBuffers.jl/blob/{commit}{path}#{line}",
    sitename="ChemicalBuffers.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tp2750.github.io/ChemicalBuffers.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorial" => "tutorial.md",
        "Design" => "design.md",
        "Theory" => "theory.md",
    ],
)

deploydocs(;
    repo="github.com/tp2750/ChemicalBuffers.jl",
    devbranch="main",
)
