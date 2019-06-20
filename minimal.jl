using Distributed
addprocs(2)

@everywhere module test
    using Distributed: pmap, @everywhere

    export talk

    function talk(x)
        f = (x) -> println(2*x)
        pmap(f, x)

        x2 = x

        @everywhere x2 = $x2

        println(x2)

        @everywhere println(x2)
    end

end

@everywhere import .test


test.talk([5,2])
