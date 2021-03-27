### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ cc2cf6c0-8e92-11eb-1255-53074ed0e59c
using ShortCodes

# ╔═╡ f1aa59ae-8e94-11eb-12bc-3b1d9ccc314b
html"""
<style>
main {
    max-width: 1900px;
}
.julia-container {
   max-width: 1900px;
   max-height: 400px;
}
</style>
<script src="https://kit.fontawesome.com/0d64c2ab8c.js" crossorigin="anonymous"></script>
"""

# ╔═╡ 7400844c-8e8f-11eb-27d0-859ea6dba632
md"""
# The Julia Programming Language

![Julia Logo](https://julialang.org/assets/infra/logo.svg)
"""

# ╔═╡ de79e82c-8e8f-11eb-0513-c7df38cb3d30
md"""
# Why Julia?
"""

# ╔═╡ 03a8af1e-8e90-11eb-2d94-e52e8c2be959
md"""
# Interpreted Language: Pros

- Simple: no need to learn the concept of memory, type system, etc.
- Flexible: almost everything can be modified at runtime
- ...
"""

# ╔═╡ 61a2883a-8e90-11eb-26bb-49925c4ad4e9
md"""
# Interpreted Language: Cons

- Slow: hard to optimize, a compiler won't be able to gain enough information for optimization
- Less error proof: flexibility make it hard to check errors
- ...
"""

# ╔═╡ b039ac32-8e90-11eb-08ec-8710712591f7
md"""
# Static Compiled Language: Pros

- Fast: designed to be compiled, easier to optimize
- Error Proof: the static type system can help programmer detect more potential errors
- ...
"""

# ╔═╡ d9287bda-8e90-11eb-1c46-af0555ed5158
md"""
# Static Compiled Language: Cons

- Complex: usually a static language has more concepts and more complicated type system comparing to interpret language
- Not Flexible: not everything can be changed at runtime, makes it less convenient to prototype with
- ...
"""

# ╔═╡ 232da2be-8e91-11eb-3289-0d9bf19a225e
md"""
## Just-in-time compilation: compile right before you run it!

*some runtime values become compile time*
"""

# ╔═╡ e17692c6-8e91-11eb-3573-c98d429a5403
md"""
## Combine Static Compiled Language with Interpreted Language

*a language designed for just-in-time compilation*

[Julia: A Fresh Approach to
Numerical Computing (DOI:10.1137/141000671)](https://julialang.org/assets/research/julia-fresh-approach-BEKS.pdf)
"""

# ╔═╡ 363accfa-8e92-11eb-1a5b-6fac3df0290c
md"""

## Julia: A Differentiable Programmable Language

[The Software 2.0](https://karpathy.medium.com/software-2-0-a64152b37c35) - Andrej Karpathy
"""

# ╔═╡ c9959dd6-8e92-11eb-04ed-7b8ee3717c28
Twitter(1152288749243420672)

# ╔═╡ 9bfff004-8e8f-11eb-0a21-1db0b13d1b12
md"""
# Before we start

- how do I setup my Julia environment?
- where can I get help?
"""

# ╔═╡ 7028360e-8e93-11eb-0ab6-3f50c4f864a5
md"""
# Download Julia: julialang.org
"""

# ╔═╡ 923c58a6-8e93-11eb-15cd-f7cac665afad
html"""
<iframe src="https://julialang.org/" width="1000px" height="600px"></iframe>
"""

# ╔═╡ 74e8356e-8e97-11eb-1d7f-29b54ca49dc4
html"""
<iframe src="https://julialang.org/downloads/" width="1000px" height="600px"></iframe>
"""

# ╔═╡ 30267782-8e98-11eb-368a-15bac39281cf
md"""
## Download Editor

- Visual Studio Code (Recommended): [https://code.visualstudio.com/](https://code.visualstudio.com/)
- Atom: [https://atom.io/](https://atom.io/)
"""

# ╔═╡ 65c1388e-8e98-11eb-036e-6be0f9ceeae8
md"""
## Install Plugin (VS Code)
"""

# ╔═╡ 8f7710a2-8e98-11eb-02af-69a34e81c9cf
html"""
<iframe src="https://www.julia-vscode.org/docs/dev/gettingstarted/#Installation-and-Configuration-1" width=1000, height=600></iframe>
"""

# ╔═╡ c2b5415e-8e99-11eb-2cbf-c1392fb5075e
md"""
# Install your first Julia package: the Pluto Notebook

most of the meterials of this lecture will be written as Pluto notebooks, so you will need to install Pluto notebooks, this is also the first Julia package you will install.
"""

# ╔═╡ 100a2712-8e9a-11eb-057b-cf84805d9f82
html"""
please <a href="https://docs.julialang.org/en/v1/manual/getting-started/">open Julia's interactive session (known as REPL)</a> and press <kbd>]</kbd> key in the REPL to use the package mode, then type the following command
"""

# ╔═╡ 1c9fec26-8e9a-11eb-1f50-3512e5f1a36f
md"""
```
(@v1.6) pkg> add Pluto
```
"""

# ╔═╡ 6fb8a292-8e9a-11eb-3614-2bac1c3c7ebc
html"""
then press <i class="fas fa-backspace"></i> (backspace) button and run the following command
"""

# ╔═╡ 767c63dc-8e9a-11eb-299d-257d7d961df2
md"""
```julia
julia> using Pluto; Pluto.run()
```

you will see a webpage pops out in your browser, then you can create a new notebook to play with Julia
"""

# ╔═╡ bd5bc9d6-8e98-11eb-2bb4-4bc600b4e887
md"""
## Where do I get help?

- ask your TA/instructor

besides above, the Julia programming language has an active community:

1. write a post on the discourse: [https://discourse.julialang.org/](https://discourse.julialang.org/)
2. join Julia Zulip chat group: [https://julialang.zulipchat.com/register/](https://julialang.zulipchat.com/register/)
3. join Julia Slack chat group: [https://julialang.org/slack/](https://julialang.org/slack/)
"""

# ╔═╡ 9d29f678-8e99-11eb-2fac-595bd3335f64
md"""
# The Julia Basics
"""

# ╔═╡ 51920c44-8e9b-11eb-2ffa-6bb90b32cb76
md"""
## Variables

you can create a variable like other scripting language by assigning a value to it
"""

# ╔═╡ 65b492d2-8e9b-11eb-1f7e-6ff3d12b2acc
x = 1

# ╔═╡ 83192d6a-8e9b-11eb-2b3a-e7d120398f48
md"""
every variable has a type, you can check it using `typeof`
"""

# ╔═╡ b3e93bda-8e9b-11eb-177f-c3e6006a3409
typeof(x)

# ╔═╡ b8dfa5c0-8e9b-11eb-3378-51fe3adafa47
md"""
By default Julia displays the output of the last operation. (You can suppress the output by adding ; (a semicolon) at the end.)
"""

# ╔═╡ c662d416-8e9b-11eb-3309-abf865336ab6
y = 1;

# ╔═╡ ccfa44fa-8e9b-11eb-2d50-79ad7c21f35e
md"""
### Functions
In Julia, you can also define short-form, one-line functions using = (assignment) similar to how you write things mathematically.
"""

# ╔═╡ dd27a734-8e9b-11eb-10cd-697750fc8d3c
f(x) = 2x

# ╔═╡ e8ae462e-8e9b-11eb-2910-b38ea3de5252
md"""
Typing the function's name gives information about the function. To call it we must use parentheses:
"""

# ╔═╡ faa11e56-8e9b-11eb-0a29-2b33770da084
md"""
For longer functions we use the following syntax with the function keyword and end:
"""

# ╔═╡ 018a5106-8e9c-11eb-0d13-a5542c3fcd4b
function g(x, y)
	z = x + y
	return z^2
end

# ╔═╡ 0a93166e-8e9c-11eb-2fd5-1d80e13be555
md"""
# Control Flows
In Julia, there are for, if and while, they look like the following
"""

# ╔═╡ 1645283c-8e9c-11eb-204c-d93911df6dfa
begin
	s = 0
	for i in 1:10
		s += 1
	end
end

# ╔═╡ 1f7ca574-8e9c-11eb-19f8-931e6de060ed
md"""
here `begin...end` is used to wrap a code block as Pluto required, you don't have to write it outside Pluto, we can now check the value of s by typing it again
"""

# ╔═╡ 2db39ddc-8e9c-11eb-302a-890b52609e00
s

# ╔═╡ 33cddbd0-8e9c-11eb-02cc-5fbfbc0f4037
md"""
Here, 1:10 is a **range** representing the numbers from 1 to 10:
"""

# ╔═╡ 3c08b980-8e9c-11eb-3b35-3d8f254d4e4f
typeof(1:10)

# ╔═╡ 44cfe19e-8e9c-11eb-311b-3119586254e7
md"""
the if else statement looks like the following
"""

# ╔═╡ 4b2e285a-8e9c-11eb-3fb2-23dc7a5652d8
if s < 10
	# do something
elseif 10 < s < 13
	# do something
else
	# do something
end

# ╔═╡ 53388a2c-8e9c-11eb-3ceb-7100da65a4a0
md"""
## Matrix and Array
Julia carries its own Array type, if you use Python, it is similar to `numpy.array` in Python except:

index starts from `1`

the multi-dimensional index is column-wise

You can also have list comprehension:
"""

# ╔═╡ 65cf20ae-8e9c-11eb-20f1-9dd4f08a8103
[i for i in 1:10]

# ╔═╡ 6aa77704-8e9c-11eb-22ac-bdbd3d23583b
md"""
it works for multi-dimensional case too:
"""

# ╔═╡ 70be63f2-8e9c-11eb-35b6-3b8f3bffa0f4
[(i, j) for i in 1:10, j in 1:5]

# ╔═╡ 7722da64-8e9c-11eb-3c4d-d98f275cb706
md"""
most builtin functions follow the same convention as numpy or MATLAB, e.g you can create a random matrix using:
"""

# ╔═╡ 8166d48c-8e9c-11eb-2032-cb423df0bd61
rand(5, 5)

# ╔═╡ 86253606-8e9c-11eb-271c-9950a3ffcd90
md"""
if you have question about using a function, you can always type question mark `?` in your REPL following the function name

```julia
julia> ?rand
```
"""

# ╔═╡ bc6678a0-8e9d-11eb-006b-4766c2f47db9
md"""
## Multiple Dispatch

Julia functions is overloadable, we can put type annotations to distinguish different kinds of Julia functions
"""

# ╔═╡ dec6a71c-8e9d-11eb-29a4-cdfd1c27c01b
f(x::Int) = x + 1

# ╔═╡ e43bfe90-8e9d-11eb-3f8d-d5fd9b5d96cc
f(x::Float64) = x + 2

# ╔═╡ f518b756-8e9d-11eb-2153-3f8b7bad9e26
md"""
this works on arbitrary number of arguments
"""

# ╔═╡ fe2103dc-8e9d-11eb-2b6e-e73204feef2b
f(x, y::Int) = x + y

# ╔═╡ eecc7206-8e9b-11eb-0b13-b7f613eb974d
f

# ╔═╡ f2ba5414-8e9b-11eb-2941-277569b5be73
f(2)

# ╔═╡ ead8e42a-8e9d-11eb-3205-c1f58cac9b34
f(1)

# ╔═╡ ed7a9ade-8e9d-11eb-0793-379a695cfbdd
f(1.0)

# ╔═╡ 034b9626-8e9e-11eb-19e9-69e8979b480f
f(1, 2)

# ╔═╡ 0c1aced0-8e9e-11eb-0915-c9b5887e6beb
md"""
## Composite Types

Composite types are composition of other type of data, we can define our own composite types to create an abstraction
"""

# ╔═╡ 27df65ec-8e9e-11eb-3942-efa2aa12ea47
struct Person
	name::String
	age::Int
end

# ╔═╡ 31b00b96-8e9e-11eb-2f97-35ba8a796dfe
md"""
here `struct` creates an **immutable** type called `Person` that contains two fields `name` and `age`, by **immutable** we mean the instance of such type cannot mutate is fields.
"""

# ╔═╡ 48ed15ea-8e9e-11eb-1c6e-c5dc33a5b64f
me = Person("Roger", 25)

# ╔═╡ ab86757a-8e9e-11eb-2cdb-b382a39980c8
md"""
If your TA Ejaaz wants to change the name to his, it will error:
"""

# ╔═╡ 70b2eeec-8e9e-11eb-2d1b-bd58953e23fa
me.name = "Ejaaz"

# ╔═╡ 7fe242f0-8e9e-11eb-112f-89a3e3f9deff
md"""
This is useful to prevent programmers from mutating certain fields by accident, it is always a good practice to declare things to be **immutable** if the object won't be mutated

However, if you need to mutate the object afterwards, you can declare it as
"""

# ╔═╡ d4f2e470-8e9e-11eb-2968-d9df58079088
mutable struct Salary
	amount::Real
end

# ╔═╡ fb3f5564-8e9e-11eb-1e2d-65eeb023c79a
mysalary = Salary(120.0)

# ╔═╡ 0628776c-8e9f-11eb-05b5-e5708ebb2f81
mysalary.amount = 300

# ╔═╡ 0d339d8e-8e9f-11eb-3c3d-a36ce456314f
mysalary

# ╔═╡ 1ac4a3c8-8e9f-11eb-0d59-4beb79165dce
md"""
# Abstract Types

Sometimes you may have a few types that have similar properties, then you could define an abstract type for them, and let your concrete types to subtype from it
"""

# ╔═╡ 219876ea-8ea0-11eb-0be5-877e04a796b2
abstract type Animal end

# ╔═╡ 73a7dda4-8ea0-11eb-2a21-319c04b4e76d
md"""
and we can have a `Cat` type that is a subtype of `Animal`
"""

# ╔═╡ 80d86da2-8ea0-11eb-21e0-13174e6914ea
struct Cat <: Animal
	name::String
end

# ╔═╡ 84cd7b02-8ea0-11eb-3877-6bf6ed736336
md"""
here the operator `<:` means "subtype of" and similarly a `Dog` type
"""

# ╔═╡ 9eb515a4-8ea0-11eb-3907-19a21e6a3284
struct Dog <: Animal
	name::String
	belongsto::Person
end

# ╔═╡ a9ff885c-8ea0-11eb-1e04-e9863bdc2ad5
md"""
and we know all the `Animal`s speak something, so we can declare a function `speak` without a method implemented first
"""

# ╔═╡ bfcc792e-8ea0-11eb-314e-3db7e02e4fea
function speak end

# ╔═╡ d229fd44-8ea0-11eb-2e6b-bdd201d78923
md"""
we know how `Cat` speaks "meow"
"""

# ╔═╡ dcc95a10-8ea0-11eb-0313-151c0569da8d
speak(::Cat) = "meow"

# ╔═╡ ea530fa0-8ea0-11eb-0848-754126df85a6
md"""
and dog barks
"""

# ╔═╡ ff3a9398-8ea0-11eb-0e8e-e77a7d5ca2c0
speak(::Dog) = "bark"

# ╔═╡ 0d436aa0-8ea1-11eb-289a-191346b662c8
md"""
and we assume all the subtype of `Animal` has a field `name`, if a specific type does not have the field `name`, we can later overload the `name` function for it.
"""

# ╔═╡ 20c63966-8ea1-11eb-17dc-c7099ed1b239
name(x::Animal) = x.name

# ╔═╡ 39d6f102-8ea1-11eb-26b8-3bfd382b9347
md"""
now since we know the name of an animal and what it speaks, without knowing the specific object, we can define a method as following
"""

# ╔═╡ 8ef9d29e-8ea1-11eb-3997-695badb02d48
who_speaks_what(x::Animal) = "$(name(x)) speaks $(speak(x))"

# ╔═╡ f94dca4e-8ea1-11eb-3b04-5b2c79fc37bb
md"""
here, the `$` operator means string interpolation, we use it to insert the return value of `name(x)` and `speak(x)` into a string
"""

# ╔═╡ a0b81c16-8ea1-11eb-2f29-b14299f72021
who_speaks_what(Cat("Kitty"))

# ╔═╡ ab89224a-8ea1-11eb-3a3f-332bb716a224
md"""
this is called **generic programming**, we will later introduce its power in a concrete physics problem
"""

# ╔═╡ 39adb89c-8ea2-11eb-1246-7d550ddd737f
md"""
## Parameterized Types

we now are able to implement a function without knowing a concrete type by using an abstract type, however, what if we want to define an object without knowing its concrete type? e.g
the complex number `Complex` is the composition of two real numbers, the real number can be an integer, a floating point or even a symbolic value.

With this motivation, we introduce the parameterized type for defining **generic types**.

A Julia type can be parameterized using braces `{}`, and we can define a type variable `T` that is upbounded by `Real`, which means type `T` must be subtype of the abstract type `Real`
"""

# ╔═╡ a4d56714-8ea2-11eb-3d6d-4d0726879e74
struct MyNaiveComplex{T <: Real} <: Number
	real::T
	imag::T
end

# ╔═╡ 3571c524-8ea3-11eb-28e4-db4dddbaf8db
md"""
we can create a concrete object by filling the corresponding values
"""

# ╔═╡ 4849d286-8ea3-11eb-0d80-3f30d7d4ac50
MyNaiveComplex(1.0, 2.0)

# ╔═╡ 4e495a26-8ea3-11eb-0b17-d9d1256b53ca
md"the Julia compiler will automatically infer that `T` is actually `Float64`"

# ╔═╡ b273822e-8ea3-11eb-2f18-27307a2bd565
md"we can define some functions on this type without knowing what is `T`"

# ╔═╡ c0342cb0-8ea3-11eb-1f18-072f68fa57f4
myreal(x::MyNaiveComplex) = x.real

# ╔═╡ d0dafa26-8ea3-11eb-270e-33b9a1457e04
myimag(x::MyNaiveComplex) = x.imag

# ╔═╡ 5986463c-8ea4-11eb-334d-9d09ad119cdd
md"""
## Pretty Printing

as you have noticed, the printing of our custom types looks ugly, we can define our own pretty printing to make things look better
"""

# ╔═╡ 79e1f7d2-8ea4-11eb-2328-f186849eca74
Base.show(io::IO, x::MyNaiveComplex) = print(io, x.real, "+", x.imag, "im")

# ╔═╡ a5f35578-8ea4-11eb-2f5a-256eb27a49b0
md"here we overloads a builtin Julia function `show` in module `Base` to customize the printing for our own composite type"

# ╔═╡ 90bd7f9e-8ea4-11eb-2c52-e91178c599c3
MyNaiveComplex(1.0, 2.0)

# ╔═╡ 98898fa6-8ea4-11eb-334a-71a88a70f74d
md"in Julia, we use `im` to represent the imaginary unit"

# ╔═╡ f6f429e8-8ea4-11eb-2ae8-33005a4e501a
md"""
## Simple Symbolic Computing

now we know what is pretty printing, we can implement a very simple symbolic computing program


first we define an abstract type `SymExpr` for symbolic expression
"""

# ╔═╡ d9f4f198-8ea8-11eb-1edd-a1f051464aae
abstract type SymExpr end

# ╔═╡ ec32967c-8ea9-11eb-3eac-753f07be2e97
md"and we define a `Variable` type to represent a symbolic variable, it contains a field called `value`"

# ╔═╡ a3301890-8ea8-11eb-288c-b7d78bfdbf4b
struct Variable <: SymExpr
	value
end

# ╔═╡ 0e37132c-8eaa-11eb-22fc-9fb1db8f20be
md"we define a symbolic term type to represent composite symbolic terms, in general an symbolic term is in fact a function call, so we store the corresponding function and its arguements to represent a symbolic term"

# ╔═╡ ad7279ec-8ea8-11eb-080a-6fb902f16957
struct Term{F} <: SymExpr
	f::F
	args::Vector{Any}
end

# ╔═╡ 37424cbe-8eaa-11eb-0fe1-a5a33c53dddb
md"here we use a type parameter `F` to dispatch on the function later since we may need to handle the expression differently for different functions, e.g we can define a `+` function as following"

# ╔═╡ c010c8ce-8ea8-11eb-1d63-a3f0d2a406e8
Base.:(+)(x::SymExpr, y::SymExpr) = Term(+, Any[x, y])

# ╔═╡ 5b3136e4-8eaa-11eb-2773-55bd7d580e77
md"now we can try to add up some symbolic variables"

# ╔═╡ f253efd0-8ea8-11eb-0f0f-7792d68a57a2
Variable(:x) + Variable(:y) + Variable(:z)

# ╔═╡ 663303a6-8eaa-11eb-07f2-b9c74b621ef8
md"however this doesn't work if we have some constants"

# ╔═╡ 7d3f01da-8eaa-11eb-3812-fb6378a04d3f
Variable(:x) + Variable(:y) + 1

# ╔═╡ 8972ad58-8eaa-11eb-3c6b-e786c2764313
md"thus we need to overload for constant numbers, for simplicity, we only handle real numbers here。"

# ╔═╡ d1fb0f04-8ea8-11eb-1d9e-2baecef5a3d0
Base.:(+)(x::SymExpr, y::Real) = Term(+, Any[x, y])

# ╔═╡ b778ee60-8eaa-11eb-0984-47151aa5d7d3
md"because `+` operation on real numbers is communitive, we need to define it for the other order"

# ╔═╡ 0be349e8-8ea9-11eb-09fb-0b5d8c1f3642
Base.:(+)(x::Real, y::SymExpr) = Term(+, Any[x, y])

# ╔═╡ d81f8142-8eaa-11eb-2d8f-59f6393a3aa2
md"OK now this works!"

# ╔═╡ dd7dde40-8eaa-11eb-20fb-1541507c6bea
Variable(:x) + Variable(:y) + 1

# ╔═╡ a435b978-8eaa-11eb-08af-dfe9a3cecb46
md"now let's define a pretty printing to make it looks better"

# ╔═╡ 3a092504-8ea9-11eb-3117-033359cf9b73
Base.show(io::IO, x::Variable) = print(io, x.value)

# ╔═╡ 49b9d1a6-8ea9-11eb-2231-73d83734b41f
function Base.show(io::IO, x::Term{typeof(+)})
	for each in x.args[1:end-1]
		print(io, each, "+")
	end
	print(io, x.args[end])
end

# ╔═╡ 7281760c-8ea9-11eb-05b5-7d65a60c601d
Variable(:x) + Variable(:y) + Variable(:z) + 1

# ╔═╡ e5eb3738-8eaa-11eb-18f3-314a142a7429
md"""
the above program defines a very simple symbolic program, it does *no actual calculation* so far, but just record what we do using a tree data structure,
in some places, you may heard people call this tree structure as abstract/concrete syntax tree or algebra data type. We will later explore automatic differentiation
using this.
"""

# ╔═╡ 9d2f7258-8e9c-11eb-23ca-cf11c2a331d8
md"""
## Package management

Julia carries its own package manager, you can use it as a normal package:

```julia
julia> using Pkg
```

to install a pacakge, you can use

```julia
julia> Pkg.add("Yao")
```

to remove a pacakge, you can use

```julia
julia> Pkg.rm("Yao")
```
"""

# ╔═╡ e7064866-8e9c-11eb-0af6-85bdfd62fd8b
md"""
If you are using a REPL, there is a convenient Pkg mode to let you install packages directly. You can enter the Pkg mode by typing `]` key like how we install the Pluto package previously
"""

# ╔═╡ ec8c1dc4-8e9c-11eb-1881-7342f68b79a2
md"""
## Environments

All Julia program **runs inside an environment**, it is the global environment by default. It is usually recommended to run your notebook in a local environment, so we won't hit any version conflicts between different packages.
we will introduce this part more when we write our own automatic differentiation engine.
"""

# ╔═╡ Cell order:
# ╠═f1aa59ae-8e94-11eb-12bc-3b1d9ccc314b
# ╠═cc2cf6c0-8e92-11eb-1255-53074ed0e59c
# ╟─7400844c-8e8f-11eb-27d0-859ea6dba632
# ╟─de79e82c-8e8f-11eb-0513-c7df38cb3d30
# ╟─03a8af1e-8e90-11eb-2d94-e52e8c2be959
# ╟─61a2883a-8e90-11eb-26bb-49925c4ad4e9
# ╟─b039ac32-8e90-11eb-08ec-8710712591f7
# ╟─d9287bda-8e90-11eb-1c46-af0555ed5158
# ╟─232da2be-8e91-11eb-3289-0d9bf19a225e
# ╟─e17692c6-8e91-11eb-3573-c98d429a5403
# ╟─363accfa-8e92-11eb-1a5b-6fac3df0290c
# ╟─c9959dd6-8e92-11eb-04ed-7b8ee3717c28
# ╟─9bfff004-8e8f-11eb-0a21-1db0b13d1b12
# ╟─7028360e-8e93-11eb-0ab6-3f50c4f864a5
# ╟─923c58a6-8e93-11eb-15cd-f7cac665afad
# ╟─74e8356e-8e97-11eb-1d7f-29b54ca49dc4
# ╟─30267782-8e98-11eb-368a-15bac39281cf
# ╟─65c1388e-8e98-11eb-036e-6be0f9ceeae8
# ╟─8f7710a2-8e98-11eb-02af-69a34e81c9cf
# ╟─c2b5415e-8e99-11eb-2cbf-c1392fb5075e
# ╟─100a2712-8e9a-11eb-057b-cf84805d9f82
# ╟─1c9fec26-8e9a-11eb-1f50-3512e5f1a36f
# ╟─6fb8a292-8e9a-11eb-3614-2bac1c3c7ebc
# ╟─767c63dc-8e9a-11eb-299d-257d7d961df2
# ╟─bd5bc9d6-8e98-11eb-2bb4-4bc600b4e887
# ╟─9d29f678-8e99-11eb-2fac-595bd3335f64
# ╟─51920c44-8e9b-11eb-2ffa-6bb90b32cb76
# ╠═65b492d2-8e9b-11eb-1f7e-6ff3d12b2acc
# ╟─83192d6a-8e9b-11eb-2b3a-e7d120398f48
# ╠═b3e93bda-8e9b-11eb-177f-c3e6006a3409
# ╟─b8dfa5c0-8e9b-11eb-3378-51fe3adafa47
# ╠═c662d416-8e9b-11eb-3309-abf865336ab6
# ╟─ccfa44fa-8e9b-11eb-2d50-79ad7c21f35e
# ╠═dd27a734-8e9b-11eb-10cd-697750fc8d3c
# ╟─e8ae462e-8e9b-11eb-2910-b38ea3de5252
# ╠═eecc7206-8e9b-11eb-0b13-b7f613eb974d
# ╠═f2ba5414-8e9b-11eb-2941-277569b5be73
# ╟─faa11e56-8e9b-11eb-0a29-2b33770da084
# ╠═018a5106-8e9c-11eb-0d13-a5542c3fcd4b
# ╟─0a93166e-8e9c-11eb-2fd5-1d80e13be555
# ╠═1645283c-8e9c-11eb-204c-d93911df6dfa
# ╟─1f7ca574-8e9c-11eb-19f8-931e6de060ed
# ╠═2db39ddc-8e9c-11eb-302a-890b52609e00
# ╟─33cddbd0-8e9c-11eb-02cc-5fbfbc0f4037
# ╠═3c08b980-8e9c-11eb-3b35-3d8f254d4e4f
# ╟─44cfe19e-8e9c-11eb-311b-3119586254e7
# ╠═4b2e285a-8e9c-11eb-3fb2-23dc7a5652d8
# ╟─53388a2c-8e9c-11eb-3ceb-7100da65a4a0
# ╠═65cf20ae-8e9c-11eb-20f1-9dd4f08a8103
# ╟─6aa77704-8e9c-11eb-22ac-bdbd3d23583b
# ╠═70be63f2-8e9c-11eb-35b6-3b8f3bffa0f4
# ╟─7722da64-8e9c-11eb-3c4d-d98f275cb706
# ╠═8166d48c-8e9c-11eb-2032-cb423df0bd61
# ╟─86253606-8e9c-11eb-271c-9950a3ffcd90
# ╟─bc6678a0-8e9d-11eb-006b-4766c2f47db9
# ╠═dec6a71c-8e9d-11eb-29a4-cdfd1c27c01b
# ╠═e43bfe90-8e9d-11eb-3f8d-d5fd9b5d96cc
# ╠═ead8e42a-8e9d-11eb-3205-c1f58cac9b34
# ╠═ed7a9ade-8e9d-11eb-0793-379a695cfbdd
# ╟─f518b756-8e9d-11eb-2153-3f8b7bad9e26
# ╠═fe2103dc-8e9d-11eb-2b6e-e73204feef2b
# ╠═034b9626-8e9e-11eb-19e9-69e8979b480f
# ╟─0c1aced0-8e9e-11eb-0915-c9b5887e6beb
# ╠═27df65ec-8e9e-11eb-3942-efa2aa12ea47
# ╟─31b00b96-8e9e-11eb-2f97-35ba8a796dfe
# ╠═48ed15ea-8e9e-11eb-1c6e-c5dc33a5b64f
# ╟─ab86757a-8e9e-11eb-2cdb-b382a39980c8
# ╠═70b2eeec-8e9e-11eb-2d1b-bd58953e23fa
# ╟─7fe242f0-8e9e-11eb-112f-89a3e3f9deff
# ╠═d4f2e470-8e9e-11eb-2968-d9df58079088
# ╠═fb3f5564-8e9e-11eb-1e2d-65eeb023c79a
# ╠═0628776c-8e9f-11eb-05b5-e5708ebb2f81
# ╠═0d339d8e-8e9f-11eb-3c3d-a36ce456314f
# ╟─1ac4a3c8-8e9f-11eb-0d59-4beb79165dce
# ╠═219876ea-8ea0-11eb-0be5-877e04a796b2
# ╟─73a7dda4-8ea0-11eb-2a21-319c04b4e76d
# ╠═80d86da2-8ea0-11eb-21e0-13174e6914ea
# ╟─84cd7b02-8ea0-11eb-3877-6bf6ed736336
# ╠═9eb515a4-8ea0-11eb-3907-19a21e6a3284
# ╟─a9ff885c-8ea0-11eb-1e04-e9863bdc2ad5
# ╠═bfcc792e-8ea0-11eb-314e-3db7e02e4fea
# ╟─d229fd44-8ea0-11eb-2e6b-bdd201d78923
# ╠═dcc95a10-8ea0-11eb-0313-151c0569da8d
# ╟─ea530fa0-8ea0-11eb-0848-754126df85a6
# ╠═ff3a9398-8ea0-11eb-0e8e-e77a7d5ca2c0
# ╟─0d436aa0-8ea1-11eb-289a-191346b662c8
# ╠═20c63966-8ea1-11eb-17dc-c7099ed1b239
# ╟─39d6f102-8ea1-11eb-26b8-3bfd382b9347
# ╠═8ef9d29e-8ea1-11eb-3997-695badb02d48
# ╟─f94dca4e-8ea1-11eb-3b04-5b2c79fc37bb
# ╠═a0b81c16-8ea1-11eb-2f29-b14299f72021
# ╟─ab89224a-8ea1-11eb-3a3f-332bb716a224
# ╟─39adb89c-8ea2-11eb-1246-7d550ddd737f
# ╠═a4d56714-8ea2-11eb-3d6d-4d0726879e74
# ╟─3571c524-8ea3-11eb-28e4-db4dddbaf8db
# ╠═4849d286-8ea3-11eb-0d80-3f30d7d4ac50
# ╟─4e495a26-8ea3-11eb-0b17-d9d1256b53ca
# ╟─b273822e-8ea3-11eb-2f18-27307a2bd565
# ╠═c0342cb0-8ea3-11eb-1f18-072f68fa57f4
# ╠═d0dafa26-8ea3-11eb-270e-33b9a1457e04
# ╟─5986463c-8ea4-11eb-334d-9d09ad119cdd
# ╠═79e1f7d2-8ea4-11eb-2328-f186849eca74
# ╟─a5f35578-8ea4-11eb-2f5a-256eb27a49b0
# ╠═90bd7f9e-8ea4-11eb-2c52-e91178c599c3
# ╟─98898fa6-8ea4-11eb-334a-71a88a70f74d
# ╟─f6f429e8-8ea4-11eb-2ae8-33005a4e501a
# ╠═d9f4f198-8ea8-11eb-1edd-a1f051464aae
# ╟─ec32967c-8ea9-11eb-3eac-753f07be2e97
# ╠═a3301890-8ea8-11eb-288c-b7d78bfdbf4b
# ╟─0e37132c-8eaa-11eb-22fc-9fb1db8f20be
# ╠═ad7279ec-8ea8-11eb-080a-6fb902f16957
# ╟─37424cbe-8eaa-11eb-0fe1-a5a33c53dddb
# ╠═c010c8ce-8ea8-11eb-1d63-a3f0d2a406e8
# ╟─5b3136e4-8eaa-11eb-2773-55bd7d580e77
# ╠═f253efd0-8ea8-11eb-0f0f-7792d68a57a2
# ╟─663303a6-8eaa-11eb-07f2-b9c74b621ef8
# ╠═7d3f01da-8eaa-11eb-3812-fb6378a04d3f
# ╟─8972ad58-8eaa-11eb-3c6b-e786c2764313
# ╠═d1fb0f04-8ea8-11eb-1d9e-2baecef5a3d0
# ╟─b778ee60-8eaa-11eb-0984-47151aa5d7d3
# ╠═0be349e8-8ea9-11eb-09fb-0b5d8c1f3642
# ╟─d81f8142-8eaa-11eb-2d8f-59f6393a3aa2
# ╠═dd7dde40-8eaa-11eb-20fb-1541507c6bea
# ╟─a435b978-8eaa-11eb-08af-dfe9a3cecb46
# ╠═3a092504-8ea9-11eb-3117-033359cf9b73
# ╠═49b9d1a6-8ea9-11eb-2231-73d83734b41f
# ╠═7281760c-8ea9-11eb-05b5-7d65a60c601d
# ╟─e5eb3738-8eaa-11eb-18f3-314a142a7429
# ╟─9d2f7258-8e9c-11eb-23ca-cf11c2a331d8
# ╟─e7064866-8e9c-11eb-0af6-85bdfd62fd8b
# ╟─ec8c1dc4-8e9c-11eb-1881-7342f68b79a2
