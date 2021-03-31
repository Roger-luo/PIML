### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 1c3ff5c4-90d5-11eb-1459-7d7d43335a80
using Yao, YaoPlots, YaoExtensions, PlutoUI, Flux, Plots

# ╔═╡ e9342104-91cf-11eb-01d7-ffd747975c7c
using LinearAlgebra

# ╔═╡ aa09eef8-8eac-11eb-00e6-6794d5c9e0b5
md"""
# Quantum Computing Basics

In case you are not familar with some basic concept of quantum computing or quantum algorithms, we will have a quick and short introduction for quantum computing.
"""

# ╔═╡ 22f46d6e-90d5-11eb-3094-e7015012995c
md"""

## Qubits

The computation states are often represented as qubits in quantum computing model. A qubit is a quantum state that has two basis states ``|0⟩`` and ``|1⟩``

## Quantum Registers

A quantum register is an abstraction of the qubit memory, it usualy contains many qubits.

## Quantum Gates

A quantum gate is a unitary operator that can be applied on the (quantum) register. we usually visualize it as a square block with two wires, e.g the following is a Pauli X gate.
"""

# ╔═╡ 920da102-90d5-11eb-0437-495807d8b345
YaoPlots.plot(X)

# ╔═╡ a5d5d56a-90d5-11eb-1e4a-8bf893d8534a
md"""
## Parameterized Quantum Gates

There are some quantum gates that can take classical parameters, e.g the rotation gates on X, Y, Z or other directions.
"""

# ╔═╡ be1f51c6-90d5-11eb-3db1-99708f112467
YaoPlots.plot(Rx(0.1))

# ╔═╡ 4f4a700e-90d6-11eb-3058-b1809082853a
md"""
## Controlled Gate

The gate operation can be controlled by another qubits, we usually represent them as the following diagram
"""

# ╔═╡ 6b2079e2-90d6-11eb-330c-0194f2906114
YaoPlots.plot(control(2, 1, 2=>Rx(0.1)))

# ╔═╡ 7854398c-90d6-11eb-2aad-b75727ab7b79
md"for controlled Pauli X gate, we also call it the CNOT gate, it can be plotted in a simpler way"

# ╔═╡ 9003bb5c-90d6-11eb-102e-f1954fe71ec6
YaoPlots.plot(cnot(2, 1, 2))

# ╔═╡ debe78d2-90d5-11eb-1526-87f514b030bf
md"""
## Quantum Circuits & Quantum Algorithms

Now with the concept of register and gates, we can define quantum circuits. The quantum circuits are composition of gates and measurements. 

e.g the following is a quantum fourier transformation circuit, it is defined using hadamard gate ``H`` and control phase shift gate.
"""

# ╔═╡ 0a379552-90d6-11eb-1a07-130ebf3c1264
begin
	A(i, j) = control(i, j=>shift(2π/(1<<(i-j+1))))
	B(n, k) = chain(n, j==k ? put(k=>H) : A(j, k) for j in k:n)
	qft(n) = chain(B(n, k) for k in 1:n)
	YaoPlots.plot(qft(3))
end

# ╔═╡ e4f1f268-91ca-11eb-231a-712cb8cf4a55
md"""
## Program with Yao

checkout the website: [yaoquantum.org](https://yaoquantum.org/)
"""

# ╔═╡ 0478efb2-91cb-11eb-034e-0b0c3be90bb7
html"""
<iframe src="https://yaoquantum.org/" width=100% height=1000></iframe>
"""

# ╔═╡ 2a546ef0-91cb-11eb-17fd-4b8c74878e6a
md"""
### the quantum blocks

Yao represents the quantum circuits as blocks

![](https://github.com/Roger-luo/PIML/blob/master/notebooks/assets/qblock.png?raw=true)
"""

# ╔═╡ 76b6bf64-91cb-11eb-3c39-576a66e70cf4
qft(3)

# ╔═╡ c75b0244-8eac-11eb-2528-b9f59f61634d
md"""
## Variational Quantum Algorithms

*in some context, this is also called quantum machine learning.*

Traditionally, a quantum algorithm usually requires a well designed circuits that provides an exponential speed up comparing to its classical counterparts, e.g the well known Shor algorithm.

However, designing and finding such algorithms can be extremely hard, and may not be possible implemented on near term quantum devices that is noisy.
"""

# ╔═╡ e1345ee8-8eac-11eb-3c22-0db185142833
md"""
## Differentiating Quantum Circuits: the forward mode

In literature, this is usually refered as the **Parameter Shift Rule**, it was first discovered in [Quantum Circuit Learning, arXiv: 1803.00745](https://arxiv.org/pdf/1803.00745.pdf)

we will now derive the rules, assume the unitary of our parameterized quantum circuit is ``U(\mathbf{θ}) = \prod_{i=1}^n U(θ_i)``, and for convenience, we will denote ``U_{j:k} = U_j⋯U_k``

then for an observable ``B``, the expectation value is ``⟨B(\mathbf{θ})⟩ = Tr(B U_{l:1}ρU_{l:1}^{†})``

now if we assume our unitary is generated by Pauli strings (which is not always true), we have ``U_j(θ) = exp(-iθ_j P_j/2)``.

The gradient of ``⟨B(\mathbf{θ})⟩`` can be calculated as following

```math
\frac{\partial ⟨B⟩}{\partial θ_j} = -\frac{i}{2} (B U_{l:j} [P_j, U_{j-1:1}ρU_{j-1:1}^{†}] U_{l:j}^{†})
```

and because we have the following relationship for arbitrary ``ρ``

```math
[P_j, ρ] = i[U_j(\frac{π}{2})ρ U_j^{†}(\frac{π}{2}) - U_j(-\frac{π}{2})ρ U_j(-\frac{π}{2})]
```

thus the gradient can be evaluated by

```math
\begin{aligned}
\frac{\partial B}{\partial θ_j} =& \frac{1}{2} (Tr[B U_{l:j+1}U(θ_j+\frac{π}{2})U_{j-1:1}ρU_{j-1:1}^{†}U_j^{†}(θ_j+\frac{π}{2})U_{l:j+1}^{†}] -\\
&Tr[B U_{l:j+1}U(θ_j-\frac{π}{2})U_{j-1:1}ρU_{j-1:1}^{†}U_j^{†}(θ_j-\frac{π}{2})U_{l:j+1}^{†}])
\end{aligned}
```

which means

```math
\frac{\partial B}{\partial θ_j} = \frac{1}{2} (⟨B(\theta_j + \frac{π}{2})⟩ - ⟨B(\theta_j - \frac{π}{2})⟩)
```
"""

# ╔═╡ f8270b02-8eac-11eb-2ab3-3323e01f4f62
md"""
## Differentiating Quantum Circuits: the reverse mode

is it possible to differentiate quantum circuits using reverse mode?
"""

# ╔═╡ 3c919a50-8ead-11eb-058f-27eceb1deeaa
md"""
## Implementing A Simple Variational Quantum Eigensolver (VQE)

You have learned how variational Monte Carlo works, now let's:

1. use a quantum circuit as our ansatz
2. directly calculate the energy by measure the Hamiltonian
3. use gradient based optimization to optimize the energy
"""

# ╔═╡ 68e75bba-91ca-11eb-128f-1d6b0b7cbb78
md"first let's create a variational circuit using the `variational_circuit` function"

# ╔═╡ 4422a0fa-91ca-11eb-3bda-f37b2dab68b3
YaoPlots.plot(variational_circuit(5, 3))

# ╔═╡ 82f2d962-91ca-11eb-2e66-597a90047e87
md"then create a quantum register at state ``|00⋯00⟩``"

# ╔═╡ 895600fc-91ca-11eb-3d03-e5aedfa44576
r = zero_state(5)

# ╔═╡ 940657d8-91ca-11eb-33fd-63a019b4ebfc
md"we can evaluate this circuit on the emulator"

# ╔═╡ a0527026-91ca-11eb-0604-21a298350c8d
r |> variational_circuit(5, 3)

# ╔═╡ b8a71bf4-91ca-11eb-2f81-eb67cfeeada0
md"""
we can now create a 1-D heisenberg hamiltonian

```math
\sum_i \mathbf{S}_i \mathbf{S}_{i+1}
```
"""

# ╔═╡ da9ba108-91ca-11eb-28a4-755cf76ea605
h = heisenberg(5)

# ╔═╡ b3cc56a2-91cb-11eb-3736-87df27d04545
md"we can calculate the expectation value of this hamiltonian"

# ╔═╡ 848d146c-91cb-11eb-17cc-87a1aa3c0d76
expect(heisenberg(5), r)

# ╔═╡ bd3c4bca-91cb-11eb-29cf-657eb95db73d
@doc expect

# ╔═╡ 9fe3db9c-91cb-11eb-1888-cf7dd2aa3aa1
expect(heisenberg(5), r=>variational_circuit(5, 3))

# ╔═╡ a6c13932-91cb-11eb-3822-7da569e520e0
reg, ∇θ = expect'(heisenberg(5), zero_state(5)=>variational_circuit(5, 3))

# ╔═╡ cbacc1f8-91cb-11eb-316c-37e3da59855c
md"we can use the optimizers from the ML framework `Flux`"

# ╔═╡ dddcbf20-91cd-11eb-2d73-2daa1643074d
opt = ADAM()

# ╔═╡ 18d83a62-91d0-11eb-2d8d-2bc2e69785e8
md"depth=$(@bind depth Slider(1:10; show_value=true))"

# ╔═╡ 12aff314-91ce-11eb-36d3-772d32cb8f3e
circuit = variational_circuit(5, depth)

# ╔═╡ e172b6f0-91cd-11eb-35be-2d44f6f26a80
begin
	history = []
	θ = rand(nparameters(circuit))
	for _ in 1:1000
		reg, ∇θ = expect'(heisenberg(5), zero_state(5)=>dispatch!(circuit, θ))
		Flux.Optimise.update!(opt, θ, ∇θ)
		current = expect(heisenberg(5), zero_state(5)=>dispatch!(circuit, θ))
		push!(history, real(current))
	end
	Plots.plot(history)
end

# ╔═╡ ec0935e0-91cf-11eb-1837-334e0e92edee
minimum(eigvals(Matrix(heisenberg(5))))

# ╔═╡ ad0071da-8ead-11eb-31e8-b94b8bff7635
md"""
## Placement Ads: Google Summer of Code 2022

https://summerofcode.withgoogle.com/
"""

# ╔═╡ Cell order:
# ╠═1c3ff5c4-90d5-11eb-1459-7d7d43335a80
# ╟─aa09eef8-8eac-11eb-00e6-6794d5c9e0b5
# ╟─22f46d6e-90d5-11eb-3094-e7015012995c
# ╟─920da102-90d5-11eb-0437-495807d8b345
# ╟─a5d5d56a-90d5-11eb-1e4a-8bf893d8534a
# ╟─be1f51c6-90d5-11eb-3db1-99708f112467
# ╟─4f4a700e-90d6-11eb-3058-b1809082853a
# ╟─6b2079e2-90d6-11eb-330c-0194f2906114
# ╟─7854398c-90d6-11eb-2aad-b75727ab7b79
# ╟─9003bb5c-90d6-11eb-102e-f1954fe71ec6
# ╟─debe78d2-90d5-11eb-1526-87f514b030bf
# ╟─0a379552-90d6-11eb-1a07-130ebf3c1264
# ╟─e4f1f268-91ca-11eb-231a-712cb8cf4a55
# ╟─0478efb2-91cb-11eb-034e-0b0c3be90bb7
# ╟─2a546ef0-91cb-11eb-17fd-4b8c74878e6a
# ╠═76b6bf64-91cb-11eb-3c39-576a66e70cf4
# ╟─c75b0244-8eac-11eb-2528-b9f59f61634d
# ╟─e1345ee8-8eac-11eb-3c22-0db185142833
# ╟─f8270b02-8eac-11eb-2ab3-3323e01f4f62
# ╟─3c919a50-8ead-11eb-058f-27eceb1deeaa
# ╟─68e75bba-91ca-11eb-128f-1d6b0b7cbb78
# ╠═4422a0fa-91ca-11eb-3bda-f37b2dab68b3
# ╟─82f2d962-91ca-11eb-2e66-597a90047e87
# ╠═895600fc-91ca-11eb-3d03-e5aedfa44576
# ╟─940657d8-91ca-11eb-33fd-63a019b4ebfc
# ╠═a0527026-91ca-11eb-0604-21a298350c8d
# ╟─b8a71bf4-91ca-11eb-2f81-eb67cfeeada0
# ╠═da9ba108-91ca-11eb-28a4-755cf76ea605
# ╟─b3cc56a2-91cb-11eb-3736-87df27d04545
# ╠═848d146c-91cb-11eb-17cc-87a1aa3c0d76
# ╠═bd3c4bca-91cb-11eb-29cf-657eb95db73d
# ╠═9fe3db9c-91cb-11eb-1888-cf7dd2aa3aa1
# ╠═a6c13932-91cb-11eb-3822-7da569e520e0
# ╟─cbacc1f8-91cb-11eb-316c-37e3da59855c
# ╠═dddcbf20-91cd-11eb-2d73-2daa1643074d
# ╠═18d83a62-91d0-11eb-2d8d-2bc2e69785e8
# ╠═12aff314-91ce-11eb-36d3-772d32cb8f3e
# ╠═e172b6f0-91cd-11eb-35be-2d44f6f26a80
# ╠═e9342104-91cf-11eb-01d7-ffd747975c7c
# ╠═ec0935e0-91cf-11eb-1837-334e0e92edee
# ╟─ad0071da-8ead-11eb-31e8-b94b8bff7635
