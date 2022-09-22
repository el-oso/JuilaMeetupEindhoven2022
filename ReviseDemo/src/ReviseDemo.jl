module ReviseDemo

greet() = print("Hello World!")

add(a, b) = a + b

function some_other(vec::AbstractVector)
    println("Got a Vector of type $(typeof(vec))")
    return mapreduce(x->x^2, +, vec)
end

export add

end # module ReviseDemo
