using Revise
using Documenter
push!(LOAD_PATH, "../")
using BAOBAB

makedocs(
    sitename = "BAOBAB",
    format = Documenter.HTML(canonical = "https://FHell.github.io/BAOBAB.jl/"),
    linkcheck=true,
    modules = [BAOBAB],
    pages = [
    "General" => "index.md",
    ]) #Here we have to agree on the Page structure yet.

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#

cp("docs_src/build", "docs", force=true)
