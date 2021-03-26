using PIML
using Documenter

DocMeta.setdocmeta!(PIML, :DocTestSetup, :(using PIML); recursive=true)

makedocs(;
    modules=[PIML],
    authors="Roger-Luo <rogerluo.rl18@gmail.com> and contributors",
    repo="https://github.com/Roger-luo/PIML.jl/blob/{commit}{path}#{line}",
    sitename="PIML.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Roger-luo.github.io/PIML.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Roger-luo/PIML.jl",
)
