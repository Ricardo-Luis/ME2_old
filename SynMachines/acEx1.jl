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

# ╔═╡ 53f4e86b-9a60-485d-9434-8c6fa6600a77
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

# ╔═╡ 554603d2-6511-4fe7-b552-bf9a1edad578
md"""
# Máquina síncrona trifásica  
**(pólos lisos)**
## Alternador em regime isolado
"""

# ╔═╡ ca6ec89a-80ab-4a97-bca9-6ef831bbc408
html"<button onclick='present()'>present</button>"

# ╔═╡ 226a17af-d73c-4092-81b8-390133d37c9a
md"""
# Números complexos em computação científica *Julia* 
"""

# ╔═╡ fbd9ece4-3d5d-400d-9413-587cb875667f
md"""
## fasores (notação polar): $$∠$$
"""

# ╔═╡ 7befda37-a0a9-48ce-967b-411838b49801
md"""
Em programação *Julia* os números complexos são apresentados na forma rectangular, como por exemplo: $$2+3im$$, sendo $$im$$ a representação da unidade imaginária, ou seja, $$im=\sqrt{-1}$$.  

Em engenharia electrotécnica é comum a utilização de fasores, ou seja, os números complexos serem representados na forma polar, utilizando o símbolo "$$∠$$" para a designação do ângulo do vector, algo que não é nativo na linguagem *Julia*.

No entanto, em *Julia* é possível atribuir a símbolos, valores ou funções. Assim, ao símbolo "$$∠$$" atribuí-se a forma polar de um número complexo na forma $$(módulo)∠(argumento)$$ com o $$argumento$$ em graus, utilizando a seguinte instrução:
"""

# ╔═╡ 3454bb65-ff2b-43bb-a0cb-2ea2c0fdd9df
∠(x) = cis(deg2rad(x))

# ╔═╡ 24c35ac6-8f3e-4e1b-855a-7cf1eea302b1
md"""
Assim torna-se possível a representação de fasores.
Exemplos:
"""

# ╔═╡ 4a166b78-7afd-4d49-9a8f-80ae86da4f7a
begin
	I_=24∠(60)
	I_=round(I_, digits=1)
end

# ╔═╡ dae5f073-e65d-4abc-b7de-462aac711f04
begin
	I3_=10∠(-45);
	I3=abs(I3_)
	ϕ₃=angle(I3_)
	ϕ₃=rad2deg(ϕ₃)
	I3_,I3, ϕ₃
end

# ╔═╡ 52d68f4d-1d7c-43a9-b559-a395c949728c
md"""
## Plano de Argand
"""

# ╔═╡ 0f0399c2-a660-420f-905b-80e28aed3c68
md"""
O *package* [`Plots`](http://docs.juliaplots.org/latest/), que tem sido utilizado nos diversos *notebooks* já apresentados para realização de gráficos, reconhece nativamente números complexos, representando-os num plano de Argand, também conhecido como plano complexo.

Assim, a utilização do plano de Argand para representação gráfica de grandezas vectoriais é realizado indicando cada vector por um segmento de recta na forma $$[origem, destino]$$, em que a $$origem$$ e $$destino$$ são números complexos (em qualquer das suas formas: rectangular, polar ou exponencial). A instrução `arrow` permite colocar o afixo do número complexo do lado desejado:
"""

# ╔═╡ 14d993c8-b14d-4030-9649-b49841b112e0
begin
	K3=1 # factor de escala para a corrente
	plot([0, K3*I3_], arrow=:closed, label="I3_")
	plot!([0, 40∠(0)], arrow=:closed, label="U∠0°", legend=:bottomright,
		 #size=(500,500), ylims=(-40,10), xlims=(0,50) #
	)
end

# ╔═╡ 279e5442-43e2-4520-96fb-24c078456b10
md"""
## função trigonométrica "arco cosseno"
"""

# ╔═╡ 013213ea-19fe-486e-9277-c417932af77f
md"""
Apenas para chamar a atenção que as funções trigonométricas em *Julia* são executadas considerando os ângulos na unidade de radiano:
"""

# ╔═╡ 2df889f2-173d-48bb-af8b-19387593af81
cosϕ₁=0.8 

# ╔═╡ 6683875a-7ab6-438c-adf8-48b0447e07ea
ϕ₁=acos(cosϕ₁)*180/π

# ╔═╡ 6c415f63-b04d-4172-9868-5040331def7a
md"""
ou alternativamente utilizando a instrução: `rad2deg`:
"""

# ╔═╡ 69d764f9-d9e9-471a-aa64-ef39770f7bd1
begin
	cosϕ₂=0.8 
	ϕ₂=acos(cosϕ₂)
	ϕ₂=rad2deg(ϕ₂)
end

# ╔═╡ 8d5ddb92-cb96-4554-a94d-6246723b1cec
md"""
O mesmo raciocínio aplica-se a outras funções trigonométricas: `sin`, `asin`, `tan`, `atan`, ...
"""

# ╔═╡ c364f81c-0ce0-4a75-8243-f3f65a3e4c9b
md"""
# Exercício 1
"""

# ╔═╡ a09ffd6f-934b-468e-b4ea-a277c7e82b12
md"""
**Um alternador síncrono trifásico, 390kVA, 1250V, 50Hz, 750rpm, ligado em
triângulo, apresenta os seguintes resultados dos ensaios em vazio e curto-circuito:**
"""

# ╔═╡ 7bacedd0-4027-4ba0-9f8f-9af5e6f84f02
begin
	Iₑₓ=[11.5, 15.0, 20.0, 23.5, 29.0, 33.5]
	fem=[990, 1235, 1460, 1560, 1640, 1660]
	Icc=[139, 179, 242, 284, 347, 400]
	Iₑₓ,fem,Icc
end

# ╔═╡ 8236d85f-4d55-4260-9e88-68f986635d85
md"""
**A resistência medida aos bornes do enrolamento do induzido é 0,144Ω. Determine:**
"""

# ╔═╡ 96d71499-0ef6-432e-9821-505d11cd8b90
(Sₙ, Uₙ, f, n, RΩ)=(390e3, 1250, 50, 750, 0.144)

# ╔═╡ eb9315ba-4da1-4560-ab51-6b4b7e889792
md"""
## alínea a)
**a) A resistência por fase do enrolamento induzido do alternador síncrono, considerando um
coeficiente de correção do efeito pelicular da corrente de 1.2;**
"""

# ╔═╡ d5f1108a-5e78-4133-a7da-1263489074ef
md"""
A resistência medida aos bornes corresponde à resistência entre fases, por conseguinte, estando o estator em triângulo tém-se:
"""

# ╔═╡ 64a943f8-a056-484a-a107-34a9e6722bc7
R=3*RΩ/2

# ╔═╡ d1bf45b0-4b6d-44be-9ebb-09f02c897c69
md"""
O efeito pelicular da corrente, faz aumentar a resistência do condutor, pois em corrente alternada, esta tende a fluir na periferia dos condutores, quanto maior for a frequência angular elétrica. A resistência do estator, $$R_s$$ vem então dado por:
"""

# ╔═╡ dfdd0211-e6dd-4da0-bd15-f0976c4d8e04
begin
	Rₛ=R*1.2
	Rₛ=round(Rₛ, digits=3)
end

# ╔═╡ 967e5abb-a498-48a0-8860-3ec164e2a74f
md"""
## alínea b)
**b) A tensão de linha, para a corrente nominal e uma corrente de excitação de 33.5A,
considerando um factor de potência da carga de 0.9 indutivo;**
"""

# ╔═╡ 4509a023-f052-4a83-934a-20b388b11386
md"""
Cálculo da corrente nonimal:
"""

# ╔═╡ ef8fa7a2-8eab-45c9-a6d4-c4b079582090
begin
	Iₗ=Sₙ/(√3*Uₙ) # corrente de linha nominal
	Iₙ=Iₗ/(√3)	  # corrente por fase (ligação em triângulo)
	Iₙ=round(Iₙ, digits=1)
end

# ╔═╡ 16dbb5c0-44df-4251-9872-3a581c2358be
md"""
O ensaio de curto-circuito permite determinar a a impedância equivalente da máquina. Assim, para uma corrente de excitação de 33.5A têm-se uma corrente de curto-circuito de 400A e uma força electromotriz correspondente (fem) de 1660V.

"""

# ╔═╡ 6d827eb4-98b9-4b3f-9914-02acd370fe6b
md"""
Assim, partindo do esquema equivalente do alternador síncrono de polos lisos com estator em triângulo, a impedância síncrona, $$Z_s$$, vem dada por:
"""

# ╔═╡ 7fb4adbc-07ab-4dcc-9886-1f1a25555173
begin
	Icc₁=400
	E₀=1660
	Zₛ=E₀/(Icc₁/√3)
	Zₛ=round(Zₛ, digits=3)
end

# ╔═╡ 1868a559-6ed4-4033-b68f-640902a0a208
begin
	Xₛ=√(Zₛ^2-Rₛ^2)
	Xₛ=round(Xₛ, digits=3)
end;

# ╔═╡ 610f1cef-79d9-47b5-8eeb-eb257495e20d
md"""
Pelo triângulo de impedâncias obtém-se a reactância síncrona, $$X_s=$$ $Xₛ Ω:
"""

# ╔═╡ c0ca9f3d-9e34-4476-9736-e67925fcba7d
md"""
Cálculos auxiliares:
"""

# ╔═╡ 4c894109-b49f-49ad-b79b-e24db8d4a1d1
begin
	cosφ=0.9
	φ=-acos(cosφ)
	θ=atan(Xₛ/Rₛ)
end;

# ╔═╡ 757b0b5e-9cfc-496d-9ce7-11136147715f
md"""
O cálculo da tensão, $$U$$, corresponde à resolução da equação vectorial por fase:
"""

# ╔═╡ fbfa7d97-0687-474b-9064-f7e7647a158a
md"""
$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

em que: $$\quad R_s+jX_s=Z_s∠\theta\:$$, sendo: $$\quad Z_s=\sqrt{R_s^{2}+X_s^{2}}\quad$$ e $$\quad \theta=\arctan \frac{X_s}{R_s}$$
"""

# ╔═╡ 79eee656-55b1-4ceb-afc2-0915f3ff501f
begin
	sinδ=(Zₛ/E₀)*Iₙ*sin(θ+φ)
	δ=asin(sinδ)
	U=E₀*cos(δ)-Zₛ*Iₙ*cos(θ+φ)
	U=round(U, digits=1)
	δ=rad2deg(δ)	#δ: ângulo de carga, em graus
	δ=round(δ, digits=2)
	U, δ 
end

# ╔═╡ 1e0424b0-0383-43f6-9154-0adb2a00c477
md"""
Assim, a equação vectorial de $$\overline{E}_0$$ vem dada por:

$$E_0∠\delta=U∠0°+(Z_s∠\theta)(I∠\varphi)$$

Na equação vectorial acima desconhecem-se o ângulo de carga, $$\delta$$, e a tensão, $$U$$. Decompondo a equação vectorial nas suas coordenadas ortogonais (projecções dos vectores nos eixos real e imaginário), tém-se:

$$E_0\cos\delta=U+Z_sI\cos(\theta+\varphi)$$
$$E_0\sin\delta=Z_sI\sin(\theta+\varphi)$$

Resolvendo, obtêm-se $$\delta=$$ $δ ° e $$U=$$ $U V

"""

# ╔═╡ e3590f13-92aa-401e-a3ed-9faca407fd3e
md"""
### Diagrama vectorial de tensões
"""

# ╔═╡ 1fcedb30-d807-413d-8627-9f49cbab922e
md"""
Complementarmente, uma vez determinados os fasores da equação vectorial de $$\overline{E}_0$$ procede-se à representação do diagrama vectorial de tensões no plano complexo:
"""

# ╔═╡ cd964b74-f50b-4ed8-9b60-0f11ad8996ec
begin
	φ₁=rad2deg(φ)
	φ₁=round(φ₁, digits=2)
	K=8 # factor de escala da corrente
	Iₙ_=(K*Iₙ)∠(φ₁)
	U_=(U)∠(0)
	RₛIₙ_=(Rₛ*Iₙ)∠(φ₁)
	jXₛIₙ_=(Xₛ*Iₙ)∠(φ₁+90)
	E₀_=(E₀)∠(δ)
	plot([0, U_], arrow=:closed, legend=:topleft, label="U∠0°")
	plot!([0, Iₙ_], arrow=:closed, label="Iₙ∠φ")
	plot!([U_, U_+RₛIₙ_], arrow=:closed, label="RₛIₙ∠φ")
	plot!([U_+RₛIₙ_,U_+RₛIₙ_+jXₛIₙ_], arrow=:closed, label="XₛIₙ∠(φ+90°)")
	plot!([0,E₀_], arrow=:closed,
		  minorticks=5, label="E₀∠δ",
		  ylims=(-1000,1000), xlims=(0,2000), size=(600,600))
end

# ╔═╡ dcf29c05-ec5b-4c8b-8e14-d099ae5c3d81
md"""
### Efeito da corrente de carga e do factor de potência
"""

# ╔═╡ ae18108b-9957-48d5-871f-ba62a0af9dd1
begin
	H1=("I", @bind I₂ PlutoUI.Slider(0:1:1.4*Iₙ, default=Iₙ,show_value=true))
	H2=("φ -> cosφ", @bind phi₂ PlutoUI.Slider(-90:1:90, default=φ₁, show_value=true))
	H1, H2
end

# ╔═╡ d2ca3e67-ce90-4e8d-872f-937da6819787
begin
	φ₂=deg2rad(phi₂)
	sinδ₂=(Zₛ/E₀)*I₂*sin(θ+φ₂)
	δ₂=asin(sinδ₂)
	U₂=E₀*cos(δ₂)-Zₛ*I₂*cos(θ+φ₂)
	δ₂=rad2deg(δ₂)
	φ₂=rad2deg(φ₂)
	I₂_=(K*I₂)∠(φ₂)
	U₂_=(U₂)∠(0)
	RₛI₂_=(Rₛ*I₂)∠(φ₂)
	jXₛI₂_=(Xₛ*I₂)∠(φ₂+90)
	E₀₂_=(E₀)∠(δ₂)
	plot([0, U₂_], arrow=:closed, legend=:bottomright, label="U∠0°", linewidth=2)
	plot!([0, I₂_], arrow=:closed, label="I∠φ", linewidth=2)
	plot!([U₂_, U₂_+RₛI₂_], arrow=:closed, label="RₛI∠φ", linewidth=2)
	plot!([U₂_+RₛI₂_,U₂_+RₛI₂_+jXₛI₂_], arrow=:closed, label="XₛI∠(φ+90°)", linewidth=2)
	plot!([0,E₀₂_], arrow=:closed,minorticks=5, label="E₀∠δ", linewidth=2,
		  ylims=(-1500,1500), xlims=(0,3000), size=(600,600)
	)
	# lugar geométrico da fem
	δ_locus=-5:1:90
	E₀_locus_=(E₀)∠.(δ_locus)
	plot!(E₀_locus_, linestyle=:dash, label="locus de E₀∠δ")
	# lugar geométrico de I
	φ_locus=-90:1:90
	I₂_locus_=(K*I₂)∠.(φ_locus)
	plot!(I₂_locus_, linestyle=:dash, label="locus de I∠φ")
end

# ╔═╡ 60edec7f-e99a-4588-89dc-8af6dc5b98bf
md"""
!!! nota
O estudante deverá procurar perceber as implicações no valor da tensão de saída, $$U$$, de um alternador em regime isolado, quando o valor de corrente, $$I$$, é alterado e/ou o seu factor de potência, $$\cos \varphi$$.
"""

# ╔═╡ e9868a2e-cfcd-46fd-80fe-376e7f0feb3e


# ╔═╡ bae23d1e-0d15-427f-9685-fb7776f7b18f
md"""
### Determinação da reactância síncrona, $$X_s$$, para os diversos valores de corrente de campo, $$I_{exc}$$
"""

# ╔═╡ c93235c7-f6c6-4188-bc18-1eb2d0a52bfb
md"""
O mesmo exercício poderia ser repetido para diferentes valores da corrente de campo. Note-se que a impedância e por conseguinte, a reactância síncrona da máquina variam em função do estado de magnetização da máquina. Aqui mostra-se o exemplo de cáculo da reactância síncrona, $$X_s$$, para variações sucessivas de $$2$$A na corrente de campo:
"""

# ╔═╡ 7e8ead8b-98f2-438c-aa11-106b59d7bf12
md"""
## alínea c) Características externas
**c) A característica exterior do alternador síncrono trifásico, com uma corrente de excitação de 33.5A, para um factor de potência 0.9 indutivo, unitário e 0.9 capacitivo;**
"""

# ╔═╡ 4c68840e-c6b9-4236-a162-c2ab259a2a84
md"""
Para uma corrente de excitação de 33.5A, a fem apresenta o valor de 1660V, como verificado na alínea anterior. 
"""

# ╔═╡ 96b5a145-f706-4e17-b98c-bf4385918f5a
md"""
A determinação da característica externa deste alternador de polos lisos, $$U=f(I)$$ com corrente de campo e velocidade constantes,  corresponde à resolução da equação vectorial de $$\overline{E}_0$$ fazendo variar a corrente de carga, $$I$$, para um determinado factor de potência, $$\cos\varphi$$, imposto pela carga. 
"""

# ╔═╡ 822be933-51df-44a1-9b2b-dfadba2b4edd
md"""
É aqui que se tira verdadeiro partido de uma linguagem de computação científica na realização de cálculos sucessivos. Tal também é possível, recorrendo a folha de cálculo, como *MS Excel* ou *Google Sheets*, mas envolvendo algum trabalho suplementar devido à utilização de números complexos.
"""

# ╔═╡ 0f0c16d5-bbfd-4e20-9227-9d8a88708686
md"""
Determinação da característica externa para $$\cos\varphi=0,9(i)$$:
"""

# ╔═╡ f4f3d3b8-4d86-4cb6-a77b-439cec92c009
begin
	I₃=0:1:1.5*Iₙ
	cosφ₃=0.9
	φ₃=-acos(cosφ₃)
	δ₃=asin.((Zₛ/E₀).*I₃*sin(θ+φ₃))  # δ: ângulo de carga, radianos
	U₃=E₀*cos.(δ₃)-Zₛ.*I₃*cos(θ+φ₃)	 # cálculo da característica externa
end;

# ╔═╡ 8d53bf63-b32c-4080-8456-e0816e4a037c
md"""
Determinação da característica externa para $$\cos\varphi=1$$:
"""

# ╔═╡ eb3f4388-6159-4782-b61e-674c9bc610ff
begin
	δ₄=asin.((Zₛ/E₀).*I₃*sin(θ+0))  # δ: ângulo de carga, radianos
	U₄=E₀*cos.(δ₃)-Zₛ.*I₃*cos(θ+0)	 # cálculo da característica externa
end;

# ╔═╡ 3636d4b3-ec55-4b25-8273-a941e72c8097
md"""
Determinação da característica externa para $$\cos\varphi=0,9(c)$$:
"""

# ╔═╡ 3b4b963a-fc7e-4dce-a06a-7b387d47f3d2
begin
	cosφ₅=0.9
	φ₅=acos(cosφ₅)
	δ₅=asin.((Zₛ/E₀).*I₃*sin(θ+φ₅))  # δ: ângulo de carga, radianos
	U₅=E₀*cos.(δ₃)-Zₛ.*I₃*cos(θ+φ₅)	 # cálculo da característica externa
end;

# ╔═╡ 8f934d8b-11f6-4543-af19-c4dc4caa6761
begin
	plot(I₃, U₃, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,2000), 
		framestyle = :origin, minorticks=5, label="cosφ=0.9(i)",
		legend=:bottomleft)
	plot!(I₃, U₄, label="cosφ=1")
	plot!(I₃, U₅, label="cosφ=0.9(c)")
end

# ╔═╡ d7e179cf-3da7-4846-b354-fde9bc8cfe8b
md"""
#### Característica de regulação, $$I_{exc}=f(I)$$, para um dado $$\cos\varphi$$
"""

# ╔═╡ bfeb41b7-6abc-46bc-9e2e-fb7955453720
md"""
A análise dos efeitos da corrente de carga e do factor de potência, quer no diagrama vectorial de tensões do alternador síncrono de pólos lisos, quer nas características externas para diferentes $$\cos\varphi$$, permite antever a necessidade de se regular a corrente de campo, $$I_{exc}$$, regulando o fluxo magnético, e por conseguinte, a fem, $$E_0$$, de modo a manter a tensão de saída do alternador síncrono, $$U$$, constante para qualquer carga.
"""

# ╔═╡ f38674b4-0b81-48b0-803d-f0933a4717e5
md"""
Tome-se, por exemplo, a corrente de campo em vazio de $$20$$A:
"""

# ╔═╡ f686b38d-2e3c-48b2-bcd5-8d3aeaf3edab
md"""
A resolução da equação vectorial de $$\overline{E}_0$$, dada por:

$$\overline{E}_0=\overline{U}+(R_s+jX_s)\overline{I}$$

permite determinar o valor da fem, $$E_0$$, e por consulta da característica magnética, obter a corrente de campo necessária para manter a tensão, $$U$$, constante em função da carga, $$I$$, e do factor de potência, $$\cos\varphi$$. 

Note-se, que o cálculo exacto desta equação vectorial apenas é possível recorrendo a métodos de cálculo númerico iterativos (método de Euler, Runge–Kutta, entre outros), pois a reactância síncrona, $$X_s$$, depende da solução final (corrente de campo).

Por simplificação na análise, admite-se que os efeitos da variação, quer da corrente de carga, quer do factor de potência, são mais significativos que a dependência $$X_s=f(I_{exc})$$, permitindo assim um cálculo aproximado, apresentado no gráfico de característica de regulação:
"""

# ╔═╡ 889ef6e6-e42c-462c-877c-f4181c711941
	H5=("φ -> cosφ", @bind phi₇ PlutoUI.Slider(-90:1:90, default=60, show_value=true))

# ╔═╡ 1480d4ff-9146-4cfe-873d-593d9ddc3a6b
md"""
#### Efeitos de $$I_{exc}$$ e cosφ em $$U=f(I)$$
"""

# ╔═╡ d9224257-c6ff-4029-8602-0fe53da72525
md"""
A corrente de campo, $$I_{exc}$$, afecta a fem e também o valor da reactância síncrona, em especial se a máquina estiver a funcionar na zona de saturação da característica magnética:
"""

# ╔═╡ de90f721-0fe0-41e0-9137-f80b7183eaad
begin
	H3=("Iₑₓ", @bind Iexc PlutoUI.Slider(11.5:0.5:33.5, default=33.5,show_value=true))
	H4=("φ -> cosφ", @bind phi₆ PlutoUI.Slider(-90:1:90, default=φ₁, show_value=true))
	H3, H4
end

# ╔═╡ c1a0f54e-1222-48f1-8d51-8e245611d1fc
begin
	E₀_i=Spline1D(Iₑₓ,fem)	# interpolação da característica magnética para Iexc
	E₀_iₑₓ=E₀_i(Iexc)
	Icc_i=Spline1D(Iₑₓ,Icc) # interpolação da característica de c.c. para Iexc
	Icc_iₑₓ=Icc_i(Iexc)
	Zₛ_iₑₓ=E₀_iₑₓ/(Icc_iₑₓ/√3) # cálculo de Zₛ em função da corrente de campo
	Xₛ_iₑₓ=√(Zₛ_iₑₓ^2-Rₛ^2)	  # cálculo de Xₛ em função da corrente de campo
	Xₛ_iₑₓ=round(Xₛ_iₑₓ, digits=3)
	Iexc, E₀_iₑₓ, Icc_iₑₓ, Xₛ_iₑₓ
end

# ╔═╡ c42a0367-1b9b-40ed-ac74-cff6aca76f76
begin
	Iₑₓ₀=20
	U₀=E₀_i(Iₑₓ₀)		# interpolação da característica magnética
	Icc_iₑₓ₀=Icc_i(Iₑₓ₀) # interpolação da característica de curto-circuito
	Zₛ₀=U₀/(Icc_iₑₓ₀/√3) # cálculo de Zₛ em função da corrente de campo
	Xₛ₀=√(Zₛ₀^2-Rₛ^2)	  # cálculo de Xₛ em função da corrente de campo
	θ₀=atan(Xₛ₀/Rₛ)
	Iₑₓ₀, U₀, Icc_iₑₓ₀, Xₛ₀   
end

# ╔═╡ 2df531cf-db6b-47d0-a7fc-e62a7894c74f
begin
	iₑₓ=11.5:2:33.5
	E₀_iₑₓ₁=E₀_i(iₑₓ)		# interpolação da característica magnética
	Icc_iₑₓ₁=Icc_i(Iₑₓ₀)     # interpolação da característica de curto-circuito
	Zₛ_iₑₓ₁=E₀_iₑₓ₁./(Icc_iₑₓ₁/√3)
	Xₛ_iₑₓ₁=.√(Zₛ_iₑₓ₁.^2 .-Rₛ^2)
	Xₛ_iₑₓ₁=round.(Xₛ_iₑₓ₁, digits=3)
end

# ╔═╡ 417a5944-a2c3-49d5-b184-40d25750ce12
begin
	φ₇=deg2rad(phi₇)
	I₃_=(I₃)∠(φ₇)
	#E₀₇_=(U₀)∠(0).+(Rₛ+(Xₛ₀)im).*I₃_        # opção 1: algo não está correcto...
	#E₀₇_=(U₀)∠(0).+((Zₛ₀)∠(θ₀)).*I₃_        # opção 2: pior ainda...
	#E₀₇=abs.(E₀₇_)                          # faz parte das opções 1 e2
	
	# opção 3: passando o cálculo vectorial para escalar, determinando 1º (tan δ) para depois determinar E₀:
	tanδ₇=(Zₛ₀.*I₃*sin(θ₀+φ₇))./(U₀.+Zₛ₀.*I₃*cos(θ₀+φ₇))  
	δ₇=atan.(tanδ₇)
	if δ₇==0
		E₀₇=(U₀+Zₛ₀.*I₃*cos(θ₀+φ₇))
		else
		E₀₇=Zₛ₀.*I₃*sin(θ₀+φ₇)./sin.(δ₇)
		end
	
	# interpolação da característica magnética para E₀:
	i_E₀=Spline1D(fem, Iₑₓ, k=1, bc="extrapolate")	
	iₑₓ_E₀=i_E₀(E₀₇)
	
	# traçado da caracterítica de regulação:
	plot(I₃, iₑₓ_E₀, 
		title="Iₑₓ =f(I)",
		xlabel = "I(A)", ylabel="Iₑₓ(A)", 
		ylims=(0,40), xlims=(0,110), 
		framestyle=:origin, minorticks=5, legend=:none)
end

# ╔═╡ 9388218d-5cbd-49a6-b6b0-36975772bea1
begin
	φ₆=deg2rad(phi₆)
	θ₆=atan(Xₛ_iₑₓ/Rₛ)
	δ₆=asin.((Zₛ_iₑₓ/E₀_iₑₓ).*I₃*sin(θ₆+φ₆))
	U₆=E₀_iₑₓ*cos.(δ₆)-Zₛ_iₑₓ.*I₃*cos(θ₆+φ₆)
	plot(I₃, U₆, 
		title="U =f(I)",
		xlabel = "I(A)", ylabel="U(V)", 
		ylims=(0,3000), xlims=(0,160), 
		framestyle=:origin, minorticks=5, legend=:none)
end

# ╔═╡ 1bedaf5a-6f0b-43a1-a56a-38f275e7f6ad
md"""
!!! nota
O estudante deverá procurar perceber as implicações qualitativas das variações da corrente de campo, $$I_{exc}$$, e do factor de potência, $$\cos \varphi$$, na característica externa de um alternador síncrono.
"""

# ╔═╡ e2fa3c25-c819-42f8-8440-4d123cc6595e
md"""
## alínea d)
**d) A corrente de excitação para alimentar um motor assíncrono trifásico a uma tensão de 1kV, sabendo que o motor desenvolve uma potência de 150kW com um factor de
potência de 0.832 e um rendimento de 90%**

**Nota:** Admita que a impedância síncrona, $$Z_s$$, é igual à obtida da alínea anterior.
"""

# ╔═╡ 77ddb4d2-05a4-4238-83e0-e0d7f87cc90b


# ╔═╡ af9e3eb3-2827-42e4-bdea-75600588f6ed
md"""
Considerando desprezáveis as perdas rotacionais no motor assíncrono, $$p_{rot}=0 \Rightarrow P_u=P_d$$, por conseguinte, a corrente na linha vem:

$$I_L=\frac{P_u}{η\sqrt{3} U_c \cos\varphi}$$
os vectores da corrente e da tensão por fase do alternador (estator em triângulo) vêm dados por:
$$\overline{I}=\frac{I_L}{\sqrt{3}}∠φ \quad$$ e $$\quad \overline{U}=U_c∠0°$$
"""

# ╔═╡ 243b4055-6d12-4518-b83f-18f8515cfa05
begin
	(Pu, cosφₘ, η, Uₘ)=(150e3, 0.832, 0.9, 1e3)  #dados da alínea d)
	Iₗᵢₙₕₐ=Pu/(η*√3*Uₘ*cosφₘ)
	φₘ=-acos(cosφₘ)
	φₘ=rad2deg(φₘ)
	E₀ₘ_=(Uₘ)∠(0)+(Rₛ+Xₛ*im)*((Iₗᵢₙₕₐ/√3)∠(φₘ))
	E₀ₘ=abs(E₀ₘ_)								# módulo do vector da fem
	
	# interpolação da característica magnética para a fem calculada:
	iₑₓ_E₀ₘ=i_E₀(E₀ₘ)
	iₑₓ_E₀ₘ=round(iₑₓ_E₀ₘ, digits=1)
end;

# ╔═╡ 73892600-7855-4e7a-a139-fa2ae98f22b1
md"""
Calculando a fem por resolução da equação vectorial de $$\overline{E}_0$$, obtém-se a corrente de campo, $$I_{exc}$$, consultando a característica magnética do alternador, obtendo-se, $$I_{exc}=$$ $iₑₓ_E₀ₘ A
"""

# ╔═╡ d9926540-b22b-11eb-31d9-eb828e231498
md"""
# Setup
"""

# ╔═╡ 9459fc29-ae8e-4ede-8ce0-6078ddcd6d47
TableOfContents(title="Índice", depth=5)

# ╔═╡ 752ce1c8-b826-4a0d-8700-1bd21112a433
md"""
## *Notebook*: acEx1.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Dierckx`](https://github.com/kbarbary/Dierckx.jl), [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FSynMachines-GitHub-yellowgreen.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/SynMachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 8d43482b-d12a-4979-9d43-3c5d35b7d1ae
version=VERSION;

# ╔═╡ 88ee806f-dda3-4809-899d-4ccc4adf625c
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 13/Mai/2021
"""

# ╔═╡ Cell order:
# ╟─554603d2-6511-4fe7-b552-bf9a1edad578
# ╟─ca6ec89a-80ab-4a97-bca9-6ef831bbc408
# ╟─226a17af-d73c-4092-81b8-390133d37c9a
# ╟─fbd9ece4-3d5d-400d-9413-587cb875667f
# ╟─7befda37-a0a9-48ce-967b-411838b49801
# ╠═3454bb65-ff2b-43bb-a0cb-2ea2c0fdd9df
# ╟─24c35ac6-8f3e-4e1b-855a-7cf1eea302b1
# ╠═4a166b78-7afd-4d49-9a8f-80ae86da4f7a
# ╠═dae5f073-e65d-4abc-b7de-462aac711f04
# ╟─52d68f4d-1d7c-43a9-b559-a395c949728c
# ╟─0f0399c2-a660-420f-905b-80e28aed3c68
# ╠═14d993c8-b14d-4030-9649-b49841b112e0
# ╟─279e5442-43e2-4520-96fb-24c078456b10
# ╟─013213ea-19fe-486e-9277-c417932af77f
# ╠═2df889f2-173d-48bb-af8b-19387593af81
# ╠═6683875a-7ab6-438c-adf8-48b0447e07ea
# ╟─6c415f63-b04d-4172-9868-5040331def7a
# ╠═69d764f9-d9e9-471a-aa64-ef39770f7bd1
# ╟─8d5ddb92-cb96-4554-a94d-6246723b1cec
# ╟─c364f81c-0ce0-4a75-8243-f3f65a3e4c9b
# ╟─a09ffd6f-934b-468e-b4ea-a277c7e82b12
# ╠═7bacedd0-4027-4ba0-9f8f-9af5e6f84f02
# ╟─8236d85f-4d55-4260-9e88-68f986635d85
# ╠═96d71499-0ef6-432e-9821-505d11cd8b90
# ╟─eb9315ba-4da1-4560-ab51-6b4b7e889792
# ╟─d5f1108a-5e78-4133-a7da-1263489074ef
# ╠═64a943f8-a056-484a-a107-34a9e6722bc7
# ╟─d1bf45b0-4b6d-44be-9ebb-09f02c897c69
# ╠═dfdd0211-e6dd-4da0-bd15-f0976c4d8e04
# ╟─967e5abb-a498-48a0-8860-3ec164e2a74f
# ╟─4509a023-f052-4a83-934a-20b388b11386
# ╠═ef8fa7a2-8eab-45c9-a6d4-c4b079582090
# ╟─16dbb5c0-44df-4251-9872-3a581c2358be
# ╟─6d827eb4-98b9-4b3f-9914-02acd370fe6b
# ╠═7fb4adbc-07ab-4dcc-9886-1f1a25555173
# ╟─610f1cef-79d9-47b5-8eeb-eb257495e20d
# ╠═1868a559-6ed4-4033-b68f-640902a0a208
# ╟─c0ca9f3d-9e34-4476-9736-e67925fcba7d
# ╠═4c894109-b49f-49ad-b79b-e24db8d4a1d1
# ╟─757b0b5e-9cfc-496d-9ce7-11136147715f
# ╟─fbfa7d97-0687-474b-9064-f7e7647a158a
# ╟─1e0424b0-0383-43f6-9154-0adb2a00c477
# ╠═79eee656-55b1-4ceb-afc2-0915f3ff501f
# ╟─e3590f13-92aa-401e-a3ed-9faca407fd3e
# ╟─1fcedb30-d807-413d-8627-9f49cbab922e
# ╟─cd964b74-f50b-4ed8-9b60-0f11ad8996ec
# ╟─dcf29c05-ec5b-4c8b-8e14-d099ae5c3d81
# ╟─ae18108b-9957-48d5-871f-ba62a0af9dd1
# ╟─d2ca3e67-ce90-4e8d-872f-937da6819787
# ╟─60edec7f-e99a-4588-89dc-8af6dc5b98bf
# ╟─e9868a2e-cfcd-46fd-80fe-376e7f0feb3e
# ╟─bae23d1e-0d15-427f-9685-fb7776f7b18f
# ╟─c93235c7-f6c6-4188-bc18-1eb2d0a52bfb
# ╠═2df531cf-db6b-47d0-a7fc-e62a7894c74f
# ╟─7e8ead8b-98f2-438c-aa11-106b59d7bf12
# ╟─4c68840e-c6b9-4236-a162-c2ab259a2a84
# ╟─96b5a145-f706-4e17-b98c-bf4385918f5a
# ╟─822be933-51df-44a1-9b2b-dfadba2b4edd
# ╟─0f0c16d5-bbfd-4e20-9227-9d8a88708686
# ╠═f4f3d3b8-4d86-4cb6-a77b-439cec92c009
# ╟─8d53bf63-b32c-4080-8456-e0816e4a037c
# ╠═eb3f4388-6159-4782-b61e-674c9bc610ff
# ╟─3636d4b3-ec55-4b25-8273-a941e72c8097
# ╠═3b4b963a-fc7e-4dce-a06a-7b387d47f3d2
# ╟─8f934d8b-11f6-4543-af19-c4dc4caa6761
# ╟─d7e179cf-3da7-4846-b354-fde9bc8cfe8b
# ╟─bfeb41b7-6abc-46bc-9e2e-fb7955453720
# ╟─f38674b4-0b81-48b0-803d-f0933a4717e5
# ╠═c42a0367-1b9b-40ed-ac74-cff6aca76f76
# ╟─f686b38d-2e3c-48b2-bcd5-8d3aeaf3edab
# ╟─889ef6e6-e42c-462c-877c-f4181c711941
# ╟─417a5944-a2c3-49d5-b184-40d25750ce12
# ╟─1480d4ff-9146-4cfe-873d-593d9ddc3a6b
# ╟─d9224257-c6ff-4029-8602-0fe53da72525
# ╠═c1a0f54e-1222-48f1-8d51-8e245611d1fc
# ╟─de90f721-0fe0-41e0-9137-f80b7183eaad
# ╟─9388218d-5cbd-49a6-b6b0-36975772bea1
# ╟─1bedaf5a-6f0b-43a1-a56a-38f275e7f6ad
# ╟─e2fa3c25-c819-42f8-8440-4d123cc6595e
# ╟─77ddb4d2-05a4-4238-83e0-e0d7f87cc90b
# ╟─af9e3eb3-2827-42e4-bdea-75600588f6ed
# ╟─73892600-7855-4e7a-a139-fa2ae98f22b1
# ╠═243b4055-6d12-4518-b83f-18f8515cfa05
# ╟─d9926540-b22b-11eb-31d9-eb828e231498
# ╠═9459fc29-ae8e-4ede-8ce0-6078ddcd6d47
# ╟─752ce1c8-b826-4a0d-8700-1bd21112a433
# ╠═53f4e86b-9a60-485d-9434-8c6fa6600a77
# ╟─88ee806f-dda3-4809-899d-4ccc4adf625c
# ╟─8d43482b-d12a-4979-9d43-3c5d35b7d1ae
