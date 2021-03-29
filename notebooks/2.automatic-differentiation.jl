### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 166bbbb2-8f7a-11eb-19c6-19dfe8ee5123
using ChainRules

# ╔═╡ a8439cf0-8eab-11eb-3d6b-a3d65e46a635
md"""
# Automatic Differentiation (AD)

Automatic differentiation is a method to evaluate the derivatives of a given program, you may heard this in context of deep learning as back-propagation. However, in more general scientific machine learning, the situation can be more complicated, thus it'd be necessary to understand better about the mechanism of automatic differentiation.

In this section, we will introduce the automatic differentiation technique in a more systematic aspect
"""

# ╔═╡ 12cb96f8-8f48-11eb-212d-956d24e7a892
md"""
# Dual Numbers

Dual number is the simplest way of implementing AD. And thanks to Julia's powerful generic programming features, we can easily implement one ourselves!

**definition** define ``ϵ`` to satisfy ``ϵ^2 = 0``, then similar to a complex number we define dual number as ``x = a + b ⋅ ϵ``

then we can intermediately get the rule of multiplication

```math
(a + b⋅ϵ)(c + d⋅ϵ) = ac + (ad + bc)ϵ
```

thus we can implement our own dual number as following
"""

# ╔═╡ af43976a-8f48-11eb-1485-0b76c7ee1e79
begin
	struct Dual{T<:Real} <: Real
		a::T
		b::T
	end
	
	Dual(a) = Dual(a, one(a))
end

# ╔═╡ d1522092-8f48-11eb-30f2-f9c3183ae364
Base.show(io::IO, x::Dual) = print(io, x.a, "+", x.b, "ϵ")

# ╔═╡ e0a6fe78-8f48-11eb-152f-5b448f08fc49
Dual(2)

# ╔═╡ e4fbb1f8-8f48-11eb-220e-f33784f6e617
Base.:(*)(x::Dual, y::Dual) = Dual(x.a * y.a, x.a * y.b + x.b * y.a)

# ╔═╡ 25669170-8f4b-11eb-1cae-a78fc79be709
Base.:(+)(x::Dual, y::Dual) = Dual(x.a + y.a, x.b + y.b)

# ╔═╡ 0c7cdab8-8f49-11eb-3bac-2de9b80bb7d0
Dual(3, 1) * Dual(3, 1)

# ╔═╡ 82b578de-8f49-11eb-13dd-aba04a2c196d
md"now let's define a simply function see what happens if we instead of feeding a normal real number, we feed in a dual number"

# ╔═╡ 28b6ea34-8f49-11eb-2625-d58fbfba667f
f(x) = x^3

# ╔═╡ 9f7849bc-8f49-11eb-0f59-1bdf987ecdfe
f(Dual(2))

# ╔═╡ a7d73bb6-8f49-11eb-2c45-99fbd3a2c248
md"""
the prefactor of ϵ gives the derivative! let's see why

given a real polynomail

```math
P(x) = p_0 + p_1 x + p_2 x^2 + ⋯ + p_n x^n
```

if we put a dual number ``x = a + b ϵ``, we have

```math
\begin{aligned}
P(a+bϵ) 
&= p_0 + p_1 a + p_2 a^2 + ⋯ + p_n a^n + p_1 bϵ + 2p_2 abϵ + ⋯ + n p_n a^{n-1}b ϵ\\
&= P(a) + b P'(a)ϵ
\end{aligned}
```

more generally, using Taylor series, this is also true for any real analytical functions. 

However, if we plugin our dual number into functions like `sin`, it doesn't work
"""

# ╔═╡ 8a4b5ec8-8f4a-11eb-1155-f358a173daa2
sin(Dual(2))

# ╔═╡ 94bc3b16-8f4a-11eb-0871-59f5469f4c0e
md"""
this is because in practical numerical program, for efficiency, a lot mathematical functions are implemented specifically for floating point type, thus we don't have a generic function for these functions to make things "just work"

thus we will need to define the derivative of `sin` manually here
"""

# ╔═╡ cfdb25b6-8f4a-11eb-2248-3f7783956f35
Base.sin(x::Dual) = Dual(sin(x.a), cos(x.a) * x.b)

# ╔═╡ de6df808-8f4a-11eb-0f70-43400519fd6f
sin(Dual(2))

# ╔═╡ f2b1a960-8f4a-11eb-1276-b333b086605c
md"however if we happen to have a function definition on generic types, e.g the matrix multiplication, this will just work"

# ╔═╡ 0906c78e-8f4b-11eb-1d3b-dd8d6d891175
A = [Dual(1.0) Dual(2.0); Dual(1.0) Dual(2.0)]

# ╔═╡ 149734d0-8f4b-11eb-0af4-6368d8bb34c0
B = [Dual(1.0) Dual(2.0); Dual(1.0) Dual(3.0)]

# ╔═╡ 1a483212-8f4b-11eb-0fa5-5994548ea6b9
A * B

# ╔═╡ f4228cb2-8eab-11eb-1b98-fbb30f8eeac3
md"""
# Forward Mode AD

The forward mode AD is the simplest way of implementing an AD system. The above dual number is one way to implement forward mode AD with a generic type system.

More formally, we say forward mode AD is to apply the chain rule on primal derivatives
when we evaluate the value of an expression, e.g if we are going to evaluate the following function
"""

# ╔═╡ c6d79168-8f4f-11eb-1c4f-4bf4abbb2c72
function foo(x)
	x1 = sin(x)
	x2 = sin(x1)
	x3 = cos(x2) + x2
end

# ╔═╡ d2f7c68e-8f4f-11eb-0d90-4f2f22bd87b6
md"""
when we put in a dual number we actually do the following things:

1. evaluate `sin(x)` and its derivative, store them in `x1`
2. evaluate `sin(x1)` and its derivative, multiply the derivative of `sin(x1)` to previous derivative since we have ``P'(x)b ϵ`` term in the dual number
3. evaluate the derivative of `cos(x2)` and do the same thing as above, but let's call the intermediate value of `cos(x2)` to be `y`
4. evaluate the value of `y+x2` and derivative then multiply and store them in `x3`

thus we see every time we evaluate the derivative, we can throw away the variables we calculated before, but for every single scalar number we need to calculate the entire function, as a result, this gives us the time complexity $O(mn)$ where $n$ is the number of parameters and $m$ is the complexity of the original code.

the memory complexity is $O(m+n)$ where $m$ is the memory complexity of the original code
"""

# ╔═╡ f75c7e22-8f52-11eb-0b32-f9ed6267fb18
md"""
to formalize the above process in terms of chain rule, the forward mode means we evaluate the derivatives in the following accumulation:

```math
\begin{aligned}
\frac{\partial y_n}{\partial x}
&= \frac{\partial y_n}{\partial y_{n-1}} \frac{\partial y_{n-1}}{\partial x}\\
&= \frac{\partial y_n}{\partial y_{n-1}} (\frac{\partial y_{n-1}}{\partial y_{n-2}} \frac{\partial y_{n-2}}{\partial x})\\
&= \cdots\\
&= \frac{\partial y_n}{\partial y_{n-1}} (\frac{\partial y_{n-1}}{\partial y_{n-2}} \cdots (\frac{\partial y_2}{\partial y_1} \frac{\partial y_1}{\partial x}))
\end{aligned}
```

"""

# ╔═╡ 9ef95826-8f53-11eb-11ed-a35e16d20083
md"""
we can further generalize this to multi-variable case using Jacobians

```math
\begin{aligned}
\frac{\partial \vec{y}_n}{\partial x}
&= \frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}} \frac{\partial \vec{y}_{n-1}}{\partial x}\\
&= \frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}} (\frac{\partial \vec{y}_{n-1}}{\partial \vec{y}_{n-2}} \frac{\partial \vec{y}_{n-2}}{\partial x})\\
&= \cdots\\
&= \frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}} (\frac{\partial \vec{y}_{n-1}}{\partial \vec{y}_{n-2}} \cdots (\frac{\partial \vec{y}_2}{\partial \vec{y}_1} \frac{\partial \vec{y}_1}{\partial x}))
\end{aligned}
```
"""

# ╔═╡ 0e07a38e-8f55-11eb-0c46-ef5d11df07de
md"""
now we see to calculate the derivative of ``\frac{\partial \vec{y}_n}{\partial x}`` it is actually about calculatnig a chain of **Jacobian-vector product**
"""

# ╔═╡ 13c539e8-8eac-11eb-35b0-61108d5f3c5f
md"""
# Reverse Mode AD

For large number of parameters, reverse mode is more efficient. This method has been re-discovered many times in history in different fields, you may hear it called back-propagation in context of deep learning.
"""

# ╔═╡ 45826916-8f55-11eb-3f3c-95d6b601191b
md"""
similar to forward mode AD, the reverse mode AD is actually about calculating the chain rule in the following accumulation:

```math
\begin{aligned}
\frac{\partial \vec{y}_n}{\partial x}
&= (\frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}}) \frac{\partial \vec{y}_{n-1}}{\partial x}\\
&= ((\frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}}) \frac{\partial \vec{y}_{n-1}}{\partial \vec{y}_{n-2}}) \frac{\partial \vec{y}_{n-2}}{\partial x}\\
&= ⋯\\
&= (\cdots ((\frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}}) \frac{\partial \vec{y}_{n-1}}{\partial \vec{y}_{n-2}}\cdots \frac{\partial \vec{y}_2}{\partial \vec{y}_1}) \frac{\partial \vec{y}_1}{\partial x}\\
(\frac{\partial \vec{y}_n}{\partial x})^T &= (\frac{\partial \vec{y}_1}{\partial x})^T (\frac{\partial \vec{y}_2}{\partial \vec{y}_1})^{T} \cdots (\frac{\partial \vec{y}_{n-1}}{\partial \vec{y}_{n-2}})^T (\frac{\partial \vec{y}_n}{\partial \vec{y}_{n-1}})^T
\end{aligned}
```

thus the reverse mode automatic differentiation is acutally about **Jacobian-transpose-vector product**. 

We can see an intermediate advantage of this accumulation is that if ``x`` is a vector, we can directly calculate the derivative of this vector by a chain of matrix multiplication.
"""

# ╔═╡ e026ffa6-8f5f-11eb-0651-dfb9e28fcc4f
md"""
this process will be easier to understand if we use a graphical language to describe it, this the **computational graph**, to demonstrate this better, I'll use a more complicated function

```math
y = \mathbf{x}^T\mathbf{A}\mathbf{x} + \mathbf{b}\cdot\mathbf{x} + c
```
"""

# ╔═╡ 10ba0d9c-8f5f-11eb-0744-6be46cfacebe
md"""
We will need to call several functions in Julia to get the result $y$, which is

1. ``\mathbf{z_1} = \mathbf{x}^T``: `transpose` function.
2. ``\mathbf{z_2} = \mathbf{z_1} A`` matrix-vector multiplication, which can be `gemv` in `LinearAlgebra.BLAS`, or just `*`.
3. ``y_1 = \mathbf{z_2} \mathbf{x}`` vector dot operation, which is `LinearAlgebra.dot` or the UTF-8 operator `x ⋅ y`
4. ``y_2 = \mathbf{b} \cdot \mathbf{x}`` another vector dot
5. ``y_1 + y_2 + c`` a scalar add function, one can calculate it by simply calling `+` operator in Julia.

In fact, we can draw a graph of this expression, which illustrates the relationship between each variable in this expression.
Each node in the graph with an output arrow represents a variable and each node with an input arrow represents a function/operator.

![](https://blog.rogerluo.me/images/comput-graph-forward.gif)

The evaluation of the math equation above can then be expressed as a process called **forward evaluation**, it starts from the leaf nodes, which represents the inputs of the whole expression, e.g they are $\mathbf{x}, \mathbf{A}, \mathbf{b}, c$ in our expression. Each time, we receive the value of a node in the graph, we mark the node with **green**.
"""

# ╔═╡ 4921f4f8-8f60-11eb-0e45-3f3034dbea83
md"""
the derivative calculation can be then visualized as following

![](https://blog.rogerluo.me/images/comput-graph-backward.gif)
"""

# ╔═╡ 29fa38b6-8f61-11eb-118a-616fc647715a
md"""
as we demonstrate above, although the reverse mode can calculate the derivatives for all the parameters in single evaluation. it will need to store the intermediate values.

thus we need a specific data structure to store these values， this data structure is often called the computational graph, tape or Wengert list.

Now the problem of implementing reverse mode AD becomes how to create the tape.
"""

# ╔═╡ 0580566c-8ff4-11eb-35a3-bf0505fe5a1c
md"""
# Relation with Differential Geometry

Since we have represented our AD algorithm as Jacobian or Jacobian transpose product, it is natural to have a geometric interpretation of them.

## Definitions

Let ``p`` be a point in the space ``\mathbf{M}`` defined by ``(x_1, x_2, ⋯, x_m)``, and we have a function ``f: \mathbf{M} → \mathbf{K}`` that is a smooth map (differentiable everywhere), then we can define the **tangent space** ``\mathbf{T}_p \mathbf{M}`` at point ``p`` as the space span by the derivatives ``\frac{d}{dx}``, the tangent space acts linearly on the space of functions. 

Now we define **the collection of the tangent spaces** ``\mathbf{T}_p\mathbf{M}`` for ``p ∈ \mathbf{M}`` as the **tangent bundle** of ``\mathbf{M}``

![tangent space](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Tangentialvektor.svg/200px-Tangentialvektor.svg.png)

let ``df`` denotes the first order information of ``f`` at each point, which is called the **differential** of ``f``. If the derivative of ``f`` and ``g`` agree at ``p``, we say that ``df`` and ``dg`` represents the same cotangent at ``p``. The covectors ``dx_1, dx_2, ⋯, dx_m`` form the basis of the cotangent space ``\mathbf{T}^*_p \mathbf{M}`` for ``p∈\mathbf{M}``

**push-forward**

![](https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Pushforward.svg/330px-Pushforward.svg.png)

**pullback**

![](https://www.mathphysicsbook.com/wp-content/uploads/2013/10/39.pullback-v2.png)
"""

# ╔═╡ eb4df5e4-8f79-11eb-2429-a31bd0009c4b
md"""
## the manual AD

so we can do reverse mode "automatic" differentiation manually first, to have a feeling about it. 

We will use the package `ChainRules` here.
"""

# ╔═╡ 72b98a42-8ff8-11eb-17f3-6d14da3964be
x = 3.0

# ╔═╡ 1a78b2be-8f7a-11eb-0470-e7febaac6272
y, sin_pullback = rrule(sin, x)

# ╔═╡ 627f170a-8ff8-11eb-21eb-47796905e10b
sin_pullback(1)

# ╔═╡ 67c7f3d0-8ff8-11eb-04dc-4f796cfb940e
cos(x)

# ╔═╡ 7cffb62a-8ff8-11eb-0288-f55b0d333571
md"""
now we can manually generate the pullback function for a given function defined on some primal functions, in AD, we usually call these functions **adjoint**s.

let's use the previous example `foo` here
"""

# ╔═╡ 98d147c4-8ff8-11eb-3ab8-21e26217e02a
function adjoint_foo(x)
	x1, x1_pullback = rrule(sin, x)
	x2, x2_pullback = rrule(sin, x1)
	y, y_pullback = rrule(cos, x2)
	x3, x3_pullback = rrule(+, y, x2)
	
	return x3, function pullback(Δ)
		_, ∂y, ∂x2_1 = x3_pullback(Δ)
		_, ∂x2_2 = y_pullback(∂y)
		_, ∂x1 = x2_pullback(∂x2_1 + ∂x2_2)
		_, ∂x = x1_pullback(∂x1)
		return Zero(), ∂x
	end
end

# ╔═╡ 8e593406-8ff9-11eb-101a-695b2b026a20
_, foo_pullback = adjoint_foo(x)

# ╔═╡ 9e31a492-8ff9-11eb-108d-1b7bbd152170
foo_pullback(1)

# ╔═╡ a21aa0c2-8ff9-11eb-1cc8-7b63a20d0791
(foo(x+1e-10)-foo(x-1e-10))/2e-10

# ╔═╡ c5f14d48-8ff9-11eb-1350-790162aa8b34
md"""
thus the simplest reverse mode AD is about how to create this tiny `pullback` function automatically, and to know how to create this `pullback` function we need to know what primal functions are called by the given function, so that we can simply reverse the order of calls and replace them with the `pullback` functions.
"""

# ╔═╡ 3fc036f8-8eac-11eb-15dc-017c0d5237bc
md"""
## Operator Overloading AD

The easiest way of creating a tape is using operator overloading. By operator overloading, it means the exactly same way we implemented our toy symbolic program in the previous section.

for example, we can define our own type to dispatch the functions to a `track` function so that we can store the function call into a tape.

```julia
mutable struct Variable{T} <: ADExpr
    value::T
    grad::T

    Variable(val::T) where T = new{T}(val)
    Variable(val::T, grad::T) where T = new{T}(val)
end

struct Node{FT <: Function, ArgsT <: Tuple, KwargsT <: NamedTuple} <: ADExpr
    f::FT
    args::ArgsT
    kwargs::KwargsT
end
```

then overload some primal functions to track the call into tape

```
Base.sin(x::ADExpr) = register(Base.sin, x)
```
"""

# ╔═╡ 35cfef70-8ffa-11eb-1a48-e906596eebe6
md"""
I will not demonstrate the details of implementing such AD engine, but once you understand the mechanism, you should be able to write one yourself in mins!

For the curious, checkout my blog post **Implementing Your Own Automatic Differentiation Engine in ONE day**: [https://blog.rogerluo.me/2018/10/23/write-an-ad-in-one-day/](https://blog.rogerluo.me/2018/10/23/write-an-ad-in-one-day/)
"""

# ╔═╡ 73ffb3fe-8ffd-11eb-2b71-038543ea5093
md"""

## What packages/software uses this method?

#### Python

- PyTorch
- autograd
- ...

#### Julia

- Tracker
- YAAD
- Nabla
- ...

"""


# ╔═╡ bd69872c-8f78-11eb-2197-2f760c33b197
md"""

## Limitations

however, the above method **won't work for general programs that contains control flows**. This is because in the representation of Wengert list, or the tape, we don't have the semantic of control flows, and we don't have a way to record control flows using operator overloading, such as `for` loop or `if else` statements.

This is because control flows are not functions in most of the programming languages, we cannot change the control flow behaviour by overloading them on different types, and it may not make sense to do so.

On the other hand, it **won't work for generic programming**, since we have used a specific type to dispatch functions, which kinda "abused" the type system.
"""

# ╔═╡ 46ad0fa2-8eac-11eb-28df-4f2c23f8d3ff
md"""
## Source Code Transformation AD

As you may noticed, in both forward and reverse mode AD, in order to represent intermediate derivatives, we were forced to use a new temperory variable for every function call.

This leads to a special intermediate representation for general programs called the **Static Single Assignment** intermediate representation (SSA IR), by **Static Single Assignment** we mean:

> every variable in the program is only assigned once statically

the control flows in a SSA IR are usually canonicalized to `goto` or `goto ifnot` if it has conditions, since every variable is only assigned once we use `%<name>` or `%<int>` to represent a variable.
"""

# ╔═╡ cbe1949e-8ffc-11eb-0747-e576545133b4
md"""
the SSA IR is a widely used representation in your daily used compilers, for example, your C/C++ compiler clang, or some of your new fancy langauges like Julia, rust and more. This is because SSA IR is a very convenient representation to optimize and analysis.

![](https://slideplayer.com/slide/13900843/85/images/7/C-like+IR+In+SSA+form+x1+%3D+f%28x0%29%3B+x+%3D+f%28x%29%3B+if+%28x1+%3E+y0%29.jpg)
"""

# ╔═╡ 6616ee24-8ffd-11eb-0d13-7f7ea01d3f73
md"""
this is a natural extension of the Wengert list (the tape) with control flows. Thus instead of doing operator overloading, we can directly write a compiler extension to transform the source encoded in SSA IR to the corresponding differential function in SSA IR.

And in Julia, this is extremely easy (in terms of implementing it), because Julia is a dynamic compiled language

![](https://blog.rogerluo.me/images/julia-compile-diagram.png)
"""

# ╔═╡ c5f18fe2-8ffe-11eb-0a96-1f3ce397e943
md"""
# Software/Package uses this method

- **Julia**: Zygote, Enzyme, Yota, Diffractor (work-in-progress), ...
- **Python**: JAX, ...
"""

# ╔═╡ 420d72f4-8ffe-11eb-1b0f-43bdc9edf955
md"""
## Limitations

No limitations in theory.

We have the information about control flows, which means it **will work for control flows**.

We don't need to reply on type system to track the function calls anymore which means it works for **generic programming**

But covering the entire general purpose programming language with most of the corner cases may take years to accomplish.
"""

# ╔═╡ 84e5fe6e-8eac-11eb-04f8-cf7499b2c218
md"""
## Other type of AD engines

There are other type of AD engines that works under some context, such as polynomials, reversible programs, etc.

You can find a full list of AD engines in Julia at [https://juliadiff.org/](https://juliadiff.org/)
"""

# ╔═╡ 4c23d3bc-8eac-11eb-2870-a37dfc123bc5
md"""
## Differentiable Programming in Condensed Matter Physics: Tensor Network

One of the most poplular method in numerical condensed matter physics is the tensor network methods.

Tensor network is also way to approximate the solution, in previous lectures, you have learned how to use neural network states to solve ground state problem using variational Monte Carlo. 

More traditionally physicists have been using tensor network as the physical ansatz. However calculating the gradient of tensor networks can be complicated. Thus, by making use of automatic differentiation, one will be able to do gradient based optimization on tensor network easily.

![](../assets/tensor-network.png)

[https://arxiv.org/pdf/1903.09650.pdf](https://arxiv.org/pdf/1903.09650.pdf)
"""

# ╔═╡ 1ba1fde4-90d3-11eb-2d2a-5f3028b94d64
pwd()

# ╔═╡ Cell order:
# ╟─a8439cf0-8eab-11eb-3d6b-a3d65e46a635
# ╟─12cb96f8-8f48-11eb-212d-956d24e7a892
# ╠═af43976a-8f48-11eb-1485-0b76c7ee1e79
# ╠═d1522092-8f48-11eb-30f2-f9c3183ae364
# ╠═e0a6fe78-8f48-11eb-152f-5b448f08fc49
# ╠═e4fbb1f8-8f48-11eb-220e-f33784f6e617
# ╠═25669170-8f4b-11eb-1cae-a78fc79be709
# ╠═0c7cdab8-8f49-11eb-3bac-2de9b80bb7d0
# ╟─82b578de-8f49-11eb-13dd-aba04a2c196d
# ╠═28b6ea34-8f49-11eb-2625-d58fbfba667f
# ╠═9f7849bc-8f49-11eb-0f59-1bdf987ecdfe
# ╟─a7d73bb6-8f49-11eb-2c45-99fbd3a2c248
# ╠═8a4b5ec8-8f4a-11eb-1155-f358a173daa2
# ╟─94bc3b16-8f4a-11eb-0871-59f5469f4c0e
# ╠═cfdb25b6-8f4a-11eb-2248-3f7783956f35
# ╠═de6df808-8f4a-11eb-0f70-43400519fd6f
# ╟─f2b1a960-8f4a-11eb-1276-b333b086605c
# ╠═0906c78e-8f4b-11eb-1d3b-dd8d6d891175
# ╠═149734d0-8f4b-11eb-0af4-6368d8bb34c0
# ╠═1a483212-8f4b-11eb-0fa5-5994548ea6b9
# ╟─f4228cb2-8eab-11eb-1b98-fbb30f8eeac3
# ╠═c6d79168-8f4f-11eb-1c4f-4bf4abbb2c72
# ╟─d2f7c68e-8f4f-11eb-0d90-4f2f22bd87b6
# ╟─f75c7e22-8f52-11eb-0b32-f9ed6267fb18
# ╟─9ef95826-8f53-11eb-11ed-a35e16d20083
# ╟─0e07a38e-8f55-11eb-0c46-ef5d11df07de
# ╟─13c539e8-8eac-11eb-35b0-61108d5f3c5f
# ╟─45826916-8f55-11eb-3f3c-95d6b601191b
# ╟─e026ffa6-8f5f-11eb-0651-dfb9e28fcc4f
# ╟─10ba0d9c-8f5f-11eb-0744-6be46cfacebe
# ╟─4921f4f8-8f60-11eb-0e45-3f3034dbea83
# ╟─29fa38b6-8f61-11eb-118a-616fc647715a
# ╟─0580566c-8ff4-11eb-35a3-bf0505fe5a1c
# ╟─eb4df5e4-8f79-11eb-2429-a31bd0009c4b
# ╠═166bbbb2-8f7a-11eb-19c6-19dfe8ee5123
# ╠═72b98a42-8ff8-11eb-17f3-6d14da3964be
# ╠═1a78b2be-8f7a-11eb-0470-e7febaac6272
# ╠═627f170a-8ff8-11eb-21eb-47796905e10b
# ╠═67c7f3d0-8ff8-11eb-04dc-4f796cfb940e
# ╟─7cffb62a-8ff8-11eb-0288-f55b0d333571
# ╠═98d147c4-8ff8-11eb-3ab8-21e26217e02a
# ╠═8e593406-8ff9-11eb-101a-695b2b026a20
# ╠═9e31a492-8ff9-11eb-108d-1b7bbd152170
# ╠═a21aa0c2-8ff9-11eb-1cc8-7b63a20d0791
# ╟─c5f14d48-8ff9-11eb-1350-790162aa8b34
# ╟─3fc036f8-8eac-11eb-15dc-017c0d5237bc
# ╟─35cfef70-8ffa-11eb-1a48-e906596eebe6
# ╟─73ffb3fe-8ffd-11eb-2b71-038543ea5093
# ╟─bd69872c-8f78-11eb-2197-2f760c33b197
# ╟─46ad0fa2-8eac-11eb-28df-4f2c23f8d3ff
# ╟─cbe1949e-8ffc-11eb-0747-e576545133b4
# ╟─6616ee24-8ffd-11eb-0d13-7f7ea01d3f73
# ╟─c5f18fe2-8ffe-11eb-0a96-1f3ce397e943
# ╟─420d72f4-8ffe-11eb-1b0f-43bdc9edf955
# ╟─84e5fe6e-8eac-11eb-04f8-cf7499b2c218
# ╠═4c23d3bc-8eac-11eb-2870-a37dfc123bc5
# ╠═1ba1fde4-90d3-11eb-2d2a-5f3028b94d64
