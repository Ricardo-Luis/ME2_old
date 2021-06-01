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

# ╔═╡ 1ee828c1-45be-47cf-ba38-3e1abd294d95
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

# ╔═╡ c4d275c8-36d5-454f-bf1f-ddbc06beeae0
html"<button onclick='present()'>present</button>"

# ╔═╡ 17bc7f80-c13c-11eb-227f-b125d84c8b40
md"""
# Exercício 8

Uma máquina síncrona 3~ de pólos salientes, 50MVA, 11kV, 60Hz, enrolamentos do
estator em Y, apresenta as reatâncias: $$X_d=0.8\mathrm pu$$ e $$X_q=0.4\mathrm pu$$. Como motor síncrono é colocado
à plena carga com fator de potência 0,8 indutivo. As perdas mecânicas representam são 0,15pu.
Despreze as perdas na resistência do induzido.
"""

# ╔═╡ 20ed504e-08d1-45b9-8494-c42170182898
(Sₙ, Uₙ, f, Xd, Xq, cosφₙ, pᵣₒₜ)=(50e6, 11e3, 60, 0.8, 0.4, 0.8, 0.15)

# ╔═╡ 25f9aa0c-efa0-4c8a-bbfb-c5648bf2f8a2
md"""
## alínea a)

**a) Determine $$X_d$$ e $$X_q$$ em Ω;**

"""

# ╔═╡ 0545e797-9d40-48c4-ab96-195959331560
md"""
A utilização de *valores por unidade*, $$\mathrm {pu}$$,  apresenta diversas vantagens:
 - permite uma melhor comparação relativa entre máquinas de diferentes potências;
 - torna as grandezas adimensionais, facilitando a observação das mesmas face aos valores nominais de funcionamento;
 - simplifica a utilização do factor $$\sqrt3$$ em sistemas trifásicos.

Definindo a potência de base, $$S_b$$, e a tensão de base, $$U_b$$:

$$S_b=S_n\quad;\quad U_b=U_n$$

como: $$\quad S_b=U_bI_b\quad \Leftrightarrow \quad S_b=\frac{U_b^2}{Z_b}\quad \Rightarrow\quad Z_b=\frac{U_b^2}{S_b}$$

sendo $$Z_b$$ a impedância de base. Assim:

$$\begin{cases}X_d(\Omega) = X_d(\mathrm{pu}).Z_b\\X_q(\Omega) = X_q(\mathrm{pu}).Z_b \end{cases}$$
"""

# ╔═╡ 342aacbe-df8e-42b9-a7a2-8538476f2a80
begin
	Sb=Sₙ
	Ub=Uₙ
	Zb=Ub^2/Sb
	Xd_Ω=Xd*Zb
	Xq_Ω=Xq*Zb
	Xd_Ω, Xq_Ω
end

# ╔═╡ 65dd0a07-ff99-4887-8a86-142248705131
md"""
## alínea b)


**b) Determine a fem em pu;**
"""

# ╔═╡ 8b677658-96a8-40cb-b4cf-1638703dda22
md"""
A força contra-electromotriz (fcem) de vazio, $$E'_0$$, do motor síncrono de pólos salientes vem dada pela equação vectorial:

$$\overline{E'}_0=\overline{U}-(R+jX_q)\overline{I}-j(X_d-X_q)\overline{I}_d$$

com: $$\quad\overline{E'}=\overline{U}-(R+jX_q)\overline{I}$$

A determinação do vector fcem efectiva, $$\overline{E'}$$, (cálculo intermédio de $$\overline{E'}_0$$) permite definir a posição espacial dos eixos directo (linha dos polos) e de quadratura (posicão das fcem), uma vez que se obtém o ângulo de carga, $$\delta$$.
"""

# ╔═╡ 3ec74057-fcbb-4d79-8aca-719289c2299e
md"""
O cálculo de $$\overline I_d$$ é obtido a partir da relação trigonométrica com o vector da corrente, $$\overline I$$, observado o diagrama vectorial de tensões:

Assim, no caso concreto:  

$$\overline I_d=I\sin(|\varphi|-|\delta|)\angle (\delta-90°)$$
"""

# ╔═╡ 49053499-f759-4043-a9b8-48f42e45589a
md"""
### Diagrama vectorial de tensões do motor síncrono de pólos salientes
"""

# ╔═╡ 19c628e8-60c9-46d0-9ab8-78e70b8bfa6f
md"""
## alínea c)

**c) Determine a potências desenvolvidas (em pu) devido à fem de excitação e devido ao
efeito de relutância do rotor;**
"""

# ╔═╡ 2cd26842-6c40-4dc0-9979-da4685630aa1
md"""
As parcelas da potência desenvolvida em *valores por unidade* são determinadas pelas expressões:

$$P_d^{fcem}(pu)=\frac{UE'_0}{X_d}\sin \delta$$
$$P_d^{rel}(pu)=\frac{U^2(X_d-Xq)}{2X_dX_q}\sin(2\delta)$$

O que resulta:
"""

# ╔═╡ 6bc18d01-7285-4b7b-9769-3a7d52baae75
md"""
## alínea d)
**d) Se a corrente de excitação for reduzida a zero, a máquina continua em sincronismo?
Justifique;**
"""

# ╔═╡ 60f80e79-eeb8-4b60-801f-98caa28b4dfd
md"""
Por conseguinte, como: $$|P_d^{rel}(max)|< |P_d|$$, conclui-se que o motor perderia o sincronismo nesta situação $$(\space I_{exc}=0\space\mathrm {pu})$$, passando a um funcionamento instável.
"""

# ╔═╡ dd7d16e4-7b01-4aa0-a1ba-ecc7881900fb
md"""
## alínea e)

**e) Se a carga ao veio for retirada e a corrente de excitação reduzida a zero, determine o valor da corrente do estator (em pu) e o fator de potência. Desenhe o diagrama vectorial da máquina para esta situação.**
"""

# ╔═╡ 61609aa9-9feb-4a63-b4e9-2fd9a88f8106
md"""
Sem carga ao veio, $$\quad P_u=0\mathrm W\quad \Rightarrow \quad P_d=p_{rot}=0.15\mathrm{pu}$$.

Por outro lado, $$\quad I_{exc}=0\mathrm A\quad \Rightarrow \quad E'_0\simeq 0\mathrm V \quad \Rightarrow \quad P_d^{fcem}\simeq 0\mathrm W$$.

Por conseguinte, $$\quad P_d^{rel}=p_{rot}=0.15\mathrm{pu}\quad$$ com $$\quad P_d^{rel}$$:

$$P_d^{rel}(pu)=\frac{U^2(X_d-X_q)}{2X_dX_q}\sin(2\delta_0)$$
"""

# ╔═╡ 28da7f3c-97fd-4a80-ad21-eeb201dcc881
md"""
Do diagrama vectorial de tensões deste motor síncrono, retiram-se as seguintes relações para as componentes da corrente, $$I$$, nos eixos directo e de quadratura, em função do ângulo de carga, δ:

$$\begin{cases}I_q=\frac{U}{X_q}\sin(|\delta|) \\I_d=\frac{U}{X_d}\cos(\delta)-\frac{E'_0}{X_d}\end{cases}$$

Vectorialmente as componentes da corrente nos eixos directo e de quadratura ficam representadas por:

$$\begin{cases}\overline I_q=I_q\angle \delta\\ \overline I_d= I_d\angle (\delta-90°)\end{cases}$$

Assim, o vector de corrente, $$\overline I$$ é obtido por:

$$\overline I=\overline I_d+\overline I_q$$
"""

# ╔═╡ b47b956c-8880-4c22-aeea-d9a55c518b6a
md"""
Para se perceber o efeito das reduções da carga ao veio e da corrente de excitação, criou-se um segundo diagrama vectorial de tensões/correntes, mas dependente da posição de 2 cursores (*sliders*) associados à variação de cada um dos parâmetros $$(\delta$$ e $$I_{exc})$$, permitindo observar os seus efeitos sucessivos no desenho do diagrama vectorial:
"""

# ╔═╡ 311eecf2-4bd6-44bc-8c67-a680f4fd5d33
md"""
### Diagrama vectorial de tensões, em vazio e sem $$I_{exc}$$ 
"""

# ╔═╡ 78a2ef93-5ed1-44f8-8aa9-7e7d8d80a2df
md"""
Repare-se para qualquer valor do ângulo de carga, $$\delta$$, quando a corrente de excitação se torna nula, a fcem de vazio, $$\overline {E'}_0$$, torna-se também nula e o diagrama vectorial de tensões pode ser representado apenas pelo triângulo rectângulo formado pelos vectores: $$\quad\overline U$$, $$\space\space-jX_q\overline I_q\quad$$ e $$\quad-jX_d\overline I_d$$. 

Ou seja: $$\quad\overline {E'}_0=\overline U -jX_q\overline I_q -jX_d\overline I_d\quad$$ com $$\quad\overline {E'}_0=0 \space\mathrm{pu}$$.
"""

# ╔═╡ c5cc14a5-73c6-4f10-bc3e-bd7b68eddafa
md"""
!!! nota
Os resultados da **alínea e)** são corretamente apresentados apenas quandos os cursores se encontrem nas posições:

$$\delta=\delta_0 \quad \mathrm e \quad I_{exc}=0 \space\mathrm {pu}$$.
"""

# ╔═╡ d58c2390-6aaa-4e73-b360-9f0e9d20b37e
md"""
# Setup
"""

# ╔═╡ b4aea351-3195-4dc2-8cfa-b423a029b840
TableOfContents(title="Índice")

# ╔═╡ 0da89bf2-a4c0-4416-9657-aacc85bedce8
md"""
## *Notebook*: acEx8.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FSynMachines-GitHub-yellowgreen.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/SynMachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ aa5713cd-579a-4b79-b8e9-f051189f02d4
md"""
### Operadores fasor `∠(x)` e imaginário `j(x)`:
"""

# ╔═╡ db949a4e-261c-4374-a806-6279370b287e
begin
	∠(x) = cis(deg2rad(x))
	j(x) = (x)*im
end;

# ╔═╡ d5d4554e-428a-457a-8fdb-47dc977f9d01
begin
	φₙ=-acos(cosφₙ)
	φₙ=rad2deg(φₙ)
	I=1 				# 1pu
	U=1 				# 1pu
	I_=(I)∠(φₙ)			# vector da corrente em pu
	U_=(U)∠(0)			# vector da tensão em pu
	
	# Cálculo de E':
	E_=U_-j(Xq)*I_
	E=abs(E_)
	E=round(E, digits=3)
	δ=angle(E_)
	δ=rad2deg(δ)
	δ=round(δ, digits=2)
	E, δ
end;

# ╔═╡ 4dd894c8-9b9b-474d-9a98-d805328b609e
md"""
Assim, obtém-se $$\overline{E'}=$$ $E ∠ $δ ° $$\space\mathrm {pu}$$.
"""

# ╔═╡ 45b5c9d8-93ce-4b64-8c81-431dcbc6531f
begin
	Pdʳᵉˡmax=-U^2*(Xd-Xq)/(2*Xd*Xq)
	Pdʳᵉˡmax=round(Pdʳᵉˡmax, digits=2)
end;

# ╔═╡ 892b1d19-c88a-4add-ac18-70e799e01092
begin
	δ₀=-0.5*asin(pᵣₒₜ*2*Xd*Xq/(U^2*(Xd-Xq)))
	δ₀=rad2deg(δ₀)
	δ₀=round(δ₀, digits=2)
end;

# ╔═╡ 33d13e0f-80c5-478c-99e5-e9de64a8d39a
md"""
De onde resulta o valor de $$\delta_0=$$ $δ₀ °.
"""

# ╔═╡ 1ea9ab83-10c8-4d5f-8489-e9a4754e7b1b
begin
	H1=("redução de carga, δ -> δ₀", @bind δ₂ PlutoUI.Slider(δ:0.01:δ₀, default=δ,show_value=true))
	H2=("redução de Iₑₓ, pu", @bind K₂ PlutoUI.Slider(0:0.1:1, default=1, show_value=true))
	H1, H2
end

# ╔═╡ 67b54cd9-af1a-4bb7-9a44-c66179adfbcb
begin
	φ₁=abs(φₙ*π/180)
	δ₁=abs(δ*π/180)
	Id_=(I*sin(φ₁-δ₁))∠(δ-90)
	Iq_=(I*cos(φ₁-δ₁))∠(δ)
	Id=abs(Id_)
	Id=round(Id, digits=3)
	Id, δ-90
end;

# ╔═╡ a2aac898-7c8a-42c6-a7ef-a3ff736d1ab6
md"""
O que permite obter: $$\quad \overline I_d=$$ $Id ∠ $(δ-90)° $$\space\mathrm {pu}$$.
"""

# ╔═╡ cde832b5-50ea-44d8-ae4e-f1907d7e31dc
begin
	relut_=j(Xd-Xq)*Id_
	E₀_=E_-relut_
	E₀=abs(E₀_)
	E₀=round(E₀, digits=3)
end;

# ╔═╡ 33a4d731-3f65-460d-a74e-609250fa6292
md"""
O vector da fcem de vazio, $$\overline{E'}_0$$, vem então dado por:

$$\overline{E'}_0=\overline{E'}-j(X_d-X_q)\overline{I}_d$$


Assim, obtém-se: $$\quad\overline{E'}_0=$$ $E₀ ∠ $δ ° $$\space\mathrm {pu}$$.
"""

# ╔═╡ 73b14af8-f204-4070-bab9-180b660a9029
begin
	# Pot. desenvolvida devido à fcem, pu:
	Pdᶠᵉᵐₚᵤ=(U*E₀/Xd)*sin(δ*π/180)
	Pdᶠᵉᵐₚᵤ=round(Pdᶠᵉᵐₚᵤ, digits=2)
	
	# Pot. desenvolvida devido ao efeito de relutância, pu:
	Pdʳᵉˡₚᵤ=(U^2*(Xd-Xq)/(2*Xd*Xq))*sin(2*δ*π/180)
	Pdʳᵉˡₚᵤ=round(Pdʳᵉˡₚᵤ, digits=2)
	
	# Resultados
	Pdᶠᵉᵐₚᵤ, Pdʳᵉˡₚᵤ  					
end

# ╔═╡ a97592ef-28ef-4d83-b979-9e5550045cd0
Pdₚᵤ=Pdᶠᵉᵐₚᵤ + Pdʳᵉˡₚᵤ  ;

# ╔═╡ 2635c31e-8a91-45b0-8e4a-b4b6f6e59ae0
md"""
Com: $$\quad I_{exc}=0\space\mathrm {pu}\quad\Rightarrow\quad E'_0\simeq 0\space\mathrm {pu}\quad \Rightarrow\quad P_d^{fcem}\simeq 0\space\mathrm {pu}$$

Por outro lado, o ponto de funcionamento, $$P_d(\delta)$$, em regime nominal é dado por: $$P_d=P_d^{fcem}+P_d^{rel}=$$ ( $Pdᶠᵉᵐₚᵤ ) + ( $Pdʳᵉˡₚᵤ ) = $Pdₚᵤ pu.  
"""

# ╔═╡ f736b324-d6d9-4d8f-93d0-d520b79d4002
md"""
Assim, sem corrente de excitação, a potência desenvolvida devido ao efeito de relutância, $$P_d^{rel}$$,tem de suprir os $Pdₚᵤ pu, do ponto funcionamento.

O valor máximo da potência desenvolvida devido ao efeito de relutância, $$P_d^{rel}(max)$$, verifica-se para $$\delta=-45°$$, que permite obter:
$$P_d^{rel}(max)=\frac{U^2(X_d-Xq)}{2X_dX_q}=$$ $Pdʳᵉˡmax pu
"""

# ╔═╡ c79f1fef-c2f1-45b0-af35-f3e69e6ec77e
begin
	# eixos  d, q:
	plot([0+j(0), (1.3*cos(δ*π/180))+j(1.3*sin(δ*π/180))], 
		label="eixo de quadratura", arrow=:head, linecolor=:black, linestyle=:dashdot,			linewidth=2)
	plot!([0+j(0), (0.5*cos(δ*π/180+π/2))+j(0.5*sin(δ*π/180+π/2))],
		label="eixo directo", arrow=:head, linecolor=:black, linewidth=2)
	
	# E':
	K=0.5 # factor de escala da corrente
	_jXqI_=(Xq*I)∠(φₙ-90)
	plot!([0, U_], arrow=:closed, legend=:topright, label="U∠0°", linewidth=2)
	plot!([0, K*I_], arrow=:closed, label="I∠φ", linewidth=2)
	plot!([U_, U_+_jXqI_], arrow=:closed, label="XqI∠-90°", linewidth=2)
	plot!([0,E_], arrow=:closed, minorticks=5, label="E'∠δ", linewidth=2, 					  linecolor=:blue, ylims=(-0.75,0.75), xlims=(-0.25,1.25), size=(600,600))
	
	# Id_, Iq_:
	plot!([0, K*Id_],arrow=:closed, label="Id∠(δ-90°)")
	plot!([0, K*Iq_],arrow=:closed, label="Iq∠(δ)")
	
	#E´₀:
	plot!([U_+_jXqI_,U_+_jXqI_-relut_], arrow=:closed, label="(Xd-Xq)Id∠(δ)", linewidth=2)
	plot!([0,E₀_], arrow=:closed, label="E'₀∠δ", linewidth=3)		  
end

# ╔═╡ 5861683f-db8a-4d43-9822-f2f47431c191
begin
	# vector Iq:
	Iq₂=(U/Xq)*sin(abs(δ₂*π/180))
	Iq₂_=(Iq₂)∠(δ₂)
	# vector Id:
	E₀₂=E₀*K₂
	Id₂=(U/Xd)*cos(δ₂*π/180)-E₀₂/Xd
	Id₂_=(Id₂)∠(δ₂-90)
	# vector I, cosφ:
	I₂_=Id₂_+Iq₂_
	I₂=abs(I₂_)
	I₂=round(I₂, digits=2)
	φ₂=angle(I₂_)
	fdp=cos(φ₂)			# factor de potência (motor subexcitado -> indutivo)
	φ₂=rad2deg(φ₂)
	fdp=round(fdp, digits=3)
	I₂, fdp, δ₂, E₀₂ 	# RESULTADOS
end

# ╔═╡ 9e141f07-ad66-41f4-a53b-b6c25e4afbb2
begin
	# eixos  d, q:
	plot([0+j(0), (1.2*cos(δ₂*π/180))+j(1.2*sin(δ₂*π/180))], 
		label="eixo de quadratura", arrow=:head, linecolor=:black, linestyle=:dashdot,			linewidth=2)
	plot!([0+j(0), (0.35*cos(δ₂*π/180+π/2))+j(0.35*sin(δ₂*π/180+π/2))],
		label="eixo directo", arrow=:head, linecolor=:black, linewidth=2, 
		ylims=(-0.75,0.75), xlims=(-0.25,1.25), size=(600,600))
	
	# parte idêntica a polos lisos:
	_jXqI₂_=(Xq*I₂)∠(φ₂-90)
	plot!([0, U_], arrow=:closed, legend=:topright, label="U∠0°", linewidth=2)
	plot!([0, K*I₂_], arrow=:closed, label="I∠φ", linewidth=2)
	plot!([U_, U_+_jXqI₂_], arrow=:closed, label="XqI∠-90°", linewidth=2)
	E₂_=U_-j(Xq)*I₂_
	plot!([0,E₂_], arrow=:closed, minorticks=5, label="E'∠δ", linewidth=2)
	
	# Id_, Iq_:
	plot!([0, K*Id₂_],arrow=:closed, label="Id∠(δ-90°)", linewidth=1)
	plot!([0, K*Iq₂_],arrow=:closed, label="Iq∠(δ)", linewidth=1)
	
	#E´₀:
	relut₂_=j(Xd-Xq)*Id₂_
	E₀₂_=E₂_-relut₂_
	plot!([U_+_jXqI₂_,U_+_jXqI₂_-relut₂_], arrow=:closed, label="(Xd-Xq)Id∠(δ)", linewidth=2)
	plot!([0,E₀₂_], arrow=:closed, label="E'₀∠δ", linewidth=3)
	
	#-jXqIq_ e -jXdId_
	vectorXqIq=-j(Xq)*Iq₂_
	vectorXdId=-j(Xd)*Id₂_
	plot!([U_, U_+vectorXqIq],arrow=:closed, label="XqIq∠(δ-90°)",linewidth=3)
	plot!([U_+vectorXqIq, U_+vectorXqIq+vectorXdId],arrow=:closed, label="XdId∠(δ-180°)", linewidth=3) 
end

# ╔═╡ 70f24b20-0646-49b4-9ff7-6561e4c65404
version=VERSION;

# ╔═╡ 08cc1882-edff-408b-bcad-f4d03f99f8ae
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 01/Jun/2021
"""

# ╔═╡ Cell order:
# ╟─c4d275c8-36d5-454f-bf1f-ddbc06beeae0
# ╟─17bc7f80-c13c-11eb-227f-b125d84c8b40
# ╠═20ed504e-08d1-45b9-8494-c42170182898
# ╟─25f9aa0c-efa0-4c8a-bbfb-c5648bf2f8a2
# ╟─0545e797-9d40-48c4-ab96-195959331560
# ╠═342aacbe-df8e-42b9-a7a2-8538476f2a80
# ╟─65dd0a07-ff99-4887-8a86-142248705131
# ╟─8b677658-96a8-40cb-b4cf-1638703dda22
# ╟─4dd894c8-9b9b-474d-9a98-d805328b609e
# ╠═d5d4554e-428a-457a-8fdb-47dc977f9d01
# ╟─3ec74057-fcbb-4d79-8aca-719289c2299e
# ╟─a2aac898-7c8a-42c6-a7ef-a3ff736d1ab6
# ╠═67b54cd9-af1a-4bb7-9a44-c66179adfbcb
# ╟─33a4d731-3f65-460d-a74e-609250fa6292
# ╠═cde832b5-50ea-44d8-ae4e-f1907d7e31dc
# ╟─49053499-f759-4043-a9b8-48f42e45589a
# ╠═c79f1fef-c2f1-45b0-af35-f3e69e6ec77e
# ╟─19c628e8-60c9-46d0-9ab8-78e70b8bfa6f
# ╟─2cd26842-6c40-4dc0-9979-da4685630aa1
# ╠═73b14af8-f204-4070-bab9-180b660a9029
# ╟─6bc18d01-7285-4b7b-9769-3a7d52baae75
# ╟─2635c31e-8a91-45b0-8e4a-b4b6f6e59ae0
# ╠═a97592ef-28ef-4d83-b979-9e5550045cd0
# ╟─f736b324-d6d9-4d8f-93d0-d520b79d4002
# ╠═45b5c9d8-93ce-4b64-8c81-431dcbc6531f
# ╟─60f80e79-eeb8-4b60-801f-98caa28b4dfd
# ╟─dd7d16e4-7b01-4aa0-a1ba-ecc7881900fb
# ╟─61609aa9-9feb-4a63-b4e9-2fd9a88f8106
# ╟─33d13e0f-80c5-478c-99e5-e9de64a8d39a
# ╠═892b1d19-c88a-4add-ac18-70e799e01092
# ╟─28da7f3c-97fd-4a80-ad21-eeb201dcc881
# ╠═5861683f-db8a-4d43-9822-f2f47431c191
# ╟─b47b956c-8880-4c22-aeea-d9a55c518b6a
# ╟─1ea9ab83-10c8-4d5f-8489-e9a4754e7b1b
# ╟─311eecf2-4bd6-44bc-8c67-a680f4fd5d33
# ╟─9e141f07-ad66-41f4-a53b-b6c25e4afbb2
# ╟─78a2ef93-5ed1-44f8-8aa9-7e7d8d80a2df
# ╟─c5cc14a5-73c6-4f10-bc3e-bd7b68eddafa
# ╟─d58c2390-6aaa-4e73-b360-9f0e9d20b37e
# ╠═b4aea351-3195-4dc2-8cfa-b423a029b840
# ╟─0da89bf2-a4c0-4416-9657-aacc85bedce8
# ╠═1ee828c1-45be-47cf-ba38-3e1abd294d95
# ╟─aa5713cd-579a-4b79-b8e9-f051189f02d4
# ╠═db949a4e-261c-4374-a806-6279370b287e
# ╟─08cc1882-edff-408b-bcad-f4d03f99f8ae
# ╟─70f24b20-0646-49b4-9ff7-6561e4c65404
