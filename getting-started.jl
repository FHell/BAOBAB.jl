using Distributed
addprocs(2)

@everywhere using Pkg
@everywhere Pkg.activate(".")

@everywhere using BAOBAB

exp_pars = ExpPars("tmp", 4, 3)

function generate_data(b, r, input_datum)
    println("Batch $b, Run $r, input datum $input_datum")
    input_datum
end

function aggregate(rundata)
    sum(rundata)
end

experiment(generate_data, aggregate, exp_pars, ones(4,3))
