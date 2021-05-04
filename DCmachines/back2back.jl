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

# ╔═╡ 70306b60-8e63-11eb-2569-c35a693dc465
begin
	#import Pkg
	#Pkg.activate(mktempdir())
#No PC: Pkg.add... apenas na 1ª utilização:
#############################################
	#using Pkg
	#Pkg.add(["Images", "ImageMagick"])
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	
#############################################
	using PlutoUI
	using Plots
	using Dierckx
#	using Images
#	using ImageMagick
end

# ╔═╡ eff8adc4-fece-4100-a088-2647846e5274
md"""
# *Notebook*: back2back.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Dierckx`](https://github.com/kbarbary/Dierckx.jl), [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FDCmachines-GitHub-yellow.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/DCmachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 7da26ca2-87a1-4354-883a-986b01a3888f
TableOfContents(title="Índice")

# ╔═╡ d4a96a60-9471-11eb-16ff-7368120811fc
md"""
# Dados do sistema *back-to-back*
"""

# ╔═╡ cdeb7060-8e7c-11eb-2f84-5f69d99ccba7
(Urede, Irede, Iger, Idmot, Idger, Ri)=(250, 20, 50, 0.7, 1.0, 0.44)

# ╔═╡ a9159fd4-9306-44f6-97b4-fd4bf273e635


# ╔═╡ f11c3187-8e71-4261-859f-4806cb920697
md"""
# Balanço de potência do sistema *back-to-back*
![](https://i.imgur.com/zy7x54i.png)
"""

# ╔═╡ 42aa2d0e-da50-477f-8178-a85fe879bc94
md"""
Onde:\
$$U/I$$: tensão/corrente da rede DC\
$$P_{ab}^M, P_{ab}^G$$: potências absorvidas do motor e gerador, respectivamente\
$$I_M, I_G$$: correntes de linha do motor e gerador, respectivamente\
$$I_d^M, I_d^G$$: correntes de campo do motor e gerador, respectivamente\
$$p_J^M, p_J^G$$:  perdas de Joule do motor e gerador, respectivamente\
$$P_d^M/T_d^M, P_d^G/T_d^G$$: potências/binários desenvolvidas(os) do motor e gerador, respectivamente\
$$p^M_{(mec+Fe)}=p^G_{(mec+Fe)}=p_{(mec+Fe)}$$: as perdas mecânicas e magnéticas das máquinas consideram-se iguais, dado que as máquinas têm dimensões/características semelhantes\
$$T_d^M=T_d^G=T_d$$: também se conclui que os binários desenvolvidos são iguais, $$T_d=T_u+\frac{p_{(mec+Fe)}}{ω_m}$$ \
$$P_{u}^M, P_{u}^G$$: potências úteis do motor e gerador, respectivamente\
$$E^{'},E$$: força contra-electromotriz do motor, força electromotriz do gerador\
$$R_i/ω_m$$: resistência rotórica/velocidade das máquinas\
$$p_{totais}$$: perdas totais do sistema *back-to-back*\
"""

# ╔═╡ 1133a4d3-17b1-457f-8df4-0132e99084ef


# ╔═╡ ff5f3ca6-f335-4359-b2a1-9d33e3d6a34f
md"""
## Cálculo de rendimento das máquinas DC
"""

# ╔═╡ eb9e7d9e-9471-11eb-2576-1d2ddaf38286
md"""
O motor absorve a soma das correntes da rede e do gerador:
"""

# ╔═╡ 39f02df2-8e7d-11eb-0060-a51ecba0d7e2
Imot=Irede+Iger

# ╔═╡ 1416c030-9472-11eb-3e74-2592f31b611f
md"""
O motor alimenta mecanicamente o gerador, e o gerador alimenta eletricamente o motor. Por conseguinte, a corrente absorvida da rede DC corresponde às perdas do sistema *back-to-back*, ou seja, à soma das perdas totais de cada máquina elétrica.
"""

# ╔═╡ 0045e950-8e7d-11eb-2ca6-e71464491d80
ptotais=Urede*Irede

# ╔═╡ 74d1a110-9472-11eb-0420-05593831db70
md"""
Cálculo das perdas por efeito de Joule no circuito induzido de cada máquina:
"""

# ╔═╡ 67168f40-8e7d-11eb-1891-47e5fa079677
begin
	pJmot=Ri*(Imot-Idmot)^2
	pJmot=round(pJmot, digits=1)
end

# ╔═╡ 8387e6b0-8e7d-11eb-0555-8b1476d0b78e
begin
	pJger=Ri*(Iger+Idger)^2
	pJger=round(pJger, digits=1)
end

# ╔═╡ 90cfeb5e-9472-11eb-139d-618a1a8e00ec
md"""
Cálculo das perdas por efeito de Joule no circuito indutor de cada máquina:
"""

# ╔═╡ 00fb6130-8e7e-11eb-28e6-5dd0a60e0b4d
pdger=Urede*Idger

# ╔═╡ 0013c050-8e7e-11eb-39bf-63ff813d72bc
pdmot=Urede*Idmot

# ╔═╡ f5fc0910-9472-11eb-2a24-d5a534519ffb
md"""
Atendendo ao balanço de potências dos sistema "back-to-back" e uma vez que as máquinas têm dimensões aproximadas e estão mecanicamente acopladas, considera-se que ambas as máquinas apresentam o mesmo valor para as perdas mecânicas e magnéticas, $$p_{mec+Fe}$$.
"""

# ╔═╡ 398b69cc-ce85-4f47-96aa-05fe70fe01ae
md"""
Assim, as $$p_{mec+Fe}$$ são determinadas a partir do somatório de perdas do sistema *back-to-back*, $$p_{totais}$$:
"""

# ╔═╡ f85470b5-a5c6-4cb7-ba6a-0f0b93f912cb
md"""
$$p_{totais}=p_J^M + p_J^G + 2 p_{(mec+Fe)}$$  
"""

# ╔═╡ 7cfda3ee-210d-4ec3-80a0-7565558a9ebb
md"""
$$p_{totais}=R_i(I_M-I_d^M)^2+R_i(I_G+I_d^G)^2+U(I_d^M+I_d^G)+2p_{mec+Fe}$$  
"""

# ╔═╡ ca862fe0-8e7d-11eb-15e4-9bacf3c6a3cd
begin
	pMecMag=0.5*(ptotais-pdmot-pJmot-pdger-pJger)
	pMecMag=round(pMecMag, digits=1)
end

# ╔═╡ bcf6a510-9474-11eb-0f2a-c9c38c539fbc
md"""
Cálulo da potência útil do motor:
"""

# ╔═╡ c916f300-8e7e-11eb-3539-b15966b16e20
begin
	Pu_mot=Urede*Iger+pdger+pJger+pMecMag
	Pu_mot=round(Pu_mot, digits=1)
end

# ╔═╡ ce840d90-9474-11eb-16ba-45a0a75923d6
md"""
Cálculo dos rendimentos de cada uma das máquinas:
"""

# ╔═╡ 9dfd6771-cf58-4611-88c4-411343fc413e
md"""
### Rendimento do motor
"""

# ╔═╡ 40315de2-8e7f-11eb-1055-d5f99815f7b8
begin
	Rend_mot=Pu_mot/(Urede*Imot)
	Rend_mot=round(Rend_mot*100, digits=1)
end;

# ╔═╡ e9e52514-8600-4d75-ac75-af0f0fb84932
md"""
Verifica-se um rendimento do motor, $$η_M$$=$Rend_mot%.
"""

# ╔═╡ 78c06010-9475-11eb-2e84-df6c2e9557ec
md"""
### Rendimento do gerador
"""

# ╔═╡ 5c8df4d0-8e7f-11eb-30fa-830a727b42d7
begin
	#Rend_ger=(Urede*Iger)/(Urede*Imot-pJmot-pdmot-pMecMag) outra opção!
	Rend_ger=(Urede*Iger)/(Pu_mot)
	Rend_ger=round(Rend_ger*100, digits=1)
end;

# ╔═╡ 343a8117-06e2-45a2-9267-dfec541c4ee7
md"""
Verifica-se um rendimento do gerador, $$η_G$$=$Rend_ger%.
"""

# ╔═╡ b8564c80-9475-11eb-0a0c-754025230130


# ╔═╡ 8d909780-9475-11eb-39d7-71a108a149f7
md"""
# Análise de funcionamento do sistema *back-to-back*
"""

# ╔═╡ 8e3c4c60-946b-11eb-10f6-f9167c118e1d
md"""
Para se compreender melhor o funcionamento do sistema *back-to-back* são calculadas as forças eletromotrizes de cada uma das máquinas considerando $$ΔE=0$$V:
"""

# ╔═╡ 4ce92990-8f1b-11eb-18d9-494490c1a6b9
Eger=Urede+Ri*(Iger+Idger)

# ╔═╡ 6af2d440-8f1b-11eb-2dfb-51ec8b20953f
Emot=Urede-Ri*(Imot-Idmot)

# ╔═╡ 6172ea10-9469-11eb-05ea-4d0bffbdd7df
md"""
E considera-se uma mesma característica magnética para estas máquinas de corrente contínua, contendo os pontos calculados:
"""

# ╔═╡ 99eeb8e0-8f1b-11eb-22e2-45d62100010b
begin
	Iex=[0, 0.3, 0.5, 0.7, 0.8, 0.9, 1.0, 1.2, 1.6]
	E=[10, 110, 170, Emot, 242, 260, Eger, 280, 284]
	Iex, E
end

# ╔═╡ 847e7b70-8f1c-11eb-1ef8-017b9545ce46
plot(Iex,E, ylabel="E(V)", xlabel="Iexc(A)", label=false, title="E=f(Iexc)", minorticks=5)

# ╔═╡ 15ef6550-8f23-11eb-39cc-53072258bb22
md"""
Admitindo que a velocidade é  aproximadamente inversamente proporcional ao fluxo magnético, $$kϕ$$ (desprezando o efeito de carga do gerador no motor, no cálculo da velocidade), é possível traçar o lugar geométrico de funcionamento de cada uma das máquinas no ensaio *back-to-back*.\
\
Nos gráficos seguintes, $$T=f(I_G; I_M)$$ e $$E=f(I_G; I_M))$$, apresentam-se os pontos de funcionamento de cada uma das máquinas em função das correntes de excitação. Partindo dos dados iniciais do enunciado, considerou-se positiva a corrente da máquina $$G$$ (a gerar corrente) e o seu binário negativo. Na máquina $$M$$ considerou-se a corrente negativa e binário positivo (produz binário).
"""

# ╔═╡ 439e78d0-946c-11eb-1fff-fbe61e97686e
md"""
Assim poderá verificar, por atuação nas correntes de campo de cada uma das máquinas, o comportamento do sistema *back-to-back*. Procure analisar a reversibilidade nos modos de operação das máquinas neste sistema:
"""

# ╔═╡ 40176270-8f1d-11eb-2e49-ef112a0de436
begin
	H1=("Idmotor", @bind Idm PlutoUI.Slider(0:0.01:1.6, default=0.7,show_value=true))
	H2=("Idgerador", @bind Idg PlutoUI.Slider(0:0.01:1.6, default=1, show_value=true))
	H1, H2
end

# ╔═╡ 14e847d0-8f1e-11eb-2bae-1d911632d08e
begin
	E_i=Spline1D(Iex,E)
	E_idm=E_i(Idm)
	nmag=1500
	kϕm=E_idm/nmag
	n=Emot/kϕm
	#n=let
	#IMot=70
	#	n=(Urede-Ri*IMot)/kϕm
	#end
	Eₙ=(n/1500).*E
	Eₙ_i=Spline1D(Iex,Eₙ)
	Eₙ_idg=Eₙ_i(Idg)
	IGer=(Eₙ_idg-Urede)/Ri-Idg
	perdas_ger=pMecMag+Ri*(IGer+Idg)^2+Idg*Urede
	Pmec=Urede*IGer+perdas_ger
	Tmec=Pmec/(2*π*n/60)
	Td=Tmec+pMecMag/(2*π*n/60)
	IMot=Td/(kϕm*30/π)
	Il1=IMot-IGer
	perdas_mot=pMecMag+Ri*(IMot-Idm)^2+Idm*Urede
	perdas_totais=perdas_mot+perdas_ger
	Il2=perdas_totais/Urede
	Il1, Il2, Tmec, IMot, IGer
end;

# ╔═╡ bb2c4050-94ab-11eb-0bc4-07a4f136a28e
begin
	P1=plot([-IMot], [Tmec], markershape=:circle, ylims=(-200,200), xlims=(-100,100),framestyle = :origin, ylabel="T (Nm)", xlabel="Correntes (M, G)", label="máq. M", minorticks=5)
	plot!([IGer], [-Tmec], markershape=:circle, label="máq. G", legend=:topright)	
	P2=plot([-IMot], [E_idm], markershape=:circle, ylims=(0,300), xlims=(-100,100), ylabel="FEM (V)", xlabel="Correntes (M, G)", minorticks=5, legend=:none)	
	plot!([IGer], [Eₙ_idg], markershape=:circle, framestyle = :origin)
	#plot!([Urede], seriestype=:hline, linecolor=:green,linestyle=:dash, legend=:none)
	plot(P1, P2, layout = (1, 2))
	
end

# ╔═╡ cda0b370-9469-11eb-1333-95ae3238d10a
md"""
!!! nota
O cálculo exacto da velocidade apenas seria possível com o conhecimento do modelo dinâmico de cada uma das máquinas, realizando uma simulação numérica de análise temporal, dado que as máquinas se influenciam mutuamente e são interdependentes no seu funcionamento e assim as correntes no induzido.\
Essa análise completa de estudo dinâmico, envolvendo todas as grandezas das máquinas que iriam variar no tempo (sempre que houvesse alteração de uma das correntes de campo), está fora do âmbito de ME2.\
Assim, o resultados gráficos apresentados, $$T=f(I_G; I_M)$$ e $$E=f(I_G; I_M))$$ são uma aproximação do funcionamento do sistema *back-to-back* em regime permanente.

"""

# ╔═╡ 97d0ab6e-b2e4-4962-a283-c56830bd9956


# ╔═╡ 7bd2d91d-513b-4b3a-a27b-6b75ddb4b626
version=VERSION;

# ╔═╡ f425c8ef-b82d-437d-a2af-70fd7fbec0cc
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 05/Mai/2021
"""

# ╔═╡ Cell order:
# ╟─eff8adc4-fece-4100-a088-2647846e5274
# ╟─7da26ca2-87a1-4354-883a-986b01a3888f
# ╟─d4a96a60-9471-11eb-16ff-7368120811fc
# ╠═cdeb7060-8e7c-11eb-2f84-5f69d99ccba7
# ╟─a9159fd4-9306-44f6-97b4-fd4bf273e635
# ╟─f11c3187-8e71-4261-859f-4806cb920697
# ╟─42aa2d0e-da50-477f-8178-a85fe879bc94
# ╟─1133a4d3-17b1-457f-8df4-0132e99084ef
# ╟─ff5f3ca6-f335-4359-b2a1-9d33e3d6a34f
# ╟─eb9e7d9e-9471-11eb-2576-1d2ddaf38286
# ╠═39f02df2-8e7d-11eb-0060-a51ecba0d7e2
# ╟─1416c030-9472-11eb-3e74-2592f31b611f
# ╠═0045e950-8e7d-11eb-2ca6-e71464491d80
# ╟─74d1a110-9472-11eb-0420-05593831db70
# ╠═67168f40-8e7d-11eb-1891-47e5fa079677
# ╠═8387e6b0-8e7d-11eb-0555-8b1476d0b78e
# ╟─90cfeb5e-9472-11eb-139d-618a1a8e00ec
# ╠═00fb6130-8e7e-11eb-28e6-5dd0a60e0b4d
# ╠═0013c050-8e7e-11eb-39bf-63ff813d72bc
# ╟─f5fc0910-9472-11eb-2a24-d5a534519ffb
# ╟─398b69cc-ce85-4f47-96aa-05fe70fe01ae
# ╟─f85470b5-a5c6-4cb7-ba6a-0f0b93f912cb
# ╟─7cfda3ee-210d-4ec3-80a0-7565558a9ebb
# ╠═ca862fe0-8e7d-11eb-15e4-9bacf3c6a3cd
# ╟─bcf6a510-9474-11eb-0f2a-c9c38c539fbc
# ╠═c916f300-8e7e-11eb-3539-b15966b16e20
# ╟─ce840d90-9474-11eb-16ba-45a0a75923d6
# ╟─9dfd6771-cf58-4611-88c4-411343fc413e
# ╟─e9e52514-8600-4d75-ac75-af0f0fb84932
# ╠═40315de2-8e7f-11eb-1055-d5f99815f7b8
# ╟─78c06010-9475-11eb-2e84-df6c2e9557ec
# ╟─343a8117-06e2-45a2-9267-dfec541c4ee7
# ╠═5c8df4d0-8e7f-11eb-30fa-830a727b42d7
# ╟─b8564c80-9475-11eb-0a0c-754025230130
# ╟─8d909780-9475-11eb-39d7-71a108a149f7
# ╟─8e3c4c60-946b-11eb-10f6-f9167c118e1d
# ╠═4ce92990-8f1b-11eb-18d9-494490c1a6b9
# ╠═6af2d440-8f1b-11eb-2dfb-51ec8b20953f
# ╟─6172ea10-9469-11eb-05ea-4d0bffbdd7df
# ╠═99eeb8e0-8f1b-11eb-22e2-45d62100010b
# ╟─847e7b70-8f1c-11eb-1ef8-017b9545ce46
# ╟─15ef6550-8f23-11eb-39cc-53072258bb22
# ╟─439e78d0-946c-11eb-1fff-fbe61e97686e
# ╟─40176270-8f1d-11eb-2e49-ef112a0de436
# ╟─bb2c4050-94ab-11eb-0bc4-07a4f136a28e
# ╟─14e847d0-8f1e-11eb-2bae-1d911632d08e
# ╟─cda0b370-9469-11eb-1333-95ae3238d10a
# ╟─97d0ab6e-b2e4-4962-a283-c56830bd9956
# ╟─f425c8ef-b82d-437d-a2af-70fd7fbec0cc
# ╟─70306b60-8e63-11eb-2569-c35a693dc465
# ╟─7bd2d91d-513b-4b3a-a27b-6b75ddb4b626
