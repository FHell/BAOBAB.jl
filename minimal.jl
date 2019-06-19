using Distributed
addprocs(2)

module test
    using Distributed: pmap

    export talk

    function talk(x)
        f = (x) -> println(2*x)
        pmap(f, x)
    end

end

@everywhere import .test


test.talk([5,2])
