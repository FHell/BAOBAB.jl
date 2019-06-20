using Distributed
addprocs(2)

@everywhere using Pkg
@everywhere Pkg.activate(".")

@everywhere using BAOBAB

@everywhere exp_pars = ExpPars("tmp", 4, 3)

@everywhere function generate_data(b, r, input_data)
    println("Batch $b, Run $r, input data $input_data")
    input_data
end


@everywhere function aggregate(rundata)
    sum(rundata)
end

experiment(generate_data, aggregate, exp_pars, zeros(4,3))
