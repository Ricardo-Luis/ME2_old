### A Pluto.jl notebook ###
# v0.14.1

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
	#import Pkg
	#Pkg.activate(mktempdir())
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	# instalação de packages
	using PlutoUI # user-interface do Pluto.jl
	using Plots  # Julia package para gráficos 
	using Dierckx  # Julia package para interpolação/extrapolação de dados
end

# ╔═╡ b4b2408d-1612-4336-b953-b169e98bc9d3
md"""
# *Notebook*: dcgenEx2.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FDCmachines-GitHub-yellow.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/DCmachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 8c0dc890-8be4-11eb-020b-1f0a062e06e2
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
Variação da f.e.m. com a velocidade (a partir do *slider* "Velocidade"):
"""

# ╔═╡ 9fb581f3-ad5c-45e5-8189-6f3800f174fd
md"""
> Forma computacional para consultar o valor da corrente de campo, para uma dada f.e.m. por interpolação: 
"""

# ╔═╡ efafae10-8c37-11eb-04f9-399f14eb077d
#utilizando pkg Dierckx.jl
begin
	Spl_Iexc=Spline1D(E₀_1500,Iexc)
	Id00=Spl_Iexc(U[1,1])
	Id00=round(Id00, digits=2)
end;

# ╔═╡ 80676520-8b01-11eb-3ad8-691043be79e0
#utilizando pkg DataInterpolations.jl
#begin
#	DInt_E₀ₙ=CubicSpline(E₀ₙ,Iexc)
#	E₀exx=DInt_E₀ₙ(Icampo)
#	E₀exx=round(E₀exx, digits=1)
#end

# ╔═╡ d77b4d88-c7a6-4150-91ad-650467cafc8e
md"""
> Forma computacional para consultar o valor da f.e.m. à velocidade $$n$$, para uma dada corrente de campo, por interpolação:
"""

# ╔═╡ 0ae6ec70-8b07-11eb-1975-519f634d69c1
begin
	H1=("Rcarga", @bind Rcarga PlutoUI.Slider(10:1000, default=20, show_value=true))
	H2=("Icampoexc", @bind Icampo PlutoUI.Slider(0:0.01:1.5, default=Id00, show_value=true))
	H3=("Velocidade", @bind rpm PlutoUI.Slider(500:2000, default=1500, show_value=true))
	H1, H2, H3
end

# ╔═╡ 2fb64df0-89d8-11eb-0a6a-39826bc54d5d
E₀ₙ=round.((rpm/1500).*E₀_1500, digits=1)

# ╔═╡ 66553710-8c38-11eb-128e-65c4e8384922
#utilizando pkg Dierckx.jl
begin
	Spl_E₀ₙ=Spline1D(Iexc,E₀ₙ)
	E₀exx=Spl_E₀ₙ(Icampo)
	E₀exx=round(E₀exx, digits=2)
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
md"""
A resistência crítica serve para determinar o valor máximo de resistência de um circuito de excitação e consequentemente dimensionar o valor máximo do reostato de campo. Pode ser determinada aproximadamente pelo 1º par de valores não nulos da característica magnética.
"""

# ╔═╡ 5ed2b082-89a4-11eb-20c7-79404ae96ed9
md"""
###### c) Qual a resistência do enrolamento indutor, sabendo que como gerador derivação, à velocidade nominal, sem resistência de campo, $$U_0=294\rm{V}$$.
"""

# ╔═╡ 0f63f472-c660-4732-9485-9a6298c52c08
md"""
A recta de excitação, $$U=R_{ex}I_d$$, determina o valor da tensão em vazio $$U_0$$ no ponto de intersecção com a característica magnética. Por conseguinte, não havendo reostato de campo, $$R_c=0Ω$$, a resistência do circuito de excitação, $$R_{ex}=R_c+R_d$$, corresponde apenas à resistência do enrolamento indutor, $$R_d$$.
"""

# ╔═╡ dd772af0-89e6-11eb-3776-c91da554ac2f
begin
		Id_294=round(Spl_Iexc(294), digits=2)
		Rd=round(294/Id_294, digits=1)
end;

# ╔═╡ d7471031-93bf-446f-b8b3-c7f23c424ac5
md"""
Assim, em dois passos determina-se o valor de $$R_{ex}=R_d$$:
- consultar a característica magnética para obter a corrente de campo correspondente a $$U_0=294$$V;
- cálculo da resistência do circuito de excitação
Obtém-se, $$R_d=$$ $(Rd)Ω
"""

# ╔═╡ 19cb80f0-89e7-11eb-3ab5-d9b274fce8c2


# ╔═╡ dd4bf910-89e2-11eb-0963-f91f846b1631
md"""
###### d) Explicite qualitativamente qual a influência que a variação da resistência de campo tem, sobre a característica externa do gerador derivação. Justifique sucintamente.
"""

# ╔═╡ 76c8e570-89b7-11eb-3875-b381a16288d2
begin
	H4=("Rexc", @bind Rexc PlutoUI.Slider(300/1.5:Rcrítica, default=356, show_value=true)) #default=278/Id00
	H4
end

# ╔═╡ abcd49a0-8a70-11eb-03b1-8dc34c0d2099
begin
	j=0.001
	id=0:j:1.5
	#id=collect(id)
	E₀shunt=Spline1D(Iexc,E₀ₙ)
	E₀_shunt=E₀shunt(id)
	ΔUₜ_exc=E₀_shunt-Rexc.*id
	ii=count(i->(i>= 0), ΔUₜ_exc)
	ΔUₜ_exc=ΔUₜ_exc[ΔUₜ_exc .>= 0]
	id_ii=0:j:((ii-1)*j)
	#id_ii=collect(id_ii)
	Ishunt=Spline1D(ΔUₜ,I)
	I_shunt=Ishunt(ΔUₜ_exc)
	#Ishunt=interpolate((ΔUₜ,),I,Gridded(Linear()))
	#I_shunt=Ishunt(ΔUₜ_exc)
end;

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

# ╔═╡ 1c45d5f0-8c3b-11eb-287d-651006f9d241


# ╔═╡ de153c80-89e2-11eb-17c3-cd70d615d6ef
md"""
###### e) Nas condições de excitação da alínea c), como proceder para obter uma tensão de vazio de $$336\rm{V}$$.
"""

# ╔═╡ 1685fd70-89e8-11eb-1473-cdfbd0fdba57
begin
	Id=round(336/(Rd), digits=1)
	Kϕ=300/1500
	n=336/Kϕ
end;

# ╔═╡ 950b164a-a605-4dfb-93e1-31297489430d
md"""
Não havendo reóstato de campo, apenas é possível ajustar de tensão de vazio através da velocidade de accionamento.  
Calculando, obtém-se: $$n=$$ $(n) rpm
"""

# ╔═╡ a8c35150-89e9-11eb-2f3c-d5b5b352d408


# ╔═╡ bf33336b-550c-4df9-a703-121ea7275920
version=VERSION;

# ╔═╡ 8748c630-8c83-11eb-2abe-5f6b058a4fb0
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 11/Abr/2021
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

# ╔═╡ 5a84f002-8afe-11eb-33b2-15c74aac47dd
#teste de interpolação para curvas com DataInterpolations.jl
#begin
#	DInt_Iexc=CubicSpline(Iexc,E₀_1500)
#	Id00=DInt_Iexc(U[1,1])
#	Id00=round(Id00, digits=2)
#end

# ╔═╡ Cell order:
# ╟─b4b2408d-1612-4336-b953-b169e98bc9d3
# ╟─8c0dc890-8be4-11eb-020b-1f0a062e06e2
# ╟─90570c2e-898d-11eb-3106-bb1b90a4ce42
# ╟─4464f340-898e-11eb-11d3-7f2dbd9ddb43
# ╟─267f3200-8993-11eb-0428-a143f63b73db
# ╠═8a04fa10-8990-11eb-1acc-81903fcd9035
# ╟─39fea680-8993-11eb-25db-b3706ff6d45c
# ╠═a8eecb8e-8990-11eb-1505-2f6355544f27
# ╟─2b8dbd10-898f-11eb-1253-f75830db2223
# ╟─c4d42c20-898f-11eb-0b5c-a54461ef6e5d
# ╟─59a6e600-8993-11eb-2e5b-e7fba59b24bd
# ╠═545a5cfe-8996-11eb-2949-933aca247397
# ╟─dff67510-89e1-11eb-06e0-51e2742ae650
# ╟─46f1ccc0-899b-11eb-38f4-b1430cdc3a32
# ╟─47cb8820-89e1-11eb-3cd7-13c43f8d2b6d
# ╠═2fb64df0-89d8-11eb-0a6a-39826bc54d5d
# ╟─9fb581f3-ad5c-45e5-8189-6f3800f174fd
# ╠═efafae10-8c37-11eb-04f9-399f14eb077d
# ╟─80676520-8b01-11eb-3ad8-691043be79e0
# ╟─d77b4d88-c7a6-4150-91ad-650467cafc8e
# ╠═66553710-8c38-11eb-128e-65c4e8384922
# ╟─0ae6ec70-8b07-11eb-1975-519f634d69c1
# ╟─2db74110-89c1-11eb-2c74-c1ed910c31e5
# ╟─2c8d8e20-89c1-11eb-3562-e593af0e3888
# ╟─b4912ee0-8998-11eb-2983-057aac94bbc2
# ╠═a6b68340-899a-11eb-3981-bf8c4737e639
# ╟─662608e0-8b08-11eb-187a-696ada1a8283
# ╟─6873a262-8b08-11eb-1888-2f618e7b6ad4
# ╟─5ed2b082-89a4-11eb-20c7-79404ae96ed9
# ╟─0f63f472-c660-4732-9485-9a6298c52c08
# ╟─d7471031-93bf-446f-b8b3-c7f23c424ac5
# ╠═dd772af0-89e6-11eb-3776-c91da554ac2f
# ╟─19cb80f0-89e7-11eb-3ab5-d9b274fce8c2
# ╟─dd4bf910-89e2-11eb-0963-f91f846b1631
# ╟─abcd49a0-8a70-11eb-03b1-8dc34c0d2099
# ╟─76c8e570-89b7-11eb-3875-b381a16288d2
# ╟─e43a8b50-8a79-11eb-0b48-994a055418e7
# ╟─1c45d5f0-8c3b-11eb-287d-651006f9d241
# ╟─de153c80-89e2-11eb-17c3-cd70d615d6ef
# ╟─950b164a-a605-4dfb-93e1-31297489430d
# ╠═1685fd70-89e8-11eb-1473-cdfbd0fdba57
# ╟─a8c35150-89e9-11eb-2f3c-d5b5b352d408
# ╟─8748c630-8c83-11eb-2abe-5f6b058a4fb0
# ╟─63ee8730-898e-11eb-0b20-c7e282000ee1
# ╟─bf33336b-550c-4df9-a703-121ea7275920
# ╟─1dea4460-8b0d-11eb-2be9-e5501e6caa7f
# ╟─5a84f002-8afe-11eb-33b2-15c74aac47dd
