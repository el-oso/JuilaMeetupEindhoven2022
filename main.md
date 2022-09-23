---
theme : "white"
transition: "slide"
highlightTheme: "monokai"
logoImg: "julia.svg"
slideNumber: false
title: "Eindhoven Julia Meetup Sep 2022"
author: Jorge Vieyra
---

## Top 10 mistakes to avoid in <img src="julia.svg" width="200">



Jorge Vieyra

---

<section>
    <ul>
        <li> Basic ... with small incursions in C (and VB) </li>
        <li class="fragment"> Pascal (at University) ... and Delphi (Visual Pascal)</li>
        <li class="fragment"> Fortran77 and python (1.6 at the time) as a TA for Physics 101</li>
        <li class="fragment"> PERL ... because was trendier than python</li>
        <li class="fragment"> C ... <em>real</em> linuxers knew </li>
        <li class="fragment"> PHP + MySQL for websites ... free-lancing </li>
        <li class="fragment"> MATLAB for Chemical Process Simulations </li>
        <li class="fragment"> Then <em>real</em> C for Fluid Dynamics in cluster @MIT </li>
        <li class="fragment"> More MATLAB as TA for Numerical Simulation </li>
        <li class="fragment"> Python + MATLAB for PhD ...  and then for ASML </li>
        <li class="fragment"> ... Now Julia </li>
    </ul>
</section>

---

## 1 Treating <img src="julia.svg" height="80" style="vertical-align:bottom"> as <img src="python.svg" height="80" style="vertical-align:bottom">


---


<section style="text-align: left;">
Python is the most popular language in the world.

Will not discuss the social aspects of this statement,

just the technical ones...
    <ul>
        <li class="fragment">Python is fundamentally different from Julia</li>
        <li class="fragment">Python is interpreted ... Julia is compiled-ish</li>
        <li class="fragment">External compiled packages to offload tasks, e.g. numpy, pandas, matplotlib, etc.</li>
        <li class="fragment">Nice .. but then each package is its "own" universe </lib>
    </ul>
</section>

---


<section data-auto-animate>
    <h2 data-id="code-title">Simple example</h2>
  <pre data-id="python-add"><code class="language-python" data-line-numbers data-trim data-noescape>
  def add(a, b):
    return a + b
  </code></pre>
  <p class="fragment">What does this code do?</p>
</section>

<section data-auto-animate>
    <h2 data-id="code-title">Simple example</h2>
  <pre data-id="python-add"><code class="language-python" data-line-numbers data-trim data-noescape>
    import numpy as np
    def add(a, b):
        return a + b
    if __name__ == "__main__":
        x = np.random.rand(10)
        y = np.random.rand(10)
        add(x, y) # (5, 7, 9)
        add(1, 2) # 3
        add(1.0, 2.0) # 3.0
  </code></pre>
  <p>What about now?</p>
</section>


---

<section data-auto-animate>
    <h2 data-id="code-title">Python pattern</h2>
  <pre data-id="python-type-checking"><code class="language-python" data-line-numbers data-trim data-noescape>
def add(a, b):
    if isinstance(a, tuple) and isinstance(b, tuple):
        r = tuple([i+j for i,j in zip(a, b)])
    else:
        r = a + b
    return r
if __name__ == "__main__":
    x = (1,2,3)
    y = (4,5,6)
    add(x, y) # (5, 7, 9)
    add(1, 2) # 3
</code></pre>
</section>

<section data-auto-animate>
    <h2 data-id="code-title">Python pattern</h2>
  <pre data-id="python-type-checking"><code class="language-julia" data-line-numbers data-trim data-noescape>
function add(a, b)
    local r
    if a isa Tuple && b isa Tuple
        r = Tuple([i+j for (i,j) in zip(a, b)])
    else
        r = a + b
    end
    return r
end
x = (1,2,3)
y = (4,5,6)
add(x, y) # (5, 7, 9)
add(1, 2) # 3
</code></pre>
</section>

<section data-auto-animate>
    <h2 data-id="code-title">Julia pattern</h2>
  <pre data-id="python-type-checking"><code class="language-julia" data-line-numbers data-trim data-noescape>
function add(a, b)
    return a + b
end
function add(a::Tuple, a::Tuple)
    return Tuple([i+j for (i,j) in zip(a, b)])
end
x = (1,2,3)
y = (4,5,6)
add(x, y) # (5, 7, 9)
add(1, 2) # 3
</code></pre>
</section>

<section data-auto-animate>
    <h2 data-id="code-title">Julia pattern</h2>
  <pre data-id="python-type-checking"><code class="language-julia" data-line-numbers data-trim data-noescape>
add(a, b) = a + b
add(a::Tuple, a::Tuple) = Tuple([i+j for (i,j) in zip(a, b)])
x = (1,2,3)
y = (4,5,6)
add(x, y) # (5, 7, 9)
add(1, 2) # 3
</code></pre>
<p class="fragment">Using a more Julian pattern you can decrease code size and add flexibility</p>
</section>


<section data-auto-animate>
    <h2 data-id="code-title">Julia pattern</h2>
  <pre data-id="python-type-checking"><code class="language-julia" data-line-numbers data-trim data-noescape>
add(a, b) = a + b
add(a::Tuple, a::Tuple) = Tuple([i+j for (i,j) in zip(a, b)])
add(a::String, b::String) = "$a and $b"
x = (1,2,3)
y = (4,5,6)
add(x, y) # (5, 7, 9)
add(1, 2) # 3
add("Julia", "Python") # "Julia and Python"
</code></pre>
</section>
<section data-auto-animate>
    <h2 data-id="code-title">Python pattern</h2>
  <pre data-id="python-type-checking"><code class="language-python" data-line-numbers data-trim data-noescape>
def add(a, b):
    if isinstance(a, tuple) and isinstance(b, tuple):
        r = tuple([i+j for i,j in zip(a, b)])
    elif isinstance(a, str) and isinstance(b, str):
        r = f"{a} and {b}"
    else:
        r = a + b
    return r
if __name__ == "__main__":
    x = (1,2,3)
    y = (4,5,6)
    add(x, y) # (5, 7, 9)
    add(1, 2) # 3
    add("Julia", "Python") # "Julia and Python"
</code></pre>
</section>

<section data-auto-animate>
    <h2 data-id="code-title">Julia pattern</h2>
  <pre data-id="python-type-checking"><code class="language-julia" data-line-numbers data-trim data-noescape>
add(a, b) = a + b
add(a::Tuple, a::Tuple) = Tuple([i+j for (i,j) in zip(a, b)])
add(a::String, b::String) = "$a and $b"
x = (1,2,3)
y = (4,5,6)
add(x, y) # (5, 7, 9)
add(1, 2) # 3
add("Julia", "Python") # "Julia and Python"
</code></pre>
<p class="fragment">The original pattern forces me to modify the original code, the second one doesn't!</p>
</section>

---

## 2 Thinking that Julia is C

---


<section data-auto-animate>
    <p data-id="code-title">Julia is compiled ... but ... you don't need this ...</p>
  <pre data-id="compiling"><code class="language-c" data-line-numbers data-trim style="font-size: 15px;">
#include <stdio.h>
#include <stdlib.h>
int add_int32(int a, int b){
    return a + b;
}
double add_double(double a, double b){
    return a + b;
}
int* add_int_array(int *a, int *b, int n){
    /* Note that I am not even checking bounds or anything fancy */
    int *result;
    int i;
    result = (int*)malloc(n * sizeof(int));
    for (i=0;i < n;i++){
        n[i] = a[i] + b[i];
    }
    return result;
}
int main(){
    printf("%d", add_int32(1, 2)); /* 3 */
    printf("%g", add_double(1.0, 2.0)) /* 3.0 */
    a = {1, 2, 3};
    b = {4, 5, 6};
    /* printf("arr", add_int_array(a, b, 3)); # needs printing function that I didn't implement*/
    return 0;
}
</code></pre>
</section>

<section data-auto-animate>
    <p data-id="code-title">Equivalent (and more) in Julia</p>
  <pre data-id="compiling"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
add(a, b) = a + b
add(1,2) # 3
add(1.0, 2.0) # 3.0
add([1,2,3], [4,5,6]) # [5, 7, 9]
</code></pre>
</section>

<section data-auto-animate>
    <p data-id="code-title">In fact Julia allows you do do the following ...</p>
  <pre data-id="compiling"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
add(a, b) = a + b
Base.:+(a::String, b::String) = "$a and $b" # Don't do this
# Definitely don't do this either
Base.:+(a::NTuple{N, T}, b::NTuple{N, T}) where {N, T <: Number} = Tuple([i+j for (i,j) in zip(a, b)])
add(1,2) # 3
add(1.0, 2.0) # 3.0
add([1,2,3], [4,5,6]) # [5, 7, 9]
add((1,2,3), (4,5,6)) # (5, 7, 9)
add("Julia", "Python") # "Julia and Python"
</code></pre>
</section>

<section data-auto-animate>
    <p data-id="code-title">In fact Julia allows you do do the following ...</p>
  <pre data-id="compiling"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
using MethodAnalysis
add([1,2,3], [4.0,5.0,6.0])
methodinstances(add)
# 6-element Vector{Core.MethodInstance}:
#  MethodInstance for add(::Int64, ::Int64)
#  MethodInstance for add(::Float64, ::Float64)
#  MethodInstance for add(::Vector{Int64}, ::Vector{Int64})
#  MethodInstance for add(::Tuple{Int64, Int64, Int64}, ::Tuple{Int64, Int64, Int64})
#  MethodInstance for add(::String, ::String)
#  MethodInstance for add(::Vector{Int64}, ::Vector{Float64})
</code></pre>
<p>Julia generates all the versions for seen types AND compiles it for all your inputs</p>
</section>

<section data-auto-animate>
    <p data-id="code-title">What is the problem with the following code?</p>
  <pre data-id="compiling"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
add(a, b) = a + b
add(a::Float64, b::Float64) = a + b
add(a::Int, b::Int) = a + b
add(a::Vector{Float64}, b::Vector{Float64}) = a + b
add(a::MyType, b::MyType) = a + b
</code></pre>
<p class="fragment">This overly <span style="color: red; font-weight: bold;">restricts</span> your function types</p>
</section>

---

## 3 Not using Revise.jl

---


<section>
The Write-Compile-Use loop could be quite tedious
    <ul>
        <li class="fragment"> Thanks to Tim Holy it doesn't need to ... </li>
        <li class="fragment"> This requires a live demo ... </li>
    </ul>
</section>

---

## 4 Writing scripts instead of writing packages

---

<section data-auto-animate>
    <p data-id="code-title">I have seen data engineers doing the following...</p>
  <pre data-id="scripting"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
using DataFrames
using Plots
using LinearAlgebra
using CSV
using StatsBase
function do_stuff(data)
    # Do something with data
end
function do_more_stuff(data)
    # Do something else with data
end
data = CSV.read("mydata.csv", DataFrame)
stuff = do_stuff(data)
sigma = std(data[!, :myvar])
plot(data[!:,x], sigma)
do_more_stuff(data)
for i in sigma
 # Do raw stuff
end
</code></pre>
<p class="fragment">Running scripts like this leads to problems with scoping because everything is a global variable</p>
</section>

<section data-auto-animate>
    <p data-id="code-title">Since we have the magic of Revise...</p>
  <pre data-id="scripting"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
using MyExplorationPackage
data = loaddata("mydata.csv")
result = process(data)
plot(result)
</code></pre>
<p class="fragment">Put all your logic inside a package. Easier to distribute it to other people. Revise makes exploration loops a breeze!</p>
</section>

---

## 5 Not writing granular enough functions

---

<section data-auto-animate>
    <p data-id="code-title">Perhaps it's due to the previous point. But people tend to write TOO BIG functions.
</p>
  <pre data-id="granular"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
function main()
    number_list = [34, 50, 25, 100, 65]
    largest = first(number_list)
    #
    for number in number_list
        largest = number > largest ? number : largest
    end
    println("The largest number is $largest")
    #
    number_list = [102, 34, 6000, 89, 54, 2, 48 8]
        largest = first(number_list)
    #
    for number in number_list
        largest = number > largest ? number : largest
    end
    println("The largest number is $largest")
    # ...
end
</code></pre>
<p class="fragment">You got the point ... copy/paste of code and very long functions</p>
</section>

<section data-auto-animate>
    <p data-id="code-title">This is repeated code ... that's what functions are for...
</p>
  <pre data-id="granular"><code class="language-julia" data-line-numbers="3-8" data-trim style="font-size: 15px;">
function main()
    number_list = [34, 50, 25, 100, 65]
    largest = first(number_list)
    #
    for number in number_list
        largest = number > largest ? number : largest
    end
    println("The largest number is $largest")
    #
    number_list = [102, 34, 6000, 89, 54, 2, 48 8]
        largest = first(number_list)
    #
    for number in number_list
        largest = number > largest ? number : largest
    end
    println("The largest number is $largest")
    # ...
end
</code></pre>
</section>

<section data-auto-animate>
  <pre data-id="granular"><code class="language-julia" data-line-numbers="|1-8,11,14|1-8" data-trim style="font-size: 15px;">
function printlargest(list::Vector{Int})
    largest = first(list)
    for item in list
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
function main()
    number_list = [34, 50, 25, 100, 65]
    printlargest(number_list)
    #
    number_list = [102, 34, 6000, 89, 54, 2, 48, 8]
    printlarget(number_list)
end
</code></pre>
<p class="fragment">Can we do better?</p>
</section>

<section data-auto-animate>
  <pre data-id="granular"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
function printlargest_int(list::Vector{Int})
    largest = first(list)
    for item in list
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
function printlargest_char(list::Vector{Char})
    largest = first(list)
    for item in list
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
</code></pre>
</section>

<section data-auto-animate>
  <pre data-id="granular"><code class="language-julia" data-line-numbers="1,9" data-trim style="font-size: 15px;">
function printlargest_int(list::Vector{Int})
    largest = first(list)
    for item in list
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
function printlargest_char(list::Vector{Char})
    largest = first(list)
    for item in list
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
</code></pre>
</section>

<section data-auto-animate>
<p data-id="code-title">By using we reduce the amount of written code</p>
  <pre data-id="granular"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
function printlargest(list::Vector{T}) where T
    largest = first(list)
    for item in list
        # We only need T to implement Base.:>
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
</code></pre>
</section>

<section data-auto-animate>
<p data-id="code-title">We can generalize for all kind of Vector containers</p>
  <pre data-id="granular"><code class="language-julia" data-line-numbers="1" data-trim style="font-size: 15px;">
function printlargest(list::Vector{T}) where T
    largest = first(list)
    for item in list
        # We only need T to implement Base.:>
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
</code></pre>
</section>

<section data-auto-animate>
<p data-id="code-title">This code now potentially works on a GPU!</p>
  <pre data-id="granular"><code class="language-julia" data-line-numbers="1" data-trim style="font-size: 15px;">
function printlargest(list::AbstractVector{T}) where T
    largest = first(list)
    for item in list
        # We only need T to implement Base.:>
        largest = item > largest ? item : largest
    end
    println("The largest number is $largest")
    return largest
end
</code></pre>
<p class="fragment">Although I wouldn't recommend this particular code</p>
</section>

---

## 6 People don't spending time profiling / benchmarking

---

<section data-auto-animate>
<p data-id="code-title">Consider the following code that performs:</p>
\[ y = ABx \]
  <pre data-id="granular"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
function mult2_v1(A::AbstractMatrix, B::AbstractMatrix, x::AbstractVector)
    C = A * B
    return C*x
end
#
function mult2_v2(A::AbstractMatrix, B::AbstractMatrix, x::AbstractVector)
    y = B*x
    return A*y
end
</code></pre>
<p class="fragment">Which one is faster?</p>
</section>


<section>
<pre><code class="language-julia-repl" data-trim data-line-numbers="1|5|5,14" style="font-size: 10px;">
julia> using BenchmarkTools
julia> @benchmark mult2_v1(A,B,x)
BenchmarkTools.Trial: 10000 samples with 198 evaluations.
 Range (min … max):  443.268 ns …  11.167 μs  ┊ GC (min … max): 0.00% … 94.07%
 Time  (median):     455.136 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   531.285 ns ± 542.451 ns  ┊ GC (mean ± σ):  6.03% ±  5.66%
  ▆▆█▅▂▂▂▁                                        ▁▂▂▂▂▃▃▃▃▁    ▂
  ███████████▅▅▃▄▃▄▃▅▅▃▅▁▄▃▄▄▄▄▁▄▄▃▃▃▃▄▁▅▄▅▅▄▄▅▅▆▇█████████████ █
  443 ns        Histogram: log(frequency) by time        738 ns <
 Memory estimate: 1.02 KiB, allocs estimate: 2.
 julia> @benchmark mult2_v2(A,B,x)
 BenchmarkTools.Trial: 10000 samples with 772 evaluations.
 Range (min … max):  165.570 ns …   3.620 μs  ┊ GC (min … max): 0.00% … 92.05%
 Time  (median):     173.123 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   197.092 ns ± 167.225 ns  ┊ GC (mean ± σ):  5.13% ±  5.72%
    ▅██▆▄▃▂▂▂▁                            ▁▂▂▃▄▄▃▃▂▂▁           ▂
  ▇███████████▆▆▆▆▅▆▅▃▃▃▆▄▁▄▁▄▄▃▃▄▃▁▄▄▄▆▇█████████████▇▇▆▇▆▆▅▆▅ █
  166 ns        Histogram: log(frequency) by time        267 ns <
 Memory estimate: 288 bytes, allocs estimate: 2.
</code>
</pre>
<p class="fragment">Julia has excellent packages for profiling!</p>
</section>

<section>
    <p>Don't have time to show all ...</p>
    <ul>
        <li>Base has @time for rough estimates!</li>
        <li>BechmarkTools</li>
        <li>FlameGraphs</li>
        <li>ProfileSVG</li>
        <li>VSCode has a built-in one! Try it!</li>
    </ul>
</section>

---

## 7 People don't reuse packages

---

<section>
<p>Julia's ecosystem is not as large as python's ... but ...</p>
<ul>
    <li class="fragment">It doesn't need to be as large because of composition!</li>
    <li class="fragment">It is not small either</li>
    <li class="fragment">You can make it grow!</li>
</ul>
</section>

<section style="text-align: left;">
    <p>Probably running out of time ...</p>
    <ul>
        <li>DifferentialEquations.jl</li>
        <li>StatsBase.jl</li>
        <li>DataFrames.jl</li>
        <li>Images.jl</li>
        <li>juliahub.com is very handy!</li>
        <li><a href="https://julialang.org/community/organizations/">Check the Julia Organizations!</a></li>
    </ul>
    <p>Don't reinvent the wheel! Reuse THEIR types!</p>
</section>

---

## 8 Importing the "Universe"

---

<section data-auto-animate>
    <p data-id="code-title">People in a "hurry" do this...</p>
  <pre data-id="universe-import"><code class="language-julia" data-line-numbers data-trim style="font-size: 15px;">
using CSV
using Parquet
using MAT
using DataFrames
using Plots
using LinearAlgebra
using StatsBase
using Revise
data = CSV.read("mydata.csv", DataFrame)
# and only use DataFrames...
</code></pre>
<p class="fragment">This creates unnecessary dependencies. Please keep it small and organized!</p>
</section>

---

## 9 Not using the REPL

---


<section data-auto-animate>
    <p data-id="code-title">Julia's REPL is the most advanced REPL's from all the ones out there!
</p>
  <pre data-id="repl"><code class="language-julia-repl" data-line-numbers data-trim style="font-size: 15px;">
    julia> using OhMyREPL # For nicer REPL
    shell> # can use shell commands with ;
    pkg> # can manage your environments and installed packages ]
</code></pre>
<p>Pro tip! Use the REPL ... NOT the debugger!</p>
<a href="https://www.youtube.com/watch?v=bHLXEUt5KLc">Try this REPL Mastery Workshop</a>
</section>


---

## 10 Not engaging the community

---

<section style="text-align: left;">
    <p>I have heard people saying: "I cannot any documentation in Julia!"</p>
    <ul>
        <li>StackOverflow is not that populated for Julia</li>
        <li>Try your local Julia group!</li>
        <li>and/or Slack!</li>
        <li>and/or Discourse!</li>
        <li>and/or Discord!</li>
        <li>and/or Zulip! ... if you can understand how it works</li>
    </ul>
    <p>Julia's community is still small ... That's an advantage!</p>
</section>

---

Julia is an easy to learn language

... with familiar syntax

... but with exponential flexibility!

Embrace the change!
