using Distributed
addprocs(2)

@everywhere using Pkg
@everywhere Pkg.activate(".")

@everywhere using BAOBAB

@everywhere begin

    exp_pars = ExpPars("tmp", 4, 3)

    function generate_data(b, r, input_datum)
        # given the batch and run that we are in, generate the expeirmental data
        println("Batch $b, Run $r, input datum $input_datum")
        input_datum
    end

    function aggregate(batchdata)
        # batchdata is an array of the return type of generate_data
        sum(batchdata)
    end

end

experiment(generate_data, aggregate, exp_pars, ones(4,3))
