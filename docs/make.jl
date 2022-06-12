using SIR_Pkg
using Documenter

DocMeta.setdocmeta!(SIR_Pkg, :DocTestSetup, :(using SIR_Pkg); recursive=true)

makedocs(;
    modules=[SIR_Pkg],
    authors="Daniel Pals <Daniel.Pals@tum.de>",
    repo="https://github.com/DanielJonathanPals/SIR_Pkg.jl/blob/{commit}{path}#{line}",
    sitename="SIR_Pkg.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
