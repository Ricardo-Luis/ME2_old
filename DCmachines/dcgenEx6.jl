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

# ╔═╡ a74dbe00-957e-11eb-0186-2ffacd3f5a25
begin
	#import Pkg
	#Pkg.activate(mktempdir())
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	# instalação de packages
	using PlutoUI # user-interface do Pluto.jl
	using Plots  # Julia package para gráficos 
	using Dierckx  # Julia package para interpolação/extrapolação de dados
end

# ╔═╡ 670c777a-c25b-424d-b35c-34f902367498
md"""
# *Notebook*: dcgenEx6.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FDCmachines-GitHub-yellow.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/DCmachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 43719f4a-0df3-4795-936c-ad0bf32405d9
md"""
# Geradores de corrente contínua
"""

# ╔═╡ f53e42fd-bb33-432d-9b02-ffba9e31064a
md"""
## Exercício 6
"""

# ╔═╡ 860e56f2-921c-4943-a31b-3c2a896ca092
md"""
**Conhecem-se as características exteriores de dois dínamos de excitação composta
diferencial, ligados em paralelo, de 220V, 110kW:**
"""

# ╔═╡ f50f251e-afe1-4ae3-8607-4d325a7c6116
begin
	I=[0.0, 200, 400, 500, 700, 900]
	U₁=[229.5, 226.5, 222.5, 220.0, 213.0, 205.5]
	U₂=[224.0, 223.0, 221.0, 220.0, 217.5, 214.0]
	I,U₁,U₂
end

# ╔═╡ 7b6d5dee-5fb8-4dc1-8557-370fc8698624
H1=("Rcarga", @bind Rcarga PlutoUI.Slider(0.09:.001:2, default=.143,show_value=true))

# ╔═╡ 7e536108-d92f-4e5f-bd37-e48924ff9943
md"""
**a) Como repartiriam as duas máquinas uma corrente de 1500A? Qual a tensão?**
"""

# ╔═╡ d59f7a7e-10bb-43cb-9710-1a822afeeba9
md"""
Do gráfico, na característica $$U=f(I₁+I₂)$$, para uma carga de $$1500$$A, verifica-se: $$U\simeq215$$V, $$I₁\simeq650$$A e $$I₂\simeq850$$A.
"""

# ╔═╡ 16f830b5-2160-43c4-8ebb-6b5cab2d5726
md"""
**b) O que se verifica para cargas reduzidas e próximas de zero? $$0 < I <250A$$**
"""

# ╔═╡ 10ce0429-8170-498d-b6a8-78c4d4005822
md"""
A máquina DC 2, passa a receber corrente (passa a motor DC). O gerador 1 fornece corrente para a carga e para a máquina 2
"""

# ╔═╡ b15489fb-f0e8-4019-ab10-65a8f91ec8c5
md"""
**c) Complete: “Em sobrecarga a máquina com** maior/menor **regulação, fornece**
menos/mais **corrente”.**
"""

# ╔═╡ 1e4d5035-1f17-4d8f-aaf3-0c62ec511abc
begin
	U=-205.5:-1:-229.5
	I1int=Spline1D(-U₁, I, k=1, bc="extrapolate")
	I2int=Spline1D(-U₂, I, k=1, bc="extrapolate")
	I₁=I1int(U)
	I₂=I2int(U)
	I₁, I₂
end;

# ╔═╡ 089dd348-6ff5-4f42-8487-bfe9e4b94d76
begin
	Iₜ=I₁+I₂
	Ic=0:.01:2300
	Uc=Rcarga.*Ic
	Up_int=Spline1D(-Iₜ,U)
	Up=(-1).*Up_int(-Ic)
	A=(Up-Uc)
	a=findall(i->(-.1 < i < .1), A)
	Itotal=.01*a[1,1]
	Ic1=I1int(-Rcarga*Itotal)
	Ic2=I2int(-Rcarga*Itotal)
end;

# ╔═╡ 5d931a49-0a5e-4ad0-b726-9996ae7cbe7e
begin
	plot(I,U₁, markershape=:circle, markersize=3, linecolor=:blue, linewidth=0, title="U =f(I)", xlabel = "I(A)", ylabel="U(V)", ylims=(00,230), framestyle = :origin, minorticks=5, label="U₁=f(I₁)") # alterar o parâmetro "ylims" para a fazer zoom ao gráfico!
	plot!(I,U₂, markershape=:circle, markersize=3, linecolor=:red, linewidth=0, label="U₂=f(I₂)", legend=:bottomright)
	plot!(I₁,-U, linecolor=:blue, label=:none)
	plot!(I₂,-U, linecolor=:red, label=:none)
	plot!(I₁+I₂, -U, xlims=(-500,2500), linewidth=2, markershape=:circle, markersize=3, label="U=f(Iₜₒₜₐₗ)", xminorgrid=true)
	#plot!([210], seriestype = :hline, linestyle=:dash)
	plot!(I₁+I₂, Rcarga.*(I₁+I₂), linewidth=3, label="reta carga")
	plot!([Itotal], seriestype = :vline, linestyle=:dash, linecolor=:brown, label=:none)
	plot!([Rcarga*Itotal], seriestype = :hline, linestyle=:dash, label=:none)
	plot!([Ic1], seriestype = :vline, linestyle=:dashdot, linecolor=:blue, label=:none)
	plot!([Ic2], seriestype = :vline, linestyle=:dashdot, linecolor=:red, label=:none)
end

# ╔═╡ 565f551c-a3ab-42f2-b53f-f37985120d25
version=VERSION;

# ╔═╡ 0c912bfd-ebd9-4536-b89a-70c39965c7fb
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 11/Abr/2021
"""

# ╔═╡ Cell order:
# ╟─670c777a-c25b-424d-b35c-34f902367498
# ╟─43719f4a-0df3-4795-936c-ad0bf32405d9
# ╟─f53e42fd-bb33-432d-9b02-ffba9e31064a
# ╟─860e56f2-921c-4943-a31b-3c2a896ca092
# ╠═f50f251e-afe1-4ae3-8607-4d325a7c6116
# ╟─5d931a49-0a5e-4ad0-b726-9996ae7cbe7e
# ╟─7b6d5dee-5fb8-4dc1-8557-370fc8698624
# ╟─7e536108-d92f-4e5f-bd37-e48924ff9943
# ╟─d59f7a7e-10bb-43cb-9710-1a822afeeba9
# ╟─16f830b5-2160-43c4-8ebb-6b5cab2d5726
# ╟─10ce0429-8170-498d-b6a8-78c4d4005822
# ╟─b15489fb-f0e8-4019-ab10-65a8f91ec8c5
# ╟─1e4d5035-1f17-4d8f-aaf3-0c62ec511abc
# ╟─089dd348-6ff5-4f42-8487-bfe9e4b94d76
# ╟─0c912bfd-ebd9-4536-b89a-70c39965c7fb
# ╟─a74dbe00-957e-11eb-0186-2ffacd3f5a25
# ╟─565f551c-a3ab-42f2-b53f-f37985120d25
