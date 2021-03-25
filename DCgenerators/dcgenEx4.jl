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

# ╔═╡ 0ba12c10-8cc5-11eb-35bf-e3b95d6593b3
begin
	import Pkg
	Pkg.activate(mktempdir())
#No PC: Pkg.add... apenas na 1ª utilização:
#############################################
	using Pkg
	Pkg.add(["PlutoUI", "Plots", "Dierckx"])	
#############################################
	using PlutoUI
	using Plots
	using Dierckx
end

# ╔═╡ ef338580-8cc1-11eb-03db-f9ed91d742c6
md"""
ME2\
**Ricardo Luís** (Professor Adjunto) \
ISEL, 25/Mar/2021
"""

# ╔═╡ 7868a4c0-8cc2-11eb-36e6-995f0ba9f707
md"""
# Geradores de corrente contínua
"""

# ╔═╡ 855e0e90-8cc2-11eb-2be7-673720ce66d7
md"""
## Exercício 4
"""

# ╔═╡ 8b049710-8cc2-11eb-33cf-ef396ec1944e
md"""
**Um gerador de excitação composta ligado em longa derivação e fluxo de excitação
série aditivo apresenta as seguintes características:**
"""

# ╔═╡ 70dcec10-8cc3-11eb-0ce1-15f38b9fb0f9
(Pn, Un, nₙ, Ri, Rs, Rd, Nd, Ns)=(8.75e3, 250, 1500, 1.3, 0.1, 223.0, 2000, 50)

# ╔═╡ 0786377e-8cc3-11eb-1413-e90fac064ffd
begin
	Iexc=[0.0, 0.2, 0.4, 0.6, 0.8, 0.9, 1.0, 1.1, 1.3, 1.5, 1.7]
	E₀_1500=[15.0, 100.0, 170.0, 220.0, 250.0, 260.0, 270.0, 280.0, 290.0, 300.0, 310.0]
	Iexc,E₀_1500	
end

# ╔═╡ caeb9440-8cc3-11eb-0a47-e32ddfbb60df
md"""
**Considere ainda um interruptor em paralelo com o enrolamento indutor série.**
"""

# ╔═╡ f2e30e10-8cc3-11eb-3254-09eecb58cdd7
md"""
**a) Calcule o valor da tensão em vazio sem reóstato de excitação. Explique se o estado do
interruptor influencia o valor da tensão de vazio do gerador.**
"""

# ╔═╡ 666c6610-8d8c-11eb-1f12-536379ec8b3b
md"""
Em vazio a FMMs << FMMd logo o fluxo de excitação série é desprezável, não influenciando a FEM e por conseguinte a tensão de vazio, $$U_0$$.
"""

# ╔═╡ 0b45bb10-8cc4-11eb-2168-9bfabd9aea3b
begin
	H1=("Rexc", @bind Rexc PlutoUI.Slider(Rd:(E₀_1500[2,1]/Iexc[2,1]), default=2*Rd, show_value=true))
	H1
end

# ╔═╡ 29c3b5f0-8cc5-11eb-3b39-45ba828a66b0
begin
	#plotly()
	plot(Iexc,E₀_1500,title="U₀=f(Id), n=1500rpm", xflip=false, ylims=(0,350), xlabel = "Id(A)", ylabel="U₀(V)", xlims=(0,2), label=false, minorticks=0.1, minorgrid=true)
	plot!(Iexc,Rexc.*Iexc,label="Reta de excitação", legend=:bottomright)
	end

# ╔═╡ 720eea10-8d8c-11eb-0979-1b1316767fba
md"""
Para $$R_c=0Ω$$ verifica-se que a interseção da recta de excitação com a característica magnética se dá em (1.3A; 290V).
"""

# ╔═╡ 74552610-8cc7-11eb-3438-8d5790fb6fa1
md"""
**b) Com o interruptor desligado, calcule o valor da q.d.t. devido à reação magnética do induzido, sabendo que nas condições nominais se obtém uma regulação plana.**
"""

# ╔═╡ ba697470-8d77-11eb-01a1-05692e12dad7
md"""
Regulação plana, significa que a tensão em carga, $$U_{c}$$, é igual à tensão de vazio,  $$U_{0}$$. Por conseguinte, a regulação, $$\varepsilon$$, vem dada por:

$$\varepsilon= \frac{U_{0}-U_{c}  }{U_{n} } 100$$
"""

# ╔═╡ 89ab7d70-8cc7-11eb-0e2a-a99ca72b7067
begin
	U₀=Un; Uc=Un;
	reg=100(U₀-Uc)/Un
end;

# ╔═╡ 0d1c74a0-8d79-11eb-06ca-4f9339798195
md"""
Então, $$\varepsilon$$=$(reg)%
"""

# ╔═╡ 632a0760-8cff-11eb-2cbc-5b8728778ab4
Id0=Idc=0.8;

# ╔═╡ 40678f20-8d79-11eb-3ba3-2d7c17b7e853
md"""
Na situação de regulação plana verifica-se que $$I_{dc}=I_{d0}$$. Ou seja, para $$U_{0}=I_{c}=U_{n}$$, tem-se consultando a característica magnética, para $$E_{0}=250$$V, uma $$I_{dc}=I_{d0}$$=$(Id0)A
"""

# ╔═╡ 20c65f10-8d7a-11eb-0554-d3a401d3de0b
md"""
No entanto, o fluxo total da máquina, no ponto de funcionamente em carga, é caracterizado também pela contribuição de fluxo magnético criado no enrolamento de excitação série (montagem de excitação composta com fluxo aditivo). Assim, é necessário verificar a FMM do enrolamento série e a sua contribuição para a FEM, $$E_{0}$$, na situação de carga nominal, no presente caso: 

$$I_{exc}=I_{d}+\frac{N_{s}}{N_{d}}I_{s}$$
"""

# ╔═╡ d7c5e840-8d00-11eb-103f-1d4805f37322
begin
	In=Pn/Un
	Ii=In+Idc
	Idserie=Ii*Ns/Nd
	Idserie=round(Idserie, digits=2)
	Iexcₜ=Idc+Idserie
end;

# ╔═╡ 522cbe90-8d7b-11eb-0547-1350c8c001f1
md"""
Verifica-se assim, que o fluxo total (derivação + série) é produzido por uma corrente de excitação equivalente, vista pelo enrolamento $$N_{d}$$ de: $$I_{exc}$$=$(Iexcₜ)A.
"""

# ╔═╡ 8aeb506e-8cc7-11eb-3b1f-53d9e2714ac1
md"""
**c) Com o interruptor desligado explicite qualitativamente a característica exterior do gerador.**

**Qual a variação do ponto de funcionamento da característica externa para uma dada
resistência de carga, nas seguintes situações:**
1. **aumento da velocidade de accionamento;**
2. **diminuição do reóstato de campo derivação.**
"""

# ╔═╡ ae5296e0-8d8f-11eb-2651-e5f054a07785
md"""
!!! nota
No enunciado original é considerado interruptor ligado, ou seja, gerador de excitação derivação. Nesta versão propõe-se a análise com o interruptor desligado, consequentemente o gerador está com excitação composta. Analise a trajetória do ponto de funcionamento (característica externa), actuando na "carga" (corrente). 
"""

# ╔═╡ 96ffd350-8ccb-11eb-36f7-b301d582a92d
begin
	H2=("Carga", @bind Icarga PlutoUI.Slider(0:1:In*1.4, default=In/2, show_value=false))
	H3=("Rcampo", @bind Rcampo PlutoUI.Slider(0:1:300, default=100, show_value=true))
	H4=("Velocidade", @bind rpm PlutoUI.Slider(500:2000, default=1500, show_value=true))
	H2, H3, H4
end

# ╔═╡ 56bcde02-8ccb-11eb-3c79-e1d6a15804a2
E₀ₙ=round.((rpm/nₙ).*E₀_1500, digits=1)

# ╔═╡ 457a92d0-8ccc-11eb-2c37-05033ffdb46f
begin
	FMMs=Ns*Icarga
	Id_=Ns*Icarga/Nd
end;

# ╔═╡ 6cbad1f0-8cc9-11eb-3671-892059ad8beb
begin
	I=0:1:60	
	Id=0:0.001:2
	xx0=-Id_.+Id
	mxx0=(Rcampo+Rd).*xx0
	y=Icarga*(Ri+Rs).+mxx0
	E0n_i=Spline1D(Iexc,E₀ₙ)
	E0n_ii=E0n_i(Id)
	A=(E0n_ii-y)
	a=findall(i->(-1 < i < 1), A)
	Iex_fluxo=0.001*a[1,1]
	E0n_ex=Spline1D(Iexc,E₀ₙ)
	E0n_fluxo=E0n_ex(Iex_fluxo)
	Id_fluxo=Iex_fluxo-Id_
	U1p=(Rcampo+Rd)*Id_fluxo
	#plots
	P1=plot([Icarga], seriestype = :vline, linecolor=:red, ylabel="U(V)", ylims=(0,400), xlims=(0,60), label=false,linestyle=:dash)
	plot!(I, (Ri+Rs).*I, linewidth=2, linecolor=:green, legend=:none)
	plot!([Icarga*(Ri+Rs)], seriestype=:hline, linecolor=:green, ylims=(0,400), xlims=(0,60), label=false,linestyle=:dash, legend=:none)
	plot!([Icarga], [U1p],markershape=:circle, label=false, legend=:none)
	plot!([U1p], seriestype = :hline, xlims=(0,60),linestyle=:dashdot, linecolor=:purple, legend=:none)
	P2=plot(Iexc,E₀ₙ, xflip=true, ylims=(0,400), ylabel="U₀(V)", xlims=(0,2), linewidth=2, legend=:none)
	plot!(Id, (Rcampo+Rd).*Id, xlims=(0,2),ylims=(0,400), linecolor=:black, linewidth=2, label=false, legend=:none)
	plot!([Id_], seriestype = :vline, ylims=(0,400),linestyle=:dashdot, linewidth=2, linecolor=:red, label="Id_=$(Id_)A")
	plot!([Icarga*(Ri+Rs)], seriestype=:hline, linecolor=:green, ylims=(0,400), xlims=(0,2), label=false,linestyle=:dash, legend=:none)
	plot!(Id, y, linecolor=:black, ylims=(0,400), xlims=(0,2), label=false, linestyle=:dot, linewidth=2)
	plot!([Iex_fluxo], seriestype = :vline, ylims=(0,400),linestyle=:dashdot, linecolor=:purple, legend=:none)
	plot!([Id_fluxo], seriestype = :vline, ylims=(0,400),linestyle=:dashdot, linecolor=:purple, legend=:none)
	plot!([U1p], seriestype = :hline, xlims=(0,2),linestyle=:dashdot, linecolor=:purple, legend=:none)
	P3=plot(Id, Nd.*Id, yflip=true, xflip=true, linewidth=2, ylabel="FMMd(Acond)",xlims=(0,2), ylims=(0,3000), xlabel = "Id(A)", label=false, legend=:none)
	plot!([FMMs], seriestype=:hline, ylims=(0,3000), linecolor=:red, linestyle=:dash, label=false,legend=:none)
	plot!([Id_], seriestype = :vline, ylims=(0,3000),linestyle=:dashdot, linewidth=2, linecolor=:red,label=false, legend=:none)
	#plot!([Icarga], seriestype = :vline, xlabel = "I(A)", ylims=(0,3000), label=false,linestyle=:dash)
		
	P4=plot(I, Ns.*I, yflip=true, linewidth=2, ylabel="FMMs(Acond)",xlims=(0,60), label=false, legend=:none)
	plot!([FMMs], seriestype = :hline, ylims=(0,3000), linecolor=:red, linestyle=:dash, label=false)
	plot!([Icarga], seriestype = :vline, xlabel = "I(A)", ylims=(0,3000), label=false,linestyle=:dash, linecolor=:red, legend=:none)
	plot(P2, P1, P3, P4, layout = (2, 2))
end

# ╔═╡ f9817760-8d00-11eb-1611-377bc26b25bb
begin
	E0_est=Spline1D(Iexc,E₀_1500)
	E0_carga=E0n_i(Iexcₜ)
	E0_carga=round(E0_carga, digits=1)
end;

# ╔═╡ ada1fba0-8d7b-11eb-3ae0-6553fa34863e
md"""
Consultando a característica magnética verifica-se para $$I_{exc}$$ = $(Iexcₜ)A, uma FEM em carga de: 


   $$E_{0}$$ = $(E0_carga)V"""

# ╔═╡ 4a66bc70-8d02-11eb-0534-b9a896d03598
begin
	ΔUₜ=E0_carga-Uc
	ΔE=ΔUₜ-(Ri+Rs)Ii
	ΔE=round(ΔE, digits=1)
end;

# ╔═╡ 98e72b80-8d7c-11eb-0848-330bcfa4e60e
md"""
Queda de tensão total dada por: $$\Delta U_t=E_0-U_c$$, permite decompondo as q.d.t. presentes determinar a q.d.t. devido à reacção magnética do induzido, com $$\Delta{E}$$:

$$\Delta{E}=\Delta U_{t}-\Delta U_{r}-\Delta U_{esc}$$
Na presente montagem (longa derivação), $$\Delta U_r=(R_i+R_s)I_i$$   e   $$\Delta U_{esc} \simeq {0}$$.  

Resolvendo, obtém-se: $$\Delta {E}$$ = $(ΔE)V.
"""

# ╔═╡ Cell order:
# ╟─ef338580-8cc1-11eb-03db-f9ed91d742c6
# ╠═0ba12c10-8cc5-11eb-35bf-e3b95d6593b3
# ╟─7868a4c0-8cc2-11eb-36e6-995f0ba9f707
# ╟─855e0e90-8cc2-11eb-2be7-673720ce66d7
# ╟─8b049710-8cc2-11eb-33cf-ef396ec1944e
# ╠═70dcec10-8cc3-11eb-0ce1-15f38b9fb0f9
# ╠═0786377e-8cc3-11eb-1413-e90fac064ffd
# ╟─caeb9440-8cc3-11eb-0a47-e32ddfbb60df
# ╟─f2e30e10-8cc3-11eb-3254-09eecb58cdd7
# ╟─666c6610-8d8c-11eb-1f12-536379ec8b3b
# ╟─0b45bb10-8cc4-11eb-2168-9bfabd9aea3b
# ╟─29c3b5f0-8cc5-11eb-3b39-45ba828a66b0
# ╟─720eea10-8d8c-11eb-0979-1b1316767fba
# ╟─74552610-8cc7-11eb-3438-8d5790fb6fa1
# ╟─ba697470-8d77-11eb-01a1-05692e12dad7
# ╟─0d1c74a0-8d79-11eb-06ca-4f9339798195
# ╠═89ab7d70-8cc7-11eb-0e2a-a99ca72b7067
# ╟─40678f20-8d79-11eb-3ba3-2d7c17b7e853
# ╠═632a0760-8cff-11eb-2cbc-5b8728778ab4
# ╟─20c65f10-8d7a-11eb-0554-d3a401d3de0b
# ╟─522cbe90-8d7b-11eb-0547-1350c8c001f1
# ╠═d7c5e840-8d00-11eb-103f-1d4805f37322
# ╟─ada1fba0-8d7b-11eb-3ae0-6553fa34863e
# ╠═f9817760-8d00-11eb-1611-377bc26b25bb
# ╟─98e72b80-8d7c-11eb-0848-330bcfa4e60e
# ╠═4a66bc70-8d02-11eb-0534-b9a896d03598
# ╟─8aeb506e-8cc7-11eb-3b1f-53d9e2714ac1
# ╟─ae5296e0-8d8f-11eb-2651-e5f054a07785
# ╠═56bcde02-8ccb-11eb-3c79-e1d6a15804a2
# ╟─96ffd350-8ccb-11eb-36f7-b301d582a92d
# ╟─457a92d0-8ccc-11eb-2c37-05033ffdb46f
# ╟─6cbad1f0-8cc9-11eb-3671-892059ad8beb
