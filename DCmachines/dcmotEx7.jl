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

# ╔═╡ 67c602f2-e7be-42c4-b241-b60d7a3e01dd
begin
	#import Pkg
	#Pkg.activate(mktempdir())
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	# instalação de packages
	using PlutoUI # user-interface do Pluto.jl
	using Plots  # Julia package para gráficos 
	using Dierckx  # Julia package para interpolação/extrapolação de dados
end

# ╔═╡ afd4712c-9a79-4f4c-a2c2-3b74aded0bdc
md"""
# *Notebook*: dcmotEx7.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FDCmachines-GitHub-yellow.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/DCmachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 80864224-136b-40f8-8983-7a971e86c69d
md"""
# Motores de corrente contínua
"""

# ╔═╡ bf39a882-736e-46bd-8ad5-e68cd4203cea
md"""
## Exercício 7
"""

# ╔═╡ ed4846d5-70d2-4deb-9a4a-41cdc8c99bdd
md"""
**Considere um motor de corrente contínua, com a seguinte chapa de características:**
"""

# ╔═╡ 1301d1ad-89e8-4282-ab35-1a6b8214bea0
(Pᵤ, Uₙ, nₙ, ηₙ, Rᵢ, Rₛ, Ns, Rd, Nd)=(17e3, 250, 1200, 0.85, 0.6, 0.1, 12, 200, 3000)

# ╔═╡ 1a427cf6-b2d3-4d9b-9cb5-4682d5f49869
begin
	nmag=1200 # velocidade angular da característica magnética, rpm
	Iex=[0,0.0132,0.03,0.033,0.067,0.1,0.133,0.167,0.2,0.233,0.267,0.3,0.333,0.367,0.4,0.433,0.467,0.5,0.533,0.567,0.6,0.633,0.667,0.7,0.733,0.767,0.8,0.833,0.867,0.9,0.933,0.966,1,1.033,1.067,1.1,1.133,1.167,1.2,1.233,1.267,1.3,1.333,1.367,1.4,1.433,1.466,1.5]
	E₀=[5.40, 6.67,13.33,16,31.3,45.46,60.26,75.06,89.74,104.4,118.86,132.86,146.46,159.78,172.18,183.98,195.04,205.18,214.52,223.06,231.2,238,244.14,249.74,255.08,259.2,263.74,267.6,270.8,273.6,276.14,278,279.74,281.48,282.94,284.28,285.48,286.54,287.3,287.86,288.36,288.82,289.2,289.38,289.57,289.69,289.81,289.95]
	plot(Iex, E₀, title="E₀=f(Iₑₓ), n=1200rpm", xlabel = "Iₑₓ (A)", ylabel="E₀ (V)", ylims=(0,300), framestyle = :origin, minorticks=10, label=:none, linewidth=2)
end

# ╔═╡ 8bde3ad9-2d03-4557-ab50-a89ac8e834a3
md"""
!!! nota
No enunciado original não é considerada a existência de reacção magnética do induzido, $$ΔE=0$$V.  
No entanto, na versão *notebook* para que se possa verificar a influência de $$ΔE$$, nas características de funcionamento do motor DC para os diferentes tipos de excitação, uma curva de $$ΔE=f(I_i)$$ é também considerada como uma opção de análise."""

# ╔═╡ 61238dc4-3c9d-4b59-9486-501988806c27
"Com ΔE?", @bind z CheckBox()

# ╔═╡ c4d5e3f9-7808-48f6-8d33-05607d8e5a4e
begin
	Iᵢ=[0.0:15:120;]
	#Iᵢ=[0.0, 15, 30, 45, 60, 75, 90, 105, 120]
	ΔE=[0.0, 1.5, 4, 7.5, 12, 17, 23, 30.5, 40]*z
	plot(Iᵢ, ΔE, title="ΔE=f(Iᵢ)", xlabel = "Iᵢ (A)", ylabel="ΔE (V)", xlims=(0,120), ylims=(0,40), framestyle = :origin, minorticks=5, label=:none, linewidth=2)
end

# ╔═╡ f6fcec56-b080-4016-baf0-0ab728f255f3
md"""
**a) Com o motor em excitação derivação, determine o valor do reóstato de campo, nas
condições nominais $$(U_n, I_n, n_n)$$**;
"""

# ╔═╡ d9e431c5-be62-40c8-b5d6-59d5808e4436
md"""
Para se ter a informação completa das condições nominais, falta determinar o valor da corrente nominal, $$I_n$$.\
Da chapa de características do motor conhecem-se a potência útil (potência mecânica) e rendimento nominais, $$P_u$$ e $$\eta_n$$, respectivamente, o que permite obter a potência absorvida, $$P_{ab}=U_nI_n$$. Assim: 
"""

# ╔═╡ cde4847b-6c38-4bc6-a869-514774630c89
md"""
$$I_n=\frac{P_n}{\eta U_n}$$
"""

# ╔═╡ 1c70002d-e3fb-4d81-b0f9-ed00d69173ff
Iₙ=Pᵤ/(ηₙ*Uₙ);

# ╔═╡ 5b4c1912-126d-4fe8-87c5-f65b299f3642
md"""
Calculando obtém-se $$I_n=$$ $(Iₙ)A
"""

# ╔═╡ d8d6a6e9-df8d-47d2-832a-0d2126ce760e
md"""
A velocidade, $$n$$, é dependente do fluxo magnético, $$kϕ_0$$, que por sua vez depende da corrente de excitação, $$I_d$$ e da característica magnética da máquina.\
Assim, a imagem do fluxo magnético presente na máquina é dada pela a força contra-electromotriz de vazio do motor, $$E_0^{'}$$:
"""

# ╔═╡ 0ff562ff-7af2-4749-87f5-8766cb695893
md"""
$$E_0^{'}=E^{'}+ΔE$$
Sendo a  a força contra-electromotriz efectiva, $$E^{'}$$, dada por:\
"""

# ╔═╡ cf0f089a-1901-4ad1-8fe9-b9028679b109
md"""
$$E^{'}=U-R_iI_i$$
"""

# ╔═╡ de954f1d-a3ac-4830-acd0-85e64afdf0cd
# forma computacional de consultar a curva de ΔE(Ii), por interpolação dos dados através do Pkg Dierckx.jl
begin
	ΔE_int=Spline1D(Iᵢ,ΔE)  
	ΔEₙ=ΔE_int(Iₙ)
	ΔEₙ=round(ΔEₙ, digits=1)
end;

# ╔═╡ 68969be8-0bee-4cca-85de-7a8d2aa35ee2
md"""
O valor de $$ΔE$$ para $$I_n$$, consultando a sua curva de q.d.t é: $$ΔE=$$ $(ΔEₙ)V.  
"""


# ╔═╡ 8f5b0bd5-7a65-4ba3-bdd1-7cc3128fa8d8
E=Uₙ-Rᵢ*Iₙ;

# ╔═╡ 7d6a01a4-4876-42dc-ab66-f7f736d41a32
E₀ₙ=E+ΔEₙ;

# ╔═╡ 0a35c6dc-0967-4f8a-9fff-904f9062eeab
md"""
Calculando as f.c.e.m., obtêm-se $$E^{'}=$$ $(E)V e $$E_0^{'}=$$ $(E₀ₙ)V.
"""

# ╔═╡ 9d82a20f-3a14-4796-88e9-e27720632bbd
md"""

Note que tomou-se a corrente do rotor aproximadamente igual à corrente absorvida, $$I_i\simeq I_n$$, sendo no entanto, $$I_i=I_n+I_d$$. Contudo, não se está a desprezar a corrente $$I_d$$, mas sim a q.d.t. em $$R_i$$ devido a $$I_d$$. Ou seja, $$R_iI_d\lll R_iI$$ para efeito de cálculo de $$E_0^{'}$$ e uma vez que $$I_d$$ ainda não está calculada.
"""

# ╔═╡ 04b517f9-ed9f-4a5d-929b-82b10de843b9
md"""
A característica magnética foi obtida à mesma velocidade inscrita na chapa de características da máquina, $$n_n$$, por conseguinte, obtém-se dela directamente a corrente de campo, $$I_d$$.
"""

# ╔═╡ cfc7844e-3974-46ef-a53a-ee6a1a85d7f3
# forma computacional de consultar a característica magnética, por interpolação dos dados através do Pkg Dierckx.jl
begin
	Id_int=Spline1D(E₀,Iex)  
	Id=Id_int(E₀ₙ)
	Id=round(Id, digits=2)
end;

# ╔═╡ 71356175-ffe4-4c3a-a895-8a4be8713a44
md"""
Consultando a característica magnética a 1200rpm, verifica-se para $$E₀=$$ $(E₀ₙ)V $$\Rightarrow$$ $$I_d=$$ $(Id)A.
"""

# ╔═╡ d85a5505-1ab5-43d0-97ad-a0cb4a220c06
md"""
Assim, o reostato de campo para colocar o motor *shunt* nas condições nominais é dado por:
"""

# ╔═╡ 7c572ab7-2292-423c-b611-68573b289265
md"""
$$R_c=\frac{U_n}{I_d}-R_d$$
"""

# ╔═╡ 14ad0875-e27a-442e-81e9-29d1abaeac17
begin
	Rc=Uₙ/Id-Rd
	Rc=round(Rc, digits=1)
end;

# ╔═╡ 50022e39-c2f4-455f-8d26-7c9246190b11
md"""
Calculando, obtém-se $$R_c=$$ $(Rc)Ω
"""

# ╔═╡ 4bac08e5-7a7a-496f-8d67-aa2bc4b10236
md"""
> Poderá então observar as diferenças de cálculo relativas à presença de q.d.t. devido à reacção magnética do induzido, ou seja, uma máquina com pólos auxiliares (caso mais frequente), conduz a $$ΔE \neq 0$$V, variável em função da corrente do induzido. No caso de uma máquina com pólos auxiliares e enrolamentos de compensação, a reacção magnética do induzido estará compensada e assim tem-se:
"""

# ╔═╡ 5abe64cf-9291-48d6-bf60-7335551ee791
md"""
$$ΔE=0 \Rightarrow E_0^{'}=E^{'}$$
"""

# ╔═╡ ac32afe0-e30f-402e-995e-8b0cacf8af10


# ╔═╡ 4989ff81-ac16-446c-8d8a-e3cb9e5950b6
md"""
**b) Utilizando o reóstato de campo calculado na alínea anterior, determine as características de velocidade, binário e mecânica deste motor (excitação derivação);**
"""

# ╔═╡ 1d458a5a-545f-4ab6-900b-9d84ebbaf51d
md"""
> No motor de **excitação derivação**, as grandezas estão identificadas como: k$$ϕ$$₀₁, n₁, E₁, ω₁, Td₁
"""

# ╔═╡ d25759bf-6e81-439c-a2c9-c19704379437
begin
	kϕ₀₁=E₀ₙ/nmag
	kϕ₀₁=round(kϕ₀₁, digits=3)
end;

# ╔═╡ 4652d9e4-e2c6-47c4-93d1-1e360ffb7e57
md"""
Tomando o valor calculado de $$R_c=$$ $(Rc)Ω, resulta $$I_d=$$ $(Id)A, o que permite calcular o fluxo magnético da máquina em vazio, $$kϕ₀$$, que no motor de excitação derivação permanece constante.  
Assim, $$kϕ₀=$$ $(kϕ₀₁)V/rpm
"""

# ╔═╡ 4629c049-8882-4823-bdea-93e3d70cc901
md"""
A determinação da característica de velocidade $$n=f(I)$$ ou $$n=f(I_i)$$, uma vez que $$I_i\simeq I$$, consiste em sucessivamente realizar o cálculo da velocidade do motor para diferentes valores de corrente:  
"""

# ╔═╡ ea81ca51-dccc-4187-b788-7ed64716e698
md"""
$$n=\frac{U-R_iI_i+\Delta E}{k\phi_0}$$ com $$n$$ em rpm, $$\Delta E=f(I_i)$$ e $$k\phi_0=$$constante, em V/rpm.
"""

# ╔═╡ 6030b931-51a0-42fc-9b74-5635b590e6f5
# Característica de velocidade:
begin
	I=0:1:1.5*Iₙ
	Ii=I.-Id
	ΔEᵢ=ΔE_int(Ii)
	n₁=(Uₙ.-Rᵢ*Ii.+ΔEᵢ)/kϕ₀₁
end;

# ╔═╡ d47a90f0-f8bc-44d0-b71c-c0bc59d0d23c
md"""
Similarmente, a característica de binário, $$T=f(I)$$ ou $$T=f(I_i)$$, podendo $$T$$ ser o binário desenvolvido, $$T_d$$, ou o binário útil, $$T_u$$, atendendo que: $$T_d=T_u+T_p$$, consiste em sucessivamente realizar o cálculo do binário para diferentes valores de corrente:  
"""

# ╔═╡ 3c921729-6534-4eac-abb0-4eb362295b91
md"""
$$T_d=\frac{E^{'}}{ω}I_i\:\:\:;\:\:\:ω=\frac{2πn}{60}$$ com $$ω$$ em rad/s.
"""

# ╔═╡ 4da7f391-e3bf-4e12-aa6b-a7ef5e45d3b9
# Característica de binário:
begin
	E₁=Uₙ.-Rᵢ*Ii
	ω₁=2π.*n₁/60
	Td₁=(E₁./ω₁).*Ii
end;

# ╔═╡ df3609ef-80f2-464a-b522-f289ea9344b4


# ╔═╡ f499659c-b042-4002-bb27-980daf8502d4
md"""
**c) Idem, com excitação composta em longa derivação aditiva e subtrativa. Representar as características nos mesmos gráficos para comparação;**
"""

# ╔═╡ 72a079e6-0c41-4c50-9ee2-838d5cc60c85
md"""
No motor de excitação composta, o fluxo magnético depende da contribuição das forças magnetomotrizes de ambos os enrolamentos de excitação e da forma como estes estão ligados entre si (de forma aditiva ou subtractiva):
"""

# ╔═╡ 58e9df34-7471-4942-ac06-2505f52875f2
md"""
$$I_{ex}N_d=I_dN_d\pm I_sN_s$$
sendo $$I_s$$ a corrente que percorre o enrolamento de excitação série.
"""

# ╔═╡ f305c434-9d0c-497d-8335-bf25aa80e915
md"""
Assim, $$I_{ex}$$ é a corrente de campo que representa o fluxo total da máquina, sendo obtida por:
"""

# ╔═╡ 0ce81a6e-965c-4dc0-b9f3-f8c09143460e
md"""
$$I_{ex}=I_d \pm \frac{N_s}{N_d}I_s$$
"""

# ╔═╡ 1cd42258-7583-4288-9c6d-4d47facb69e1
md"""
Assim, a característica de velocidade para o motor de excitação composta em longa derivação é obtida por cálculo sucessivo da velocidade do motor para diferentes valores de corrente, através de:  
"""

# ╔═╡ facb1900-1093-46c7-97b2-187b67e21294
md"""
$$n=\frac{U-(R_i+R_s)I_i+\Delta E}{k\phi_t}$$ com $$k\phi_t=k(\phi_d \pm 	\phi_s)$$, em V/rpm obtido através da característica magnética da máquina.
"""

# ╔═╡ 6aae7842-4889-4be6-bd1d-eab44c610af8


# ╔═╡ 7ad852d3-e3b8-4799-8aae-a52c1ebe34ac
md"""
> No motor de **excitação composta aditiva**, as grandezas calculadas estão identificadas como: Iex₂, E₀₂, k$$ϕ$$₀₂, n₂, E₂, ω₂, Td₂
"""

# ╔═╡ b4e5cbd1-c1c1-47e1-a8aa-8fc2ef628e87
begin
	Iex₂=Id.+(Ns/Nd)*Ii
	E₀_int1=Spline1D(Iex, E₀)  # função de interpolação para a caract. magnética
	E₀₂=E₀_int1(Iex₂) # fem que contém os fluxos derivação + série
	kϕ₀₂=E₀₂/nmag
	n₂=(Uₙ.-(Rᵢ+Rₛ)*Ii.+ΔEᵢ)./kϕ₀₂
	E₂=Uₙ.-(Rᵢ+Rₛ)*Ii
	ω₂=2π.*n₂/60
	Td₂=(E₂./ω₂).*Ii
end;

# ╔═╡ 55397202-48ae-4a3d-a053-9f46e6638560


# ╔═╡ 1a154f27-cd9a-4de8-b850-599b5e810811
md"""
> No motor de **excitação composta subractiva**, as grandezas calculadas estão identificadas como: Iex₃, E₀₃, k$$ϕ$$₀\_₃, n₃, ω₃, Td₃
"""

# ╔═╡ 626c5cab-64e2-446c-9d38-f01dde099d3e
begin
	Iex₃=Id.-(Ns/Nd)*Ii
	E₀₃=E₀_int1(Iex₃) #fem que contém os fluxos derivação - série
	kϕ₀₃=E₀₃/nmag
	n₃=(Uₙ.-(Rᵢ+Rₛ)*Ii.+ΔEᵢ)./kϕ₀₃
	ω₃=2π.*n₃/60
	Td₃=(E₂./ω₃).*Ii
end;

# ╔═╡ 1c659ae6-1b29-43a5-92f7-30b1f24c3696


# ╔═╡ 426c40b4-5fa1-4d8a-b03c-11f3008484f6
md"""
**d) Determinar as curvas características com o circuito de derivação desligado (motor série). Representar as características nos mesmos gráficos para comparação;**
"""

# ╔═╡ 8dfd7146-2e55-4ea0-8cf2-3557d89e96e1
md"""
> No motor de **excitação série**, as grandezas calculadas estão identificadas como: Iex₄, E₀₄, k$$ϕ$$₀₄, n₄, ω₄, Td₄
"""

# ╔═╡ 4e4469c8-994d-42c6-b373-8f295768b8b0
begin
	Iex₄=(Ns/Nd)*Ii
	E₀₄=E₀_int1(Iex₄) #fem que contém apenas fluxo série
	kϕ₀₄=E₀₄/nmag
	n₄=(Uₙ.-(Rᵢ+Rₛ)*Ii.+ΔEᵢ)./kϕ₀₄
	ω₄=2π.*n₄/60
	Td₄=(E₂./ω₄).*Ii
end;

# ╔═╡ a45ad7c2-2f83-4e04-bdaf-8dcc30a150f5
# Características de velocidade, plots:
begin
	plot(I, n₁, linewidth=2, title="Características de velocidade", xlabel = "I (A)", ylabel="n (rpm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(I,n₂, linewidth=2, label="comp. aditivo")
	plot!(I,n₃, linewidth=2, label="comp. subtractivo", legend=:bottomleft)
	plot!(I,n₄, linewidth=2, label="série", xlims=(0,120), ylims=(0,3000))
end

# ╔═╡ 5b866db3-ddd6-4bfd-b027-761c07d6755c
# Características de binário, plots:
begin
	plot(I, Td₁, linewidth=2, title="Características de binário", xlabel = "I (A)", ylabel="Td (Nm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(I,Td₂, linewidth=2, label="comp. aditivo")
	plot!(I,Td₃, linewidth=2, label="comp. subtractivo", legend=:topleft)
	plot!(I,Td₄, linewidth=2, label="série", xlims=(0,120), ylims=(0,250))
end

# ╔═╡ 326135bd-24e3-492d-a7d5-1a14f065e80f
# Características mecânicas, plots:
begin
	plot(Td₁, n₁, linewidth=2, title="Características mecânicas", ylabel = "n (rpm)", xlabel="Td (Nm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(Td₂, n₂, linewidth=2, label="comp. aditivo")
	plot!(Td₃, n₃, linewidth=2, label="comp. subtractivo", legend=:topright)
	plot!(Td₄, n₄, linewidth=2, label="série", xlims=(0,250), ylims=(0,3000))
end

# ╔═╡ 66e32f84-8b2a-4a3d-81fe-16437ecc3c18


# ╔═╡ 60db00b7-c78b-4c26-9530-c62fcfd1bfd2
md"""
**e) Considere o motor com excitação separada, Uexc = 240V , com o reóstato de campo
calculado na alínea a). Explicite a variação da característica de velocidade nas situações:**
1. **aumento de tensão do induzido;**
2. **diminuição do reóstato de campo;**
3. **aumento da resistência adicional.**
"""

# ╔═╡ 4fdea2ae-3bf8-42cd-bf6f-411eaf8223c3
md"""
> No motor de **excitação separada**, as grandezas calculadas estão identificadas como: Ui, Iex5, E₀₅, k$$ϕ$$₀₅, ΔEᵢᵢ, n₅, ω₅, Td₅
"""

# ╔═╡ 36295cf6-19ba-4240-9806-745ec0bfdccd
begin
	H1=("Tensão do induzido, Ui", @bind Ui PlutoUI.Slider(150:1:350, default=250.0, show_value=true))
	H2=("Reostato de campo, Rc1", @bind Rc1 PlutoUI.Slider(0*Rc:0.01*Rc:2.5*Rc, default= Rc, show_value=true))
	H3=("Resistência adicional, Rad", @bind Rad PlutoUI.Slider(0:0.1:1.5, default=0.0, show_value=true))
	H1, H2, H3
end

# ╔═╡ e648310c-8172-4cf0-ab72-f40229ba2577
begin
	Uexc=240
	Iex₅=Uexc/(Rc1+Rd)
	E₀₅=E₀_int1(Iex₅) #fem para excitação separada
	kϕ₀₅=E₀₅/nmag
	ΔEᵢᵢ=ΔE_int(I)
	n₅=(Ui.-(Rᵢ+Rad)*I.+ΔEᵢᵢ)./kϕ₀₅
	E₅=Ui.-(Rᵢ+Rad)*I
	ω₅=2π.*n₅/60
	Td₅=(E₅./ω₅).*Ii
end;

# ╔═╡ 4919a95d-cd66-401c-af76-6155087462a3
# Característica de velocidade vs. variação de Ui, Rc1 ou Rad; plots:
begin
	plot(I, n₅, ylims=(0,3000),linewidth=2, framestyle = :origin, title="Variação da característica de velocidade", label=:none, xlabel = "I (A)", ylabel="n (rpm)", minorticks=5, xlims=(0,120))
end

# ╔═╡ 8ad59666-3801-44a3-b26a-197a8f60db02
md"""
!!! nota
**Apresenta-se uma alínea f) idêntica à alínea anterior, mas considerando a característica de binário:**  
"""

# ╔═╡ 49cc56bc-bd1e-4e07-9d9c-0ccfaa92e7b0
# Característica de binário vs. variação de Ui, Rc1 ou Rad; plots:
begin
	plot(I, Td₅, ylims=(0,250),linewidth=2, framestyle = :origin, title="Variação da característica de binário", label=:none, xlabel = "I (A)", ylabel="Td (Nm)", minorticks=5, xlims=(0,120))
end

# ╔═╡ 8ae839fd-5fe0-4698-9999-5db933837036
version=VERSION;

# ╔═╡ 438b1d30-97b4-11eb-016c-77c75cf07e05
md"""
ME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 11/Abr/2021
"""

# ╔═╡ Cell order:
# ╟─afd4712c-9a79-4f4c-a2c2-3b74aded0bdc
# ╟─80864224-136b-40f8-8983-7a971e86c69d
# ╟─bf39a882-736e-46bd-8ad5-e68cd4203cea
# ╟─ed4846d5-70d2-4deb-9a4a-41cdc8c99bdd
# ╠═1301d1ad-89e8-4282-ab35-1a6b8214bea0
# ╟─1a427cf6-b2d3-4d9b-9cb5-4682d5f49869
# ╟─8bde3ad9-2d03-4557-ab50-a89ac8e834a3
# ╟─61238dc4-3c9d-4b59-9486-501988806c27
# ╟─c4d5e3f9-7808-48f6-8d33-05607d8e5a4e
# ╟─f6fcec56-b080-4016-baf0-0ab728f255f3
# ╟─d9e431c5-be62-40c8-b5d6-59d5808e4436
# ╟─cde4847b-6c38-4bc6-a869-514774630c89
# ╟─5b4c1912-126d-4fe8-87c5-f65b299f3642
# ╠═1c70002d-e3fb-4d81-b0f9-ed00d69173ff
# ╟─d8d6a6e9-df8d-47d2-832a-0d2126ce760e
# ╟─0ff562ff-7af2-4749-87f5-8766cb695893
# ╟─cf0f089a-1901-4ad1-8fe9-b9028679b109
# ╟─68969be8-0bee-4cca-85de-7a8d2aa35ee2
# ╠═de954f1d-a3ac-4830-acd0-85e64afdf0cd
# ╟─0a35c6dc-0967-4f8a-9fff-904f9062eeab
# ╠═8f5b0bd5-7a65-4ba3-bdd1-7cc3128fa8d8
# ╠═7d6a01a4-4876-42dc-ab66-f7f736d41a32
# ╟─9d82a20f-3a14-4796-88e9-e27720632bbd
# ╟─04b517f9-ed9f-4a5d-929b-82b10de843b9
# ╟─71356175-ffe4-4c3a-a895-8a4be8713a44
# ╠═cfc7844e-3974-46ef-a53a-ee6a1a85d7f3
# ╟─d85a5505-1ab5-43d0-97ad-a0cb4a220c06
# ╟─7c572ab7-2292-423c-b611-68573b289265
# ╟─50022e39-c2f4-455f-8d26-7c9246190b11
# ╠═14ad0875-e27a-442e-81e9-29d1abaeac17
# ╟─4bac08e5-7a7a-496f-8d67-aa2bc4b10236
# ╟─5abe64cf-9291-48d6-bf60-7335551ee791
# ╟─ac32afe0-e30f-402e-995e-8b0cacf8af10
# ╟─4989ff81-ac16-446c-8d8a-e3cb9e5950b6
# ╟─1d458a5a-545f-4ab6-900b-9d84ebbaf51d
# ╟─4652d9e4-e2c6-47c4-93d1-1e360ffb7e57
# ╠═d25759bf-6e81-439c-a2c9-c19704379437
# ╟─4629c049-8882-4823-bdea-93e3d70cc901
# ╟─ea81ca51-dccc-4187-b788-7ed64716e698
# ╠═6030b931-51a0-42fc-9b74-5635b590e6f5
# ╟─d47a90f0-f8bc-44d0-b71c-c0bc59d0d23c
# ╟─3c921729-6534-4eac-abb0-4eb362295b91
# ╠═4da7f391-e3bf-4e12-aa6b-a7ef5e45d3b9
# ╟─a45ad7c2-2f83-4e04-bdaf-8dcc30a150f5
# ╟─5b866db3-ddd6-4bfd-b027-761c07d6755c
# ╟─326135bd-24e3-492d-a7d5-1a14f065e80f
# ╟─df3609ef-80f2-464a-b522-f289ea9344b4
# ╟─f499659c-b042-4002-bb27-980daf8502d4
# ╟─72a079e6-0c41-4c50-9ee2-838d5cc60c85
# ╟─58e9df34-7471-4942-ac06-2505f52875f2
# ╟─f305c434-9d0c-497d-8335-bf25aa80e915
# ╟─0ce81a6e-965c-4dc0-b9f3-f8c09143460e
# ╟─1cd42258-7583-4288-9c6d-4d47facb69e1
# ╟─facb1900-1093-46c7-97b2-187b67e21294
# ╟─6aae7842-4889-4be6-bd1d-eab44c610af8
# ╟─7ad852d3-e3b8-4799-8aae-a52c1ebe34ac
# ╠═b4e5cbd1-c1c1-47e1-a8aa-8fc2ef628e87
# ╟─55397202-48ae-4a3d-a053-9f46e6638560
# ╟─1a154f27-cd9a-4de8-b850-599b5e810811
# ╠═626c5cab-64e2-446c-9d38-f01dde099d3e
# ╟─1c659ae6-1b29-43a5-92f7-30b1f24c3696
# ╟─426c40b4-5fa1-4d8a-b03c-11f3008484f6
# ╟─8dfd7146-2e55-4ea0-8cf2-3557d89e96e1
# ╠═4e4469c8-994d-42c6-b373-8f295768b8b0
# ╟─66e32f84-8b2a-4a3d-81fe-16437ecc3c18
# ╟─60db00b7-c78b-4c26-9530-c62fcfd1bfd2
# ╟─4fdea2ae-3bf8-42cd-bf6f-411eaf8223c3
# ╠═e648310c-8172-4cf0-ab72-f40229ba2577
# ╟─36295cf6-19ba-4240-9806-745ec0bfdccd
# ╟─4919a95d-cd66-401c-af76-6155087462a3
# ╟─8ad59666-3801-44a3-b26a-197a8f60db02
# ╟─49cc56bc-bd1e-4e07-9d9c-0ccfaa92e7b0
# ╟─438b1d30-97b4-11eb-016c-77c75cf07e05
# ╟─67c602f2-e7be-42c4-b241-b60d7a3e01dd
# ╟─8ae839fd-5fe0-4698-9999-5db933837036
