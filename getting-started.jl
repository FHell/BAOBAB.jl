using Distributed
addprocs(4)

@everywhere using Pkg
@everywhere Pkg.activate(".")

@everywhere using BAOBAB

@everywhere exp_pars = ExpPars("tmp", 4, 3)

@everywhere generate_data(b, r, input_data) = println("Batch $b, Run $r")

experiment(generate_data, exp_pars, zeros(4,3))
