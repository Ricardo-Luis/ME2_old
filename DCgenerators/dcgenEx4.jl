### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 111ae810-8b2c-11eb-08e0-336ff4be5d01
begin
	using PlutoUI
	using Plots
	using Dierckx
end

# ╔═╡ e19efdfe-8b2b-11eb-21b2-f9fa986fe2f5
md"""
## Exercício 4
"""

# ╔═╡ 0dc4df40-8b2c-11eb-302f-e12b3d372b18
md"""
###### Um gerador de excitação composta ligado em longa derivação e fluxo de excitação série aditivo apresenta as seguintes características:
"""

# ╔═╡ 144f1100-8b2c-11eb-1600-396dc6c1b964
(P, Un, nn, Ri, Rs, Rd4, Nd, Ns, nmag)=(8.75e3, 250, 1500, 1.3, 0.1, 223.0, 2000.0, 50.0, 1500);

# ╔═╡ 22412a50-8b2c-11eb-05ab-2df26e4f3cb9
begin
	Iex4=[0.0, 0.2, 0.4, 0.6, 0.8, 0.9, 1.0, 1.1, 1.3, 1.5, 1.7]
	E04=[15.0, 100.0, 170.0, 220.0, 250.0, 260.0, 270.0, 280.0, 290.0, 300.0, 310]
	Iex4,E04
end;

# ╔═╡ 30752ea0-8b2c-11eb-3d61-db8fe3d3ccb0
md"""
###### Considere ainda um interruptor em paralelo com o enrolamento indutor série.
###### a) Calcule o valor da tensão em vazio sem reóstato de excitação. Explique se o estado do interruptor influencia o valor da tensão de vazio do gerador;
"""

# ╔═╡ 3ac31f20-8b2c-11eb-26e5-67f5de587872
begin
	plot(Iex4, E04, xlims=(0,2), linewidth=2, label=false)
	plot!(Iex4, Rd4.*Iex4, label="reta de excitação")
	plot!([1.3], seriestype = :vline, linecolor=:green,linestyle=:dash,ylims=(0,350), label="ponto de excitação » U₀", legend=:bottomright)
	plot!([290], seriestype = :hline, linecolor=:green, linestyle=:dash, label=:none, legend=:bottomright)
end

# ╔═╡ 5807a510-8b2c-11eb-0ae0-fdc0399746c4
md"""
###### b) Com o interruptor desligado, calcule o valor da q.d.t. devido à reação magnética do induzido, sabendo que nas condições nominais se obtém uma regulação plana;
"""

# ╔═╡ 6f08c640-8b2c-11eb-0a9d-ef7898579c39


# ╔═╡ 775a98a0-8b2c-11eb-0306-7f339d0766af
md"""
###### c) Com o interruptor ligado explicite qualitativamente a característica exterior do gerador. Qual a variação do ponto de funcionamento da característica externa para uma dada resistência de carga, nas seguintes situações:
1- aumento da velocidade de acionamento;
2– diminuição do reóstato de campo derivação.
"""

# ╔═╡ 7aed0e30-8b2c-11eb-3f23-13bc2f06d5bf


# ╔═╡ Cell order:
# ╠═111ae810-8b2c-11eb-08e0-336ff4be5d01
# ╟─e19efdfe-8b2b-11eb-21b2-f9fa986fe2f5
# ╟─0dc4df40-8b2c-11eb-302f-e12b3d372b18
# ╠═144f1100-8b2c-11eb-1600-396dc6c1b964
# ╠═22412a50-8b2c-11eb-05ab-2df26e4f3cb9
# ╟─30752ea0-8b2c-11eb-3d61-db8fe3d3ccb0
# ╠═3ac31f20-8b2c-11eb-26e5-67f5de587872
# ╟─5807a510-8b2c-11eb-0ae0-fdc0399746c4
# ╠═6f08c640-8b2c-11eb-0a9d-ef7898579c39
# ╟─775a98a0-8b2c-11eb-0306-7f339d0766af
# ╠═7aed0e30-8b2c-11eb-3f23-13bc2f06d5bf
