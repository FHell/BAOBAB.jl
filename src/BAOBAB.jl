module BAOBAB

using Distributed: pmap, @everywhere


using JLD2

export experiment, ExpPars

struct ExpPars
    tmp_dir
    n_batches
    runs_per_batch
end

function individual_run(generate_data, exp_pars::ExpPars,  batch_number, run_number, input_data)
    run_name = joinpath(exp_pars.tmp_dir, "batch_$(batch_number)_run_$(run_number).data")
    println(run_name)
    data = generate_data(batch_number, run_number, input_data)

    # wit_dir = joinpath(experiment_data.witness_dir, "/batch_($batch_number)_run_($run_number)")
    # witness_data(data, batch_number, run_number, input_data, wit_dir)

    @save run_name data
    (batch_number, run_number, run_name)
end

function experiment(generate_data, exp_pars::ExpPars, input_data::Array{T, 2}) where T
    # input_data needs to be indexable as [r,b] where r indexes the runs
    # and b indexes the batches.

    mkpath(exp_pars.tmp_dir)

    @everywhere generate_data = $generate_data
    @everywhere exp_pars = $exp_pars
    @everywhere input_data = $input_data

    # This distributes the variables to all processes
    enumerated_data = Array{Tuple{Int, Int, T}, 1}()
    for b in 1:exp_pars.n_batches
        for r in 1:exp_pars.runs_per_batch
            append!(enumerated_data, [(b, r, input_data[b, r]),])
        end
    end

    f = function (c)
        batch_number, run_number, input_datum = c
        individual_run(generate_data, exp_pars::ExpPars,  batch_number, run_number, input_datum)
    end

    runfiles = pmap(f, enumerated_data)

    runfiles
end



end # module
