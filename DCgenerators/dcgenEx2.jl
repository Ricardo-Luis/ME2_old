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

# ╔═╡ 63ee8730-898e-11eb-0b20-c7e282000ee1
begin
#	using Pkg
#	Pkg.add(["PlutoUI","CSV","DataFrames","Plots", "Interpolations"])
	using PlutoUI
	using CSV
	using DataFrames
	using Plots
	using Interpolations
	#using Pkg; Pkg.add("DataInterpolations")
	using DataInterpolations
	using Dierckx
end

# ╔═╡ dc03e850-8998-11eb-0d02-9f1d6fd231d8
md"""
# Geradores de corrente contínua
"""

# ╔═╡ 90570c2e-898d-11eb-3106-bb1b90a4ce42
md"""
## Exercício 2
"""

# ╔═╡ 4464f340-898e-11eb-11d3-7f2dbd9ddb43
md"""
###### Um gerador de corrente contínua $$[220\rm{V}, 12A, 1500rpm]$$ com excitação independente foi ensaiado em vazio e em carga, à velocidade nominal, tendo-se obtido as seguintes características:
"""

# ╔═╡ 267f3200-8993-11eb-0428-a143f63b73db
md"""
Característica magnética: $$E_{0} =f(I_{exc})$$ 
com   $$n=constante$$
"""

# ╔═╡ 8a04fa10-8990-11eb-1acc-81903fcd9035
begin
	#mag=[ 0.0  0.25  0.5  0.75  1.0  1.5;  20.0  180.0  238.0  270.0  284.0  300.0]
	Iexc=[0.0, 0.25, 0.5, 0.75, 1.0, 1.5]
	E₀_1500=[20.0, 180.0, 238.0, 270.0, 284.0, 300.0]
	Iexc,E₀_1500	
end

# ╔═╡ 39fea680-8993-11eb-25db-b3706ff6d45c
md"""
Característica externa: $$U =f(I)$$ 
com   $$n, R_{c}=constantes$$
"""

# ╔═╡ a8eecb8e-8990-11eb-1505-2f6355544f27
begin
	#ext=[0.0  5.0  10.0  15.0  20.0; 278.0  260.0  242.0  216.0  186.0]
	I=[0.0, 5.0, 10.0, 15.0, 20.0]
	U=[278.0, 260.0, 242.0, 216.0, 186.0]
	I,U	
end

# ╔═╡ 2b8dbd10-898f-11eb-1253-f75830db2223
md"""
###### a) Determine a queda de tensão interna total deste gerador.
"""

# ╔═╡ c4d42c20-898f-11eb-0b5c-a54461ef6e5d
md"""
A tensão de vazio, $$U_{0}$$, depende da f.e.m. (controlado pelo circuito de excitação independente), $$U_{0}=E_{0}=$$ $(U[1,1])V 
"""

# ╔═╡ 59a6e600-8993-11eb-2e5b-e7fba59b24bd
md"""
Queda de tensão total: $$\Delta U_{t}=E_{0}-U$$, com $$E_{0}$$ constante (não depende da corrente de carga).
"""

# ╔═╡ 545a5cfe-8996-11eb-2949-933aca247397
ΔUₜ=U[1,1].-U[:,1]

# ╔═╡ dff67510-89e1-11eb-06e0-51e2742ae650


# ╔═╡ 46f1ccc0-899b-11eb-38f4-b1430cdc3a32
md"""
**Extra: Com base numa $$U =f(I)$$ pode-se obter uma família de características externas em função da corrente de campo e da velocidade de accionamento do gerador**
"""

# ╔═╡ 47cb8820-89e1-11eb-3cd7-13c43f8d2b6d
md"""
Variação da f.e.m com a velocidade:
"""

# ╔═╡ 5a84f002-8afe-11eb-33b2-15c74aac47dd
begin
	DInt_Iexc=CubicSpline(Iexc,E₀_1500)
	Id00=DInt_Iexc(U[1,1])
	Id00=round(Id00, digits=2)
end

# ╔═╡ 0ae6ec70-8b07-11eb-1975-519f634d69c1
begin
	H1=("Rcarga", @bind Rcarga PlutoUI.Slider(10:1000, default=20, show_value=true))
	H2=("Icampoexc", @bind Icampo PlutoUI.Slider(0:0.01:1.5, default=Id00, show_value=true))
	H3=("Velocidade", @bind rpm PlutoUI.Slider(500:2000, default=1500, show_value=true))
	H1, H2, H3
end

# ╔═╡ 2fb64df0-89d8-11eb-0a6a-39826bc54d5d
E₀ₙ=round.((rpm/1500).*E₀_1500, digits=1)

# ╔═╡ 80676520-8b01-11eb-3ad8-691043be79e0
begin
	DInt_E₀ₙ=CubicSpline(E₀ₙ,Iexc)
	E₀exx=DInt_E₀ₙ(Icampo)
	E₀exx=round(E₀exx, digits=1)
end;

# ╔═╡ 2db74110-89c1-11eb-2c74-c1ed910c31e5
begin
	Uspeed=E₀exx.-ΔUₜ
	P1=plot(I,Uspeed, title="U =f(I), E₀=f(I)=U₀=$(round(E₀exx))V", xlabel = "I(A)", ylabel="U(V)", ylims=(0,420), xlims=(0,20), label=false)
	plot!(I, Rcarga*I, xlims=(0,20),ylims=(0,400), label="Reta de Carga=$(Rcarga)Ω", legend=:best)
	plot!(I,ΔUₜ, label="ΔUₜ")
	P2=plot(Iexc,E₀ₙ,title="E₀=f(Iₑₓ), n=$(rpm)rpm", xflip=false, ylims=(0,400), xlabel = "Iₑₓ(A)", ylabel="E₀(V)", xlims=(0,1.5), label=false)
	plot!([Icampo], seriestype = :vline, linecolor=:green,linestyle=:dash, xlims=(0,1.5),ylims=(0,400), label="ponto de excitação=$(Icampo)", legend=:bottomright)
	plot!([E₀exx], seriestype = :hline, linecolor=:green, linestyle=:dash, xlims=(0,1.5),ylims=(0,400), label=:none, legend=:bottomright)
	plot(P2, P1, layout = (1, 2))
end

# ╔═╡ 2c8d8e20-89c1-11eb-3562-e593af0e3888


# ╔═╡ b4912ee0-8998-11eb-2983-057aac94bbc2
md"""
###### b) O que é a resistência crítica de um gerador com uma excitação derivação? Qual a sua importância? Como se determina (aproximadamente) na prática?
"""

# ╔═╡ a6b68340-899a-11eb-3981-bf8c4737e639
Rcrítica=E₀_1500[2,1]/Iexc[2,1]

# ╔═╡ 662608e0-8b08-11eb-187a-696ada1a8283
begin
	plot(Iexc,E₀_1500,title="E₀=f(Iₑₓ), n=1500rpm", xflip=false, ylims=(0,400), xlabel = "Iₑₓ(A)", ylabel="E₀(V)", xlims=(0,1.5), label=false)
	plot!(Iexc,E₀_1500.-E₀_1500[1,1], label="E₀-E₀ᵣₑₘ")
	plot!(Iexc,Rcrítica.*Iexc,label="Rcrítica")
end

# ╔═╡ 6873a262-8b08-11eb-1888-2f618e7b6ad4


# ╔═╡ 5ed2b082-89a4-11eb-20c7-79404ae96ed9
md"""
###### c) Qual a resistência do enrolamento indutor, sabendo que como gerador derivação, à velocidade nominal, sem resistência de campo, $$U_0=294\rm{V}$$.
"""

# ╔═╡ dd772af0-89e6-11eb-3776-c91da554ac2f
begin
		Id_294=round(DInt_Iexc(294), digits=2)
		Rd=round(294/Id_294, digits=1)
end

# ╔═╡ 19cb80f0-89e7-11eb-3ab5-d9b274fce8c2


# ╔═╡ dd4bf910-89e2-11eb-0963-f91f846b1631
md"""
###### d) Explicite qualitativamente qual a influência que a variação da resistência de campo tem, sobre a característica externa do gerador derivação. Justifique sucintamente.
"""

# ╔═╡ 1dea4460-8b0d-11eb-2be9-e5501e6caa7f
# teste de interpolação para curvas com Dierckx.jl
#begin
#	DI=Spline1D(Iexc,E₀_1500)
#	Iexc_k=0:0.01:1.5
#	Iexc_k=collect(Iexc_k)
#	E0_k=DI(Iexc_k)
#	plot(Iexc_k, E0_k, label=:none)
#end

# ╔═╡ 76c8e570-89b7-11eb-3875-b381a16288d2
begin
	H4=("Rexc", @bind Rexc PlutoUI.Slider(300/1.5:Rcrítica, default=278/Id00, show_value=true))
	H4
end

# ╔═╡ abcd49a0-8a70-11eb-03b1-8dc34c0d2099
begin
	j=0.001
	id=0:j:1.5
	id=collect(id)
	E₀shunt=Spline1D(Iexc,E₀ₙ)
	E₀_shunt=E₀shunt(id)
	ΔUₜ_exc=E₀_shunt-Rexc.*id
	ii=count(i->(i>= 0), ΔUₜ_exc)
	ΔUₜ_exc=ΔUₜ_exc[ΔUₜ_exc .>= 0]
	id_ii=0:j:((ii-1)*j)
	id_ii=collect(id_ii)
	Ishunt=Spline1D(ΔUₜ,I)
	I_shunt=Ishunt(ΔUₜ_exc)
	#Ishunt=interpolate((ΔUₜ,),I,Gridded(Linear()))
	#I_shunt=Ishunt(ΔUₜ_exc)
end

# ╔═╡ e43a8b50-8a79-11eb-0b48-994a055418e7
begin
	Ud=Rexc.*id_ii
	I_shunt, id_ii, Ud, ΔUₜ_exc
	P3=plot(I_shunt,Ud, title="Característica externa", xlabel = "I(A)", ylabel="U(V)", ylims=(0,400), xlims=(0,30), label=false,linewidth=2)
	plot!(I, Rcarga.*I, label="Reta de Carga", legend=:topright)
	plot!(I_shunt, ΔUₜ_exc, label="ΔUₜ", legend=:topright)
	P4=plot(Iexc,E₀ₙ,title="Característica vazio", xflip=true, ylims=(0,400), xlabel = "Id(A)", ylabel="U₀(V)", xlims=(0,1.5), label=false, linewidth=2)
	plot!(id, Rexc.*id, xlims=(0,1.5),ylims=(0,400), label="Reta de excitação", legend=:topright)
	plot(P4, P3, layout = (1, 2))
end

# ╔═╡ de153c80-89e2-11eb-17c3-cd70d615d6ef
md"""
###### e) Nas condições de excitação da alínea c), como proceder para obter uma tensão de vazio de $$336\rm{V}$$.
"""

# ╔═╡ 1685fd70-89e8-11eb-1473-cdfbd0fdba57
begin
	Id=round(336/(Rd), digits=1)
	Kϕ=300/1500
	n=336/Kϕ
end

# ╔═╡ a8c35150-89e9-11eb-2f3c-d5b5b352d408


# ╔═╡ Cell order:
# ╟─63ee8730-898e-11eb-0b20-c7e282000ee1
# ╠═dc03e850-8998-11eb-0d02-9f1d6fd231d8
# ╟─90570c2e-898d-11eb-3106-bb1b90a4ce42
# ╟─4464f340-898e-11eb-11d3-7f2dbd9ddb43
# ╟─267f3200-8993-11eb-0428-a143f63b73db
# ╠═8a04fa10-8990-11eb-1acc-81903fcd9035
# ╟─39fea680-8993-11eb-25db-b3706ff6d45c
# ╟─a8eecb8e-8990-11eb-1505-2f6355544f27
# ╟─2b8dbd10-898f-11eb-1253-f75830db2223
# ╟─c4d42c20-898f-11eb-0b5c-a54461ef6e5d
# ╟─59a6e600-8993-11eb-2e5b-e7fba59b24bd
# ╠═545a5cfe-8996-11eb-2949-933aca247397
# ╟─dff67510-89e1-11eb-06e0-51e2742ae650
# ╟─46f1ccc0-899b-11eb-38f4-b1430cdc3a32
# ╟─47cb8820-89e1-11eb-3cd7-13c43f8d2b6d
# ╠═2fb64df0-89d8-11eb-0a6a-39826bc54d5d
# ╠═5a84f002-8afe-11eb-33b2-15c74aac47dd
# ╠═80676520-8b01-11eb-3ad8-691043be79e0
# ╟─0ae6ec70-8b07-11eb-1975-519f634d69c1
# ╟─2db74110-89c1-11eb-2c74-c1ed910c31e5
# ╟─2c8d8e20-89c1-11eb-3562-e593af0e3888
# ╟─b4912ee0-8998-11eb-2983-057aac94bbc2
# ╠═a6b68340-899a-11eb-3981-bf8c4737e639
# ╟─662608e0-8b08-11eb-187a-696ada1a8283
# ╟─6873a262-8b08-11eb-1888-2f618e7b6ad4
# ╟─5ed2b082-89a4-11eb-20c7-79404ae96ed9
# ╠═dd772af0-89e6-11eb-3776-c91da554ac2f
# ╟─19cb80f0-89e7-11eb-3ab5-d9b274fce8c2
# ╟─dd4bf910-89e2-11eb-0963-f91f846b1631
# ╠═1dea4460-8b0d-11eb-2be9-e5501e6caa7f
# ╠═abcd49a0-8a70-11eb-03b1-8dc34c0d2099
# ╟─76c8e570-89b7-11eb-3875-b381a16288d2
# ╟─e43a8b50-8a79-11eb-0b48-994a055418e7
# ╟─de153c80-89e2-11eb-17c3-cd70d615d6ef
# ╠═1685fd70-89e8-11eb-1473-cdfbd0fdba57
# ╟─a8c35150-89e9-11eb-2f3c-d5b5b352d408
