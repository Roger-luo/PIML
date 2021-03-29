### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 1c3ff5c4-90d5-11eb-1459-7d7d43335a80
using Yao, YaoPlots, YaoExtensions

# ╔═╡ 3b36ec88-90d7-11eb-1c27-370faa2c8c27
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
plot(X)

# ╔═╡ a5d5d56a-90d5-11eb-1e4a-8bf893d8534a
md"""
## Parameterized Quantum Gates

There are some quantum gates that can take classical parameters, e.g the rotation gates on X, Y, Z or other directions.
"""

# ╔═╡ be1f51c6-90d5-11eb-3db1-99708f112467
plot(Rx(0.1))

# ╔═╡ 4f4a700e-90d6-11eb-3058-b1809082853a
md"""
## Controlled Gate

The gate operation can be controlled by another qubits, we usually represent them as the following diagram
"""

# ╔═╡ 6b2079e2-90d6-11eb-330c-0194f2906114
plot(control(2, 1, 2=>Rx(0.1)))

# ╔═╡ 7854398c-90d6-11eb-2aad-b75727ab7b79
md"for controlled Pauli X gate, we also call it the CNOT gate, it can be plotted in a simpler way"

# ╔═╡ 9003bb5c-90d6-11eb-102e-f1954fe71ec6
plot(cnot(2, 1, 2))

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
	plot(qft(3))
end

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
"""

# ╔═╡ f8270b02-8eac-11eb-2ab3-3323e01f4f62
md"""
## Differentiating Quantum Circuits: the reverse mode

is it possible to differentiate quantum circuits using reverse mode?
"""

# ╔═╡ 3c919a50-8ead-11eb-058f-27eceb1deeaa
md"""
## Implementing Quantum Circuit Born Machine
"""

# ╔═╡ ad0071da-8ead-11eb-31e8-b94b8bff7635
md"""
## Placement Ads: Google Summer of Code 2022
"""

# ╔═╡ Cell order:
# ╟─3b36ec88-90d7-11eb-1c27-370faa2c8c27
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
# ╠═c75b0244-8eac-11eb-2528-b9f59f61634d
# ╠═e1345ee8-8eac-11eb-3c22-0db185142833
# ╠═f8270b02-8eac-11eb-2ab3-3323e01f4f62
# ╠═3c919a50-8ead-11eb-058f-27eceb1deeaa
# ╠═ad0071da-8ead-11eb-31e8-b94b8bff7635
