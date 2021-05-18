### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ c35e6f98-820f-420f-ba4e-f35170c924ce
begin
	#import Pkg
	#Pkg.activate(mktempdir())
#No PC: Pkg.add... apenas na 1ª utilização:
#############################################
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	
#############################################
	using PlutoUI
	using Plots
	using Dierckx
end

# ╔═╡ c5d4b89b-e993-42db-95c7-d1c696a62802
html"<button onclick='present()'>present</button>"

# ╔═╡ 9c7efc2d-aa93-4746-ad51-dfca3b5fcd1f
md"""
# Notação polar $$\angle$$. Operador $$j$$
"""

# ╔═╡ f337f42a-0575-402c-ad17-dc86f8e312d5
md"""
Tal como no *notebook* anterior, podemos utilizar a notação fasorial de grandezas complexas através do símbolo $$\angle$$ (para o escrever, fazer: \angle + TAB) através da função:
"""

# ╔═╡ b5f146e5-7ac2-45d4-b98f-4ed80c9b54dd
∠(x) = cis(deg2rad(x))

# ╔═╡ 3fd1cd00-dad1-462b-bb21-263825403472
md"""
Do mesmo modo, se desejarmos escrever números complexos na forma rectangular, mas utilizando a unidade imaginária $$j$$, podemos simplesmente escrever a função:
"""

# ╔═╡ 4a9d2a16-19a7-4614-9227-fe6506ee27d9
j(x) = (x)*im

# ╔═╡ a7811011-589d-4279-89d2-96e07fe8a2c9
md"""
As funções definidas por `∠(x)` e `j(x)` servem apenas para facilitar a escrita comummente utilizada em engenharia electrotécnica quanto à representação de grandezas complexas. 

Como se pode verificar no exemplo seguinte, no produto de 2 números complexos, um deles na forma rectangular e o outro na forma polar, a linguagem *Julia* devolve-nos o resultado sempre na forma rectangular, com a unidade imaginária representada por `im`.
"""

# ╔═╡ 00acb211-8421-4103-969a-0b97e11cba49
A_=(2+j(10))*(10∠(60))

# ╔═╡ d6db36c2-66bd-44ed-a592-6ad04a27a1e4
md"""
Para obtermos o módulo e argumento do vector $$\overline{A}$$ representado por `A_`, basta utilizar respectivamente as instruções *Julia* `abs`, `angle`,  e ainda `rad2deg` para obter o ângulo em graus:
"""

# ╔═╡ 8a763d47-faa5-4222-86c8-92262107904c
begin
	A=abs(A_)
	α=angle(A_)
	α=rad2deg(α)
	A, α          # resultados
end

# ╔═╡ 76576293-835e-432e-93d2-e62d9689fba2
md"""
# Exercício 2
"""

# ╔═╡ a9743237-6408-406b-a8eb-9cbf8867f9ef
md"""
**Um gerador síncrono, ligação Y, 2300V, 1000kVA, factor de potência 0,8 indutivo,
60Hz, 2 pólos, tem uma reactância síncrona de 1,1Ω e uma resistência do induzido de 0,15Ω. A 60Hz, as perdas por atrito e ventilação são 24kW, e as perdas no ferro 18kW. O enrolamento de campo é alimentado por uma tensão contínua de 200V e o valor máximo de $$I_F$$ são 10A. A resistência do circuito de excitação é ajustável entre 20 a 200Ω. O ensaio em circuito aberto deste gerador é o apresentado na figura seguinte:**
"""

# ╔═╡ 42931953-b637-42f5-b451-ab374a89ea70
(Sₙ, Uₙ, cosφₙ, f, p, Xₛ, Rₛ, pᵣₒₜ, p_ferro)=(1000e3, 2300, 0.8, 60, 1, 1.1, 0.15, 24e3, 18e3)

# ╔═╡ c5955086-72bf-463f-a15c-1b2632086ff2
begin
	Iₑₓ=[0, 0.24, 0.58, 0.93, 1.12, 1.39, 1.67, 1.94, 2.18, 2.55, 2.80, 3.04, 3.29, 3.57, 3.78, 3.97, 4.25, 4.54, 4.94, 5.25, 5.68, 6.13, 6.62, 7.03, 7.55, 8.00, 8.43, 8.92, 9.47, 10.0]
	fem=[20.2, 176.8, 382.8, 626.8, 756.0, 914.0, 1086.2, 1244.0, 1378.0, 1570.0, 1698.6, 1812.8, 1928.2, 2038.2, 2128.8, 2200.8, 2292.0, 2392.4, 2498.0, 2560.0, 2636.4, 2694.0, 2746.4, 2784.8, 2818.2, 2846.8, 2870.8, 2894.8, 2914.0, 2928.2]
	Iₑₓ, fem 
end;

# ╔═╡ 4e44ac99-e751-49f0-a228-c8c34a2861f2
plot(Iₑₓ, fem,
	minorticks=5, title="E₀=f(Iₑₓ)", label=:none)

# ╔═╡ b2cfb3de-c46b-40c5-b982-da47b62a0628
md"""
## alínea a)
**a) Qual o valor da corrente de campo necessário para que a tensão composta do seja de
2300V, quando o alternador funciona em vazio?**
"""

# ╔═╡ c88ac310-ece1-4738-b936-0fcfde134810
md"""
A corrente de excitação define o valor da tensão de vazio no funcionamento do alternador, ou seja, $$U_0=E_0$$. Assim, assumindo que a característica magnética, $$E_0=f(I_{ex})$$, foi obtida para a velocidade síncrona da máquina, o valor da corrente de campo, $$I_{ex}$$, obtém-se por leitura de $$E_0=f(I_{ex})$$ para a tensão de $$2300$$V: 
"""

# ╔═╡ c64c2444-bb8b-4c52-960e-4c41445a98ca
# Através de leitura do gráfico, E₀=f(Iₑₓ)
begin
	plot(Iₑₓ, fem,
	minorticks=10, title="E₀=f(Iₑₓ)", label=:none, linewidth=2)
		
	# deslocar a recta vertical até intersectar 2300V em E₀=f(Iₑₓ): plot!([<->], ...)
	plot!([2300], seriestype=:hline, linestyle=:dash, label=:none)
	plot!([4.29], seriestype=:vline, linestyle=:dash, label=:none)
end

# ╔═╡ 825f12d2-9153-4ee1-9d83-640f49d88d6d
begin
	# Através interpolação linear de E₀=f(Iₑₓ) realizado pelo package Julia, Dierckx:
	i_E₀=Spline1D(fem, Iₑₓ)	
	Iₑₓ_2300=i_E₀(2300)
	Iₑₓ_2300=round(Iₑₓ_2300, digits=2)
end;

# ╔═╡ 24ae7ecd-9423-4edf-bf88-6e71f0e27d82
md"""
Em alternativa à leitura do gráfico de $$E_0=f(I_{ex})$$, pode-se consultar os dados de $$E_0$$ e $$I_{ex}$$ e obter a corrente de campo por interpolação linear. Assim, tém-se:

$$E_0=2300\mathrm{V}\:\in\:[(4.25\mathrm{A}, 2292.0\mathrm{V}),(4.44\mathrm{A}, 2392.4\mathrm{V})]$$

Por interpolação linear, obtém-se:

$$\frac{2392.4-2292.0}{4.44-4.25}=\frac{2392.4-2300.0}{4.44-I_{ex}}$$

 $$I_{ex}=$$ $(Iₑₓ_2300)A
"""

# ╔═╡ 4da8eaa3-0c65-4351-9242-adfc95af7353
md"""
## alínea b)
**b) Qual a fem gerada por esta máquina nas condições nominais?**
"""

# ╔═╡ 4d2962a9-0816-4b25-ae7b-f3c87d375428
md"""
Considerando a equação vectorial da força electromotriz, $$\overline{E}_0$$, por fase:

$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

Estando a máquina com as ligações em estrela: $$\quad U=\frac{U_n}{\sqrt3}\quad$$ e $$\quad I=I_n\quad$$ com $$\quad I_n=\frac{S_n}{\sqrt3U_n}$$

Assim, o vector da fem vem dado por:

$$\overline{E}_0=\frac{U_n}{\sqrt3}∠0°+(R_s+jX_s)(I_n∠\varphi)$$
"""

# ╔═╡ e29ade22-1092-4a05-b078-d5d50509b875
begin
	# Iₙ, φₙ:
	Iₙ=Sₙ/(√3*Uₙ)
	Iₙ=round(Iₙ, digits=1)
	φₙ=-acos(cosφₙ)
	φₙ=rad2deg(φₙ)
	φₙ=round(φₙ, digits=2)
	
	# E₀ₙ:
	E₀ₙ_=(Uₙ/√3)∠(0)+(Rₛ+j(Xₛ))*((Iₙ)∠(φₙ))
	E₀ₙ=abs(E₀ₙ_)
	E₀ₙ=round(E₀ₙ, digits=1)
	
	# δ:
	δₙ=angle(E₀ₙ_)
	δₙ=rad2deg(δₙ)
	δₙ=round(δₙ, digits=1)
	
	# resultados: A, °, °, V 	
	Iₙ, φₙ, δₙ, E₀ₙ  
end

# ╔═╡ a30977b0-751f-437d-b185-55127263b6bc
md"""
### Diagrama vectorial de tensões
"""

# ╔═╡ 2e347214-cf7b-452f-a041-ad117d869a16
begin
	K=3 # factor de escala da corrente
	Iₙ_=(K*Iₙ)∠(φₙ)
	Uₙ_=(Uₙ/√3)∠(0)
	RₛIₙ_=(Rₛ*Iₙ)∠(φₙ)
	jXₛIₙ_=(Xₛ*Iₙ)∠(φₙ+90)
	plot([0, Uₙ_], arrow=:closed, legend=:topleft, label="U∠0°")
	plot!([0, Iₙ_], arrow=:closed, label="Iₙ∠φ")
	plot!([Uₙ_, Uₙ_+RₛIₙ_], arrow=:closed, label="RₛIₙ∠φ")
	plot!([Uₙ_+RₛIₙ_,Uₙ_+RₛIₙ_+jXₛIₙ_], arrow=:closed, label="XₛIₙ∠(φ+90°)")
	plot!([0,E₀ₙ_], arrow=:closed,
		  minorticks=5, label="E₀∠δ",
		  ylims=(-800,800), xlims=(0,1600), size=(600,600))
end

# ╔═╡ f1abeadc-7d88-4cb3-8998-c4242460191e
md"""
## alínea c)
**c) Qual o valor da corrente de campo necessária para obter a tensão nominal, quando o alternador se encontra nas condições nominais?**
"""

# ╔═╡ 02deedfc-2306-470b-9a16-63b45a5ae638
md"""
Atendendo que os elementos de estudo da máquina síncrona: circuito equivalente, diagrama e equação vectoriais, são representações por fase do seu funcionamento em regime permanente, é necessário ter em conta que a fem entre fases, $$E_{0ff}$$, vem dada por:

$$E_{0ff}=E_0\sqrt3$$
"""

# ╔═╡ a7d1c835-2494-45ed-a8b2-a2cc89fb8636
# Através de leitura do gráfico, E₀=f(Iₑₓ)
begin
	
	
	plot(Iₑₓ, fem,
		minorticks=10, title="E₀=f(Iₑₓ)", label=:none, linewidth=2)
	plot!([E₀ₙ*√3], seriestype=:hline, linestyle=:dash, label=:none)
	
	# deslocar a recta vertical até intersectar 2300V em E₀=f(Iₑₓ): plot!([<->], ...)
	plot!([5.85], seriestype=:vline, linestyle=:dash, label=:none)
end

# ╔═╡ c653686d-f8d8-48c0-87dd-0b3c8027ce6a
begin
	# Através interpolação linear de, E₀=f(Iₑₓ)
	Iₑₓ_Uₙ=i_E₀(E₀ₙ*√3)
	Iₑₓ_Uₙ=round(Iₑₓ_Uₙ, digits=2)
end;

# ╔═╡ c08ae18e-7857-4dd0-b157-462ef9ab2c34
md"""
Assim, de modo similar ao realizado na alína a), obtém-se uma corrente de campo, $$I_{ex}=$$ $(Iₑₓ_Uₙ)A, por um dos processos anteriormente explicados:
"""

# ╔═╡ 3d61fd46-c01c-4c9a-ad5a-6182e8adef45
md"""
## alínea d)
**d) Quais os valores de potência e binário necessários para o accionamento deste alternador?**
"""

# ╔═╡ 593c3b9a-76be-4fe3-8f9d-baaf86035b8c
md"""
Considerando o balanço de potências da máquina síncrona em regime alternador, a potência mecânica recebida é dada por:

$$P_{ab}^{mec}=P_u+p_J^{est}+p_{rot}+ p_{Fe}$$

onde, $$\quad P_u=S_n\cos\varphi_n\quad$$ e $$\quad p_J^{est}=3R_sI_n^2$$ 

Assim, o binário de accionamento vem dado por:

$$T_{mec}=\frac{P_{ab}^{mec}}{\omega_{mec}}$$

em que, $$\quad \omega_{mec}=\frac{2\pi f}{p}\quad$$ com $$\quad p\quad$$ sendo o número de pares de pólos da máquina. 
"""

# ╔═╡ 4d172d04-2412-48cf-8136-ccce4fdb0c61
begin
	Pᵤ=Sₙ*cosφₙ
	Pⱼᵉˢᵗ=3*Rₛ*Iₙ^2
	Pab=Pᵤ+Pⱼᵉˢᵗ+pᵣₒₜ+p_ferro
	ωmec=2*π*f/p
	Tmec=Pab/ωmec
	Pab, Tmec 
end

# ╔═╡ 4d673ff6-e368-4c26-88dd-bc105a96e7c6
md"""
Note-se que neste balanço de potências não é considerada a potência no circuito de excitação para o cálculo do binário de accionamento. Sendo um circuito de excitação separada, as suas perdas não intervêm no processo de conversão de energia da máquina. 

Assim, a potência absorvida pelo circuito de excitação, $$P_{ab}^{exc}=U_{ex}I_{ex}$$, é totalmente dispendida em perdas por efeito de Joule, $$p_J^{exc}=R_FI_{ex}$$, por conseguinte, $$P_{ab}^{exc}=p_J^{exc}$$, entrando na determinação do rendimento da máquina síncrona, $$\eta$$, em que todas as perdas envolvidas são consideradas:

$$\eta=\frac{P_u}{P_{ab}^{mec}+p_J^{exc}}$$
"""

# ╔═╡ 5de1389d-a54c-48f0-9c93-4cf46c4c5a4a
md"""
## alínea e) Diagrama P-Q
**e) Obtenha o diagrama P-Q deste alternador;**
"""

# ╔═╡ 840f2ac8-2282-4cc7-8422-f7e1c078c7e9
md"""
Para a determinação do diagrama $$P$$\-$$Q$$, conhecidas também por *capability curves*, desprezam-se as perdas por efeito de Joule no estator, ou seja, $$R_s=0$$Ω.   

Assim, a partir do diagrama vectorial de tensões resultante, o afixo do vector da tensão, $$\overline{U}$$, marca o início de um sistema de eixos: potência activa (ordenada) e potência reactiva(abcissa).

Os módulos dos vectores: $$\overline{U}$$, $$j X_s\overline{I}$$ e $$\overline{E}_0$$ são multiplicados por $$\frac{3U}{X_s}$$ para se obter uma leitura de potências $$(\mathrm{VAr}, \mathrm{W})$$. Com a máquina em regime nominal são traçados o lugar geométrico das novas grandezas, com as designações:
- limite térmico do estator (lugar geométrico de $$\overline{S}=3U\overline{I}$$);
- limite térmico do rotor (lugar geométrico de $$\frac{3U\overline{E}_0}{X_s}-\frac{3U^2}{X_s}$$);
- Adicionalmente coloca-se o limite mecânico do accionamento/turbina.

No caso de um alternador, a área de funcionamento possível, cumprindo diversos os limites (estator, rotor, turbina), fica delimitada pelas curvas estabelecidas no diagrama P-Q, nos 1º e 2º quadrantes $$(\delta\geqslant0)$$.

"""

# ╔═╡ 6ff6db51-637d-49c6-815f-e179a9c4ffd5
begin
	# lugar geométrico do limite térmico do estator:
	ϕ=-10:1:190
	S_locus=(Sₙ)∠.(ϕ)
	plot(S_locus, label="limite térmico do estator", linewidth=2,
		size=(600,600), xlims=(-1500e3,1500e3), ylims=(-1500e3,1500e3),
		legend=:bottomleft, minorticks=5, title="Diagrama P-Q")
		
	# lugar geométrico do limite térmico do rotor:
	U=Uₙ/√3
	Q=-3*U^2/Xₛ
	DE=3*U*E₀ₙ/Xₛ
	ψ=-15:1:15
	R_locus=Q.+((DE)∠.(ψ))
	plot!(R_locus, label="limite térmico do rotor", linewidth=2)
	
	# lugar geométrico da turbina (accionamento):
	plot!([-1500e3+j(Pab), 1500e3+j(Pab)], label="limite mecânico da turbina", 				linewidth=2)
	
	# eixos: kW, kVAr
	plot!([-1500e3+j(0), 1500e3+j(0)], 
		label="eixo de potência reactiva (VAr)", arrow=:head, linecolor=:black, 			linewidth=2)
	plot!([-j(1500e3), j(1500e3)],
		label="eixo de potência activa (W)", arrow=:head, linestyle=:dash, 					linecolor=:black, linewidth=2)
end

# ╔═╡ 02f9cc22-91c5-4b01-90bc-3359008b6dc7
md"""
## alínea f)
**f) Considerando as condições nominais, obtenha a característica externa, $$U=f(I)$$, para $$\cos\varphi=0.8(i)$$, $$\cos\varphi=0.8(c)$$ e $$\cos\varphi=1$$;**
"""

# ╔═╡ 7111bdc6-fab3-48be-89c1-3ce91de11c57
md"""
O funcionamento do alternador nas condições nominais $$(I_n, U_n)$$ para diferentes factores de potência exige diferentes valores de força electromotriz, que se obtém pela equação vectorial por fase de $$\overline{E}_0$$.  

A determinação da caracterísica externa procede-se como já analisado no exercício anterior.
"""

# ╔═╡ 2b5da421-a849-4d34-b7d8-1acade30ee21
md"""
Determinação da característica externa para $$\cos\varphi=0,8(i)$$:
"""

# ╔═╡ 9d9ab479-b525-41ee-84ac-7fe5d88b6dfc
begin
	I=0:10:1.5*Iₙ
	cosφ₁=0.8
	φ₁=-acos(cosφ₁)
	Zₛ_=Rₛ+j(Xₛ)
	Zₛ=abs(Zₛ_)
	θ=angle(Zₛ_)
	E₀₁_=(Uₙ/√3)∠(0)+(Zₛ_)*((Iₙ)∠(φ₁*180/π))
	E₀₁=abs(E₀₁_)
	δ₁=asin.((Zₛ/E₀₁).*I*sin(θ+φ₁))  # δ: ângulo de carga, radianos
	U₁=E₀₁*cos.(δ₁).-Zₛ.*I*cos(θ+φ₁)  # cálculo da característica externa
	U₁c=U₁*√3
end

# ╔═╡ 58caf67b-b57d-47d2-b210-b86e662d117e
md"""
Determinação da característica externa para $$\cos\varphi=0,8(c)$$:
"""

# ╔═╡ f1cb6ed1-a8d8-439d-be7e-f3f62acc67d2
begin
	cosφ₂=0.8
	φ₂=acos(cosφ₂)
	E₀₂_=(Uₙ/√3)∠(0)+(Zₛ_)*((Iₙ)∠(φ₂*180/π))
	E₀₂=abs(E₀₂_)
	δ₂=asin.((Zₛ/E₀₂).*I*sin(θ+φ₂))  	 # δ: ângulo de carga, radianos
	U₂=E₀₂*cos.(δ₂).-Zₛ.*I*cos(θ+φ₂)	 # cálculo da característica externa
	U₂c=U₂*√3
end

# ╔═╡ ab07ed6e-e3da-469c-a4e9-dfd9524869ce
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ 947eaafe-4726-4c5a-92ec-27926dbf8e0a
begin
	φ₃=0
	E₀₃_=(Uₙ/√3)∠(0)+(Zₛ_)*((Iₙ)∠(φ₃*180/π))
	E₀₃=abs(E₀₃_)
	δ₃=asin.((Zₛ/E₀ₙ).*I*sin(θ+φ₃))  	 # δ: ângulo de carga, radianos
	U₃=E₀₃*cos.(δ₃).-Zₛ.*I*cos(θ+φ₃)	 # cálculo da característica externa
	U₃c=U₃*√3
end

# ╔═╡ d6f6628a-95aa-4860-bc54-3c065ca2d056
begin
	plot(I, U₁c, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), 
		framestyle = :origin, minorticks=5, label="cosφ=0.8(i)",
		legend=:bottomleft)
	plot!(I, U₃c, label="cosφ=1")
	plot!(I, U₂c, label="cosφ=0.8(c)")
end

# ╔═╡ 19a1c85d-25af-4aeb-ad7b-2d19396bde89
md"""
## alínea g)
**g) Para uma f.e.m de 2500V determine as características externas, $$U=f(I)$$, para $$\cos\varphi=0.8(i)$$, $$\cos\varphi=0.8(c)$$ e $$\cos\varphi=1$$;**
"""

# ╔═╡ 9c27b79c-2c53-44f0-b5e1-5d62570c3ba4
md"""
Determinação da característica externa para $$\cos\varphi=0,8(i)$$:
"""

# ╔═╡ da103e2c-d418-4704-968a-39943de1391c
begin
	E₀=2500/√3
	δ₄=asin.((Zₛ/E₀).*I*sin(θ+φ₁))  # δ: ângulo de carga, radianos
	U₄=E₀*cos.(δ₄).-Zₛ.*I*cos(θ+φ₁)  # cálculo da característica externa
	U₄c=U₄*√3
end

# ╔═╡ 5530ca56-7421-4521-abeb-566a8bdb9756
md"""
Determinação da característica externa para $$\cos\varphi=0,8(c)$$:
"""

# ╔═╡ 6dfefd2d-7a10-4b81-b1af-56aff856573d
begin
	δ₅=asin.((Zₛ/E₀).*I*sin(θ+φ₂))  # δ: ângulo de carga, radianos
	U₅=E₀*cos.(δ₅).-Zₛ.*I*cos(θ+φ₂)  # cálculo da característica externa
	U₅c=U₅*√3
end

# ╔═╡ c4698c03-47e3-4cb1-9817-a29618327303
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ 5146f962-549c-45c5-93e1-a51f5045724d
begin
	δ₆=asin.((Zₛ/E₀).*I*sin(θ+φ₃))  # δ: ângulo de carga, radianos
	U₆=E₀*cos.(δ₆).-Zₛ.*I*cos(θ+φ₃)  # cálculo da característica externa
	U₆c=U₆*√3
end

# ╔═╡ ae2ce7ad-3670-4691-9f90-1ac77d60259f
begin
	plot(I, U₄c, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), 
		framestyle = :origin, minorticks=5, label="cosφ=0.8(i)",
		legend=:bottomleft)
	plot!(I, U₅c, label="cosφ=1")
	plot!(I, U₆c, label="cosφ=0.8(c)")
end

# ╔═╡ fcf19990-b55d-11eb-3a0a-8fbb3bb1b9bf
md"""
# Setup
"""

# ╔═╡ 633cb44f-5f95-446d-9db4-f47f1c66b5f1
TableOfContents(title="Índice")

# ╔═╡ 06d630ad-9c41-4f66-80ac-48ea66efd67d
md"""
## *Notebook*: acEx2.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Dierckx`](https://github.com/kbarbary/Dierckx.jl), [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FSynMachines-GitHub-yellowgreen.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/SynMachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 9e41a351-cee3-4c3a-a31c-cf64d58092cb
version=VERSION;

# ╔═╡ 2b8e9c9f-ef1c-47f3-83c9-d83c466e78cf
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 18/Mai/2021
"""

# ╔═╡ Cell order:
# ╟─c5d4b89b-e993-42db-95c7-d1c696a62802
# ╟─9c7efc2d-aa93-4746-ad51-dfca3b5fcd1f
# ╟─f337f42a-0575-402c-ad17-dc86f8e312d5
# ╠═b5f146e5-7ac2-45d4-b98f-4ed80c9b54dd
# ╟─3fd1cd00-dad1-462b-bb21-263825403472
# ╠═4a9d2a16-19a7-4614-9227-fe6506ee27d9
# ╟─a7811011-589d-4279-89d2-96e07fe8a2c9
# ╠═00acb211-8421-4103-969a-0b97e11cba49
# ╟─d6db36c2-66bd-44ed-a592-6ad04a27a1e4
# ╠═8a763d47-faa5-4222-86c8-92262107904c
# ╟─76576293-835e-432e-93d2-e62d9689fba2
# ╟─a9743237-6408-406b-a8eb-9cbf8867f9ef
# ╠═42931953-b637-42f5-b451-ab374a89ea70
# ╠═c5955086-72bf-463f-a15c-1b2632086ff2
# ╟─4e44ac99-e751-49f0-a228-c8c34a2861f2
# ╟─b2cfb3de-c46b-40c5-b982-da47b62a0628
# ╟─c88ac310-ece1-4738-b936-0fcfde134810
# ╠═c64c2444-bb8b-4c52-960e-4c41445a98ca
# ╟─24ae7ecd-9423-4edf-bf88-6e71f0e27d82
# ╠═825f12d2-9153-4ee1-9d83-640f49d88d6d
# ╟─4da8eaa3-0c65-4351-9242-adfc95af7353
# ╟─4d2962a9-0816-4b25-ae7b-f3c87d375428
# ╠═e29ade22-1092-4a05-b078-d5d50509b875
# ╟─a30977b0-751f-437d-b185-55127263b6bc
# ╠═2e347214-cf7b-452f-a041-ad117d869a16
# ╟─f1abeadc-7d88-4cb3-8998-c4242460191e
# ╟─02deedfc-2306-470b-9a16-63b45a5ae638
# ╟─c08ae18e-7857-4dd0-b157-462ef9ab2c34
# ╠═a7d1c835-2494-45ed-a8b2-a2cc89fb8636
# ╠═c653686d-f8d8-48c0-87dd-0b3c8027ce6a
# ╟─3d61fd46-c01c-4c9a-ad5a-6182e8adef45
# ╟─593c3b9a-76be-4fe3-8f9d-baaf86035b8c
# ╠═4d172d04-2412-48cf-8136-ccce4fdb0c61
# ╟─4d673ff6-e368-4c26-88dd-bc105a96e7c6
# ╟─5de1389d-a54c-48f0-9c93-4cf46c4c5a4a
# ╟─840f2ac8-2282-4cc7-8422-f7e1c078c7e9
# ╠═6ff6db51-637d-49c6-815f-e179a9c4ffd5
# ╟─02f9cc22-91c5-4b01-90bc-3359008b6dc7
# ╟─7111bdc6-fab3-48be-89c1-3ce91de11c57
# ╟─2b5da421-a849-4d34-b7d8-1acade30ee21
# ╠═9d9ab479-b525-41ee-84ac-7fe5d88b6dfc
# ╟─58caf67b-b57d-47d2-b210-b86e662d117e
# ╠═f1cb6ed1-a8d8-439d-be7e-f3f62acc67d2
# ╟─ab07ed6e-e3da-469c-a4e9-dfd9524869ce
# ╠═947eaafe-4726-4c5a-92ec-27926dbf8e0a
# ╟─d6f6628a-95aa-4860-bc54-3c065ca2d056
# ╟─19a1c85d-25af-4aeb-ad7b-2d19396bde89
# ╟─9c27b79c-2c53-44f0-b5e1-5d62570c3ba4
# ╠═da103e2c-d418-4704-968a-39943de1391c
# ╟─5530ca56-7421-4521-abeb-566a8bdb9756
# ╠═6dfefd2d-7a10-4b81-b1af-56aff856573d
# ╟─c4698c03-47e3-4cb1-9817-a29618327303
# ╠═5146f962-549c-45c5-93e1-a51f5045724d
# ╟─ae2ce7ad-3670-4691-9f90-1ac77d60259f
# ╟─fcf19990-b55d-11eb-3a0a-8fbb3bb1b9bf
# ╠═633cb44f-5f95-446d-9db4-f47f1c66b5f1
# ╠═06d630ad-9c41-4f66-80ac-48ea66efd67d
# ╠═c35e6f98-820f-420f-ba4e-f35170c924ce
# ╟─2b8e9c9f-ef1c-47f3-83c9-d83c466e78cf
# ╟─9e41a351-cee3-4c3a-a31c-cf64d58092cb
