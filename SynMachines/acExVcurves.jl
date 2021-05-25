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

# ╔═╡ 594cc544-b602-4bb0-ba48-ee6b56972b46
begin
	#import Pkg
	#Pkg.activate(mktempdir())
#No PC: Pkg.add... apenas na 1ª utilização:
#############################################
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots"])	
#############################################
	using PlutoUI
	using Plots
end

# ╔═╡ c0e4d750-b9a4-11eb-2e0c-edaeaaf3f36a
html"<button onclick='present()'>present</button>"

# ╔═╡ 80269ea7-6643-4004-aff3-eae645749218
md"""
# Curvas V
"""

# ╔═╡ 4c9ce872-1164-4c7f-9a26-3af89b345c41
md"""
É dado um alternador síncrono sobre rede de potência infinita $$(U_f=200\mathrm V, f=50\mathrm Hz)$$ com $$X_s=4\Omega$$ e $$R_s\thickapprox 0\Omega$$.
"""

# ╔═╡ 9b3e08e0-7207-4099-96e4-c6e1e9892a1f
md"""
## alínea a)

**a) Traçar as rectas de potência activa e reactiva correspondentes a:**

$$0;\quad 5;\quad 10;\quad 15;\quad 20;\quad \mathrm {kW, kVAr}$$

"""

# ╔═╡ 159419d5-0555-43a0-8320-9cb51e0b05ba
md"""
Conforme se verificou anteriormente, no traçado do diagrama P-Q para um alternador síncrono (Exercício 2), no diagrama vectorial de tensões, o vector da queda de tensão na reactância síncrona, $$jX_s\overline I$$, pode ser transformado no vector de potência aparente, $$\overline S= P+ jQ$$, se multiplicarmos por um factor de escala constante: $$\frac{3U}{X_s}$$. 

Desta forma, a posição dos afixos dos vectores, $$jX_s\overline I$$ ou $$\overline{E}_0$$, representam, adequando a escala para potências, o ponto de funcionamento da máquina, $$(Q, P)$$, num sistemas de eixos de potência activa e reactiva representados a partir do afixo do vector da tensão, $$\overline U$$:
"""

# ╔═╡ df708c4d-443b-4190-b72d-779c4e1e1bb1
begin
	H1=("P", @bind P PlutoUI.Slider(0:5.0e3:20e3, default=0,show_value=true))
	H2=("Q", @bind Q PlutoUI.Slider(-20e3:5.0e3:20e3, default=0, show_value=true))
	H4=("linhas de Q constante", @bind z2 CheckBox())
	H3=("linhas de P constante", @bind z1 CheckBox())
	H1, H2, H4, H3
end

# ╔═╡ 3d8c7f7e-e765-41d9-8191-aef5e52984fc
md"""
## alínea b)

**b) Traçar as curvas em V das potências requeridas.**
"""

# ╔═╡ db0fc7c2-9e8c-415f-95c1-686dbfc56347
md"""
O traçado das curvas em "V", ou curvas de Mordey, corresponde a uma representação do mapa de funcionamento da máquina síncrona, traduzido num conjunto de isolinhas para a potência activa, que relacionam diferentes pares de valores $$(I_{exc}, I)$$ ou $$(E_0, I)$$ representando diferentes factores de potência.

Assim, partindo do diagrama vectorial de tensões, para os pontos de funcionamento $$(Q, P)$$ sobre a mesma linha de potência activa, são registados consecutivamente os pares de valores relativos aos módulos dos vectores da fem e da corrente do estator, $$E_0$$ e $$I$$.

Repare-se que para $$P=0\mathrm W$$, $$(I\cos\varphi=0)$$, verifica-se que os vectores de tensão: $$\overline U, jX_s\overline I$$ e $$\overline E_0$$ são colineares (estão em fase), por conseguinte:
"""

# ╔═╡ 6a1ee842-a2f1-4810-83d7-5ce931c47891
md"""
Como alternador, de: $$\quad\overline{E}_0=\overline{U}+jX_s\overline{I}\quad$$ tém-se,

$$E_0=U+X_sI \quad\mathrm{se} \quad\varphi = -90° \Rightarrow E_0>U$$ 

$$E_0=U-X_sI \quad\mathrm{se} \quad\varphi = +90° \Rightarrow U>E_0$$

o que resulta nas duas rectas representadas no gráfico em $$P=0\mathrm W$$, representadas pelas equações:

$$I=\frac{1}{X_s}E_0-\frac{1}{X_s}U \quad\mathrm{para} \quad\varphi = -90°$$ 

$$I=-\frac{1}{X_s}E_0+\frac{1}{X_s}U \quad\mathrm{para} \quad\varphi = +90°$$

"""

# ╔═╡ 594360d4-9bb8-4756-8f40-a5f0f9555aba
md"""
Assinale-se também para $$Q=0\mathrm {VAr}$$, $$(I\sin\varphi=0)$$, que a corrente do estator terá o valor mais baixo em cada isolinha de potência activa. Esses pontos de funcionamento são designados por **pontos de excitação óptima**.
"""

# ╔═╡ 1b4d9fbd-be46-416a-a1fe-163f5a0b37a3
md"""
!!! nota
O estudante deverá procurar perceber onde se encontram os modos sobreexcitado e subexcitado, nos regimes de funcionamento alternador e motor, bem como os casos particulares da máquina a funcionar em vazio como compensador síncrono.
"""

# ╔═╡ da155613-1b89-47e5-b66a-a2c66540fa86
md"""
# Setup
"""

# ╔═╡ 617f90e4-39fe-4746-b637-47a8b24710f2
#TableOfContents(title="Índice")

# ╔═╡ fe9410d1-6e81-491b-8262-ba5ba5bf05ff
md"""
## *Notebook*: acExVcurves.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FSynMachines-GitHub-yellowgreen.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/SynMachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ db2e7822-4417-4f84-acbb-2dbf99b4ddc7


# ╔═╡ f3bab088-7bcf-4c9d-a5e3-13ea646d7ff9
md"""
### Operador fasor `∠(x)` e imaginário `j(x)`:
"""

# ╔═╡ 026c8f3e-8ecd-459f-b496-511c38065cc6
begin
	∠(x) = cis(deg2rad(x))
	j(x) = (x)*im
end;

# ╔═╡ fb03a3aa-f94b-4b73-a21b-f05bc548dd9d
begin
	Xₛ=4
	U=200.0
	U_=(U)∠(0)
	Icosφ=P/(3U)
	Isenφ=-Q/(3U)
	I_=(Icosφ)+j(Isenφ)
	S_=P+j(Q)
	E₀_=U_+j(Xₛ)*I_
	S_, I_, E₀_
end

# ╔═╡ 41eac123-fa10-42c3-a801-8fb5f7bce7ae
begin

		# eixos: kW, kVAr
	plot([0+j(0), 400+j(0)], 
		label="eixo de potência reactiva (VAr)", arrow=:head, linecolor=:black, 			linewidth=2)
	plot!([200-j(200), 200+j(200)],
		label="eixo de potência activa (W)", arrow=:head, linestyle=:dash, 					linecolor=:black, linewidth=2)
	
	K=3
	plot!([0, U_], arrow=:closed, legend=:bottomright, label="U∠0°", linewidth=2, linecolor=:blue)
	plot!([0, K*I_], arrow=:closed, label="I∠φ", linewidth=2, linecolor=:red)
	plot!([U_, U_+j(Xₛ)*I_], arrow=:closed, label="XₛI∠(φ+90°)", linewidth=2, linecolor=:purple)
	plot!([0, E₀_], arrow=:closed,minorticks=5, label="E₀∠δ", linewidth=2,
		  ylims=(-200,200), xlims=(0,400),size=(600,600) )
	

	
	# lugar geométrico de Q constante
	φ_locus=-90:1:90
	φ_locus=deg2rad.(φ_locus)
	I=abs(I_)
	φ=atan(-Q/(P+0.001))
	Isinφ_Qlocus_=K*I*cos.(φ_locus).+j(K*I*sin(φ))
	plot!(z2*Isinφ_Qlocus_, linestyle=:dash, linecolor=:blue, label="linha Isinφ constante")
	δ_locus=0:1:90
	δ_locus=deg2rad.(δ_locus)
	E₀=abs(E₀_)
	δ=angle(E₀_)
	E₀Q_locus_=E₀*cos(δ).+j.(E₀*sin.(δ_locus))
	plot!(z2*E₀Q_locus_, linestyle=:dashdot, linecolor=:blue, label="linha de E₀cosδ constante")
	
	# lugar geométrico de P constante
	Isinφ_Plocus_=K*I*cos(φ).+j(K*I*sin.(φ_locus))
	plot!(z1*Isinφ_Plocus_, linestyle=:dash, label="linha de Icosφ constante", linecolor=:red)
	E₀P_locus_=E₀.*cos.(δ_locus).+j(E₀*sin(δ))
	plot!(z1*E₀P_locus_, linestyle=:dashdot, linecolor=:red, label="linha de E₀sinδ constante")
end

# ╔═╡ d2ed65c3-24e3-42ee-ac6e-f743ef4b584d
begin
	Pᵥ=[0, 5, 10, 15, 20]
	Qᵥ=[-20, -15, -10, -5, 0, 5, 10, 15, 20]
	Iᵥcosφ=Pᵥ.*1e3./(3U)
	Iᵥsinφ=transpose(Qᵥ.*1e3./(3U))
	#Iᵥcosφ, Iᵥsinφ
	#Inicialização de matrizes:
	Iᵥ_=zeros(ComplexF64, 5, 9)
	E₀₁_=zeros(ComplexF64, 5, 9)
	Iᵥ=zeros(5,9)
	φᵥ=zeros(5,9)
	P₁=zeros(5,9)
	#c_cosφ=zeros(5,9)
	E₀₁=zeros(5,9)
	#δᵥ=zeros(5,9)
	for l in 1:5
		for c in 1:9
			Iᵥ_[l,c]=Iᵥcosφ[l,1]+j(Iᵥsinφ[1,c])
			Iᵥ[l,c]=abs(Iᵥ_[l,c])
			φᵥ[l,c]=angle(Iᵥ_[l,c])
			P₁[l,c]=3*U*Iᵥ[l,c]*cos(φᵥ[l,c])
			#c_cosφ[l,c]=cos(φᵥ[l,c])
			E₀₁_[l,c]=(U)∠(0)+j(Xₛ*Iᵥ_[l,c])
			E₀₁[l,c]=abs(E₀₁_[l,c])
			#δᵥ[l,c]=angle(E₀₁_[l,c])
			#δᵥ[l,c]=rad2deg(δᵥ[l,c])
		end
	end
	plot(E₀₁[1,:],Iᵥ[1,:], legend=:bottomright, label="P=0kW", linewidth=2, xlabel = "E₀(V)", ylabel="I(A)",)	
	plot!(E₀₁[2,:],Iᵥ[2,:], label="P=5kW", linewidth=2)
	plot!(E₀₁[3,:],Iᵥ[3,:], label="P=10kW", linewidth=2)
	plot!(E₀₁[4,:],Iᵥ[4,:], label="P=15kW", linewidth=2)
	plot!(E₀₁[5,:],Iᵥ[5,:], label="P=20kW", linewidth=2)
	plot!([E₀], [I], markershape=:circle,markersize=7, label="Ponto (P, Q)")
end

# ╔═╡ 542c49ed-74d3-4eb2-a2a4-d18906c35e9a
version=VERSION;

# ╔═╡ 6c1a2b67-e0b1-4725-87ad-22f85eb06d16
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 25/Mai/2021
"""

# ╔═╡ Cell order:
# ╟─c0e4d750-b9a4-11eb-2e0c-edaeaaf3f36a
# ╟─80269ea7-6643-4004-aff3-eae645749218
# ╟─4c9ce872-1164-4c7f-9a26-3af89b345c41
# ╟─9b3e08e0-7207-4099-96e4-c6e1e9892a1f
# ╟─159419d5-0555-43a0-8320-9cb51e0b05ba
# ╠═fb03a3aa-f94b-4b73-a21b-f05bc548dd9d
# ╟─41eac123-fa10-42c3-a801-8fb5f7bce7ae
# ╟─df708c4d-443b-4190-b72d-779c4e1e1bb1
# ╟─3d8c7f7e-e765-41d9-8191-aef5e52984fc
# ╟─db0fc7c2-9e8c-415f-95c1-686dbfc56347
# ╟─6a1ee842-a2f1-4810-83d7-5ce931c47891
# ╟─d2ed65c3-24e3-42ee-ac6e-f743ef4b584d
# ╟─594360d4-9bb8-4756-8f40-a5f0f9555aba
# ╟─1b4d9fbd-be46-416a-a1fe-163f5a0b37a3
# ╟─da155613-1b89-47e5-b66a-a2c66540fa86
# ╟─617f90e4-39fe-4746-b637-47a8b24710f2
# ╟─fe9410d1-6e81-491b-8262-ba5ba5bf05ff
# ╠═db2e7822-4417-4f84-acbb-2dbf99b4ddc7
# ╠═594cc544-b602-4bb0-ba48-ee6b56972b46
# ╟─f3bab088-7bcf-4c9d-a5e3-13ea646d7ff9
# ╠═026c8f3e-8ecd-459f-b496-511c38065cc6
# ╟─6c1a2b67-e0b1-4725-87ad-22f85eb06d16
# ╟─542c49ed-74d3-4eb2-a2a4-d18906c35e9a
