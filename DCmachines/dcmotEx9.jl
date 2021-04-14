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

# ╔═╡ fa4e46d8-b3b0-451c-9a25-a36dfc5b1dfe
begin
	#import Pkg
	#Pkg.activate(mktempdir())
	#using Pkg
	#Pkg.add(["PlutoUI", "Plots", "Dierckx"])	# instalação de packages
	using PlutoUI # user-interface do Pluto.jl
	using Plots  # Julia package para gráficos 
	using Dierckx  # Julia package para interpolação/extrapolação de dados
end

# ╔═╡ 4614a560-9b71-11eb-091e-4f3ed9bc35e3
md"""
# *Notebook*: dcmotEx9.jl [![forthebadge](https://forthebadge.com/images/badges/made-with-julia.svg)](https://julialang.org/)  
##### *Packages*: [`Dierckx`](https://github.com/kbarbary/Dierckx.jl), [`Plots`](http://docs.juliaplots.org/latest/), [`PlutoUI`](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/)  
##### Copiar o URL do *notebook* em: [![](https://img.shields.io/badge/ME2%2FDCmachines-GitHub-yellow.svg)](https://github.com/Ricardo-Luis/ME2/tree/main/DCmachines), para o abrir no seu Julia\Pluto ou através do servidor: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Ricardo-Luis/ioplutonotebooks/HEAD)
"""

# ╔═╡ 0adbd32d-c418-4272-a92c-976d6ae95de6


# ╔═╡ a54a544a-0942-449b-9951-718c8d8f387a
md"""
# Motores de corrente contínua
"""

# ╔═╡ 10181196-8cfe-45ac-a1bb-bd58a6ca9b33
md"""
## Exercício 9
"""

# ╔═╡ 8cf2189b-a1fb-454f-a5bb-8c2caa1b6532
(Pᵤₙ, Uₙ, nₙ, ηₙ, nₘₐₓ, nmag)=(12e3, 250, 1400, 80, 2400, 1500);

# ╔═╡ 7b358be8-59b1-4494-8c48-d842b10c5912
md"""
**Um motor série de $(Pᵤₙ/1000)kW, $(Uₙ)V, $(nₙ)rpm, $(ηₙ)% de rendimento, velocidade máxima
$(nₘₐₓ)rpm, tem a seguinte característica magnética obtida a $(nmag)rpm:**
"""

# ╔═╡ b099a590-b481-4748-bf4b-b6be08e958ea
begin
	Iₑₓ=[10, 20, 30, 40, 50, 60, 70, 80]
	E₀=[80.0, 140, 190, 225, 250, 270, 285, 295]
	Iₑₓ, E₀
end;

# ╔═╡ aa89c8da-459e-4c4f-852b-55373d9c8fa1
(Rᵢ, Rₛ)=(0.35, 0.1);

# ╔═╡ 415a598c-3eaa-4a9a-b2c8-43e6ef34d0a2
md"""
Sabendo que a resistência do induzido é $(Rᵢ)Ω, do indutor é $(Rₛ)Ω, calcular:
"""

# ╔═╡ bcf9e628-959c-4c4d-bb00-9e683413d3f9


# ╔═╡ 8e3c4cdd-a4ea-4ab6-82d2-2bb01f176680
md"""
**a) As perdas mecânicas e no ferro, $$p_{(mec+Fe)}$$, em carga;**
"""

# ╔═╡ 58ab2478-3e28-461a-97fb-5e50c1248931
md"""
As perdas mecânicas e magnéticas de uma máquina de corrente contínua,  $$p_{(mec+Fe)}$$, também designadas como perdas rotacionais, $$p_{rot}$$, têm um comportamento aproxiamadamente constante, considerando tensão de alimentação constante  e variações de velocidade não muito expressivas.\
Assim, genericamente, pode obter-se o resultado das perdas rotacionais a partir de ensaio em vazio do motor, ou usando os dados nominais da chapa de características.\

No caso concreto do motor série, o ensaio em vazio apenas seria possível operando a máquina como gerador série, pois como poderá constatar adiante neste exercício, o motor série não pode perder a carga mecânica aplicada ao veio de rotação.
"""

# ╔═╡ fa13e734-4453-4bfe-910c-71c4734bd07b
Iₙ=Pᵤₙ/(Uₙ*ηₙ/100)

# ╔═╡ 8ca57c4e-c674-4899-ae77-c03ceaa7c691
begin
	pᵣₒₜ=Pᵤₙ/(ηₙ/100)-Pᵤₙ-(Rᵢ+Rₛ)Iₙ^2
	pᵣₒₜ=round(pᵣₒₜ, digits=0)
end;

# ╔═╡ 9a478bbc-1984-436c-8558-53376fc48a04
md"""
Assim, as perdas rotacionais obtêm-se do balanço de potência do motor série em regime nominal:

$$p_{rot}=P_{ab}-P_{un}-p_J$$

ou seja, 

$$p_{rot}=\frac{P_{un}}{\eta}-P_{un}-(Rᵢ+Rₛ)Iₙ^2$$

onde,

$$I_n=\frac{P_{ab}}{U_n}$$   

Calculando, obtém-se: $$p_{rot}=$$ $(pᵣₒₜ)W
"""

# ╔═╡ 73c7adad-e494-4566-8ecb-51d657819f30


# ╔═╡ 656b989f-f988-4eb5-b464-e1326104a9d6
md"""
**b) O valor mínimo da corrente que o motor pode absorver;**
"""

# ╔═╡ d1664dac-d1c1-491a-b92e-f28470ac4f01
md"""
A velocidade é inversamente proporcional ao fluxo magnético, por conseguinte, se o fluxo reduzir acentuadamente conduz a velocidades de funcionamento perigosas, situação comummente designada por **embalamento do motor de corrente contínua**.

O motor série tem na sua chapa de características uma de duas indicações para prevenir o seu embalamento do motor:
- velocidade máxima
- corrente mínima

Assim, para pontos de funcionamento ($$I$$, $$n$$) da característica de velocidade relativos a binários de carga reduzidos, a curva de velocidade tende a tornar-se assimptótica e por conseguinte, o motor ter um funcionamento instável.
"""

# ╔═╡ e4b2a383-b37e-4b82-ad57-7ae8b743c340
md"""
A obtenção da característica de velocidade do motor série permite encontrar a corrente mínima, $$I_{min}$$, observando o ponto de funcionamento correspondente à velocidade máxima, $$n_{max}$$.
"""

# ╔═╡ 77c74f69-5033-4ba9-b0d8-8c17110f477d
md"""
Este exercício não traz informação sobre a q.d.t. devido à reacção magnética do induzido, com excepção em regime nominal (como se verá adiante), pelo que se considera nula para os diversos valores de corrente considerados na determinação da característica de velocidade: $$\Delta E=0$$V.

Assim, a característica de velocidade obedece a:

$$n=\frac{U-(R_i+R_s)I}{kϕ}$$ com $$n$$ em rpm, $$kϕ=f(I)$$, em V/rpm:
"""

# ╔═╡ c2d9b1c5-4330-426e-9b60-e0e37476121d
begin
	I=0:1:Iₙ*1.25
	# forma computacional de consultar a curva de E₀(Iₑₓ), por interpolação dos dados através do Pkg Dierckx.jl
	E_int=Spline1D(Iₑₓ,E₀, k=1, bc="extrapolate")  
	E₀ᵢ=E_int(I)
	kϕ=E₀ᵢ/nmag
end

# ╔═╡ 781ddebe-67b7-4a52-bb9d-154f40a1fd28
n=(Uₙ.-(Rᵢ+Rₛ)I)./kϕ

# ╔═╡ ee722749-602d-4f89-8dd9-fcb1d673f554
begin
	# forma computacional de consultar a curva de n(I), por interpolação dos dados através do Pkg Dierckx.jl
	n_int=Spline1D(-n,I)  
	Iₘᵢₙ=n_int(-nₘₐₓ)
	Iₘᵢₙ=round(Iₘᵢₙ, digits=1)
end;

# ╔═╡ d215327c-a380-471a-a761-faade0c2020d
md"""
Consultando a característica de velocidade obtida verifica-se para $$n_{max}=$$ $(nₘₐₓ)rpm uma corrente mínima: $$I_{min}=$$ $(Iₘᵢₙ)A
"""

# ╔═╡ 16259eea-b205-4887-a09c-decba225f381
begin
	plot(I, n, title="n=f(I)", xlabel = "I (A)", ylabel="n (rpm)", xlims=(0,Iₙ*1.25), ylims=(0,n[10]), framestyle = :origin, minorticks=5, label=:none, linewidth=2)
	plot!([nₘₐₓ], seriestype = :hline, label=:none, linewidth=1, linestyle=:dash, linecolor=:red)
	plot!([Iₘᵢₙ], seriestype = :vline, label="Iₘᵢₙ(nₘₐₓ)=$(Iₘᵢₙ)A", linewidth=1, linestyle=:dash, linecolor=:red)
end

# ╔═╡ 024d8f06-f459-4431-9d46-b0e1b904b19c


# ╔═╡ e348ff8f-16cd-40ca-8f15-057158b5dad2
md"""
**c) A queda de tensão devida à reação magnética do induzido a plena carga;**
"""

# ╔═╡ de95a620-19dc-4f7f-8cce-7cf5a4c47d14
md"""
Nas condições nominais, dado que se tem o conhecimento da velocidade pela leitura da chapa de caracteríticas do motor série, é possível aferir o valor da velocidade, conhecidas as q.d.t. da máquina devido aos enrolamentos indutor e induzido e valor das f.c.e.m. da máquina na situação nominal.
Assim, tém-se:
"""

# ╔═╡ c5408a8d-8ed4-43cd-b712-65806e55c0da
md"""
$$ΔE=E_{0}^{'}-E^{'}$$
$$E^{'}=U_n-(R_i+R_s)I_n$$
$$E_{0}^{'}=kϕ_0*n_n$$
$$kϕ_0=\frac{E_{0} (I_n)} {n_{mag}}$$
"""

# ╔═╡ 4f617818-ea32-4f00-a9dc-8f0e2c38525d
begin
	E₀ₙ=E_int(Iₙ)	# fem para Iₙ. Consultando a característica magnética
	kϕ₀=E₀ₙ/nmag   # kϕ₀ para Iₙ
	E₀ₗ=kϕ₀*nₙ     # fcem₀ para Iₙ
	E=Uₙ-(Rᵢ+Rₛ)Iₙ  # fcem efetiva para Iₙ
	ΔE=E₀ₗ-E
end;

# ╔═╡ 04c1c186-d018-4f27-9632-005e4dd4271e
md"""
Alternativamente, a conjugação das expressões anteriores conduz à expressão da velocidade que permite também o cálculo de $$ΔE$$:

$$n=\frac{U-R_iI_i+\Delta E}{k\phi_0}$$

Obtendo-se, $$ΔE=$$ $(ΔE)V
"""

# ╔═╡ 2f428692-91f9-4d6c-a860-07c36a43c939


# ╔═╡ 2eef0ec0-6878-479f-b27f-e00795704e61
md"""
**d) A potência do motor que corresponde ao rendimento máximo;**
"""

# ╔═╡ 3b1aeb22-712d-429e-a76d-f2d3692af16a
md"""
A situação de rendimento máximo corresponde corresponde à igualdade entre perdas variáveis, $$p_v$$, e perdas constantes, $$p_c$$, na máquina:

$$ηₘₐₓ\Rightarrow p_v=p_c$$

No caso presente, tém-se:

$$p_v=(R_i+R_s)I^2$$
$$p_c=p_{rot}$$

Por conseguinte, a condição de rendimento máximo verifica-se quando:

$$I=\sqrt{\frac{p_{rot}}{R_i+R_s}}$$
"""

# ╔═╡ 765bc8ab-0c8e-482a-b6fb-4020d7813b3c
begin
	Iᵣₘ=√(pᵣₒₜ/(Rᵢ+Rₛ))   # Iᵣₘ, corrente relativa ao rendimento máximo do motor
	Iᵣₘ=round(Iᵣₘ, digits=1)
end

# ╔═╡ ddcaf382-9f44-48e1-a44d-747910505e36
Pᵤ=Uₙ*Iᵣₘ-2pᵣₒₜ;

# ╔═╡ cbfdf1f5-dd00-4796-87ea-529be3934620
md"""
Tendo em conta o balanço de potências na situação de rendimento máximo, resulta a potência útil: $$P_u=$$ $(Pᵤ/1000)kW"""

# ╔═╡ 5931d230-68e9-4003-bf94-800fbda03e79


# ╔═╡ 21baaeb1-a64e-4931-abd8-2efb4ec6583d
md"""
**e) Explicite qualitativamente a influência do reóstato de campo sobre a característica de
velocidade do motor série.**
"""

# ╔═╡ 83e8d548-d212-49ec-89f4-d794c9d26c85
md"""
Numa máquina DC série o reostato de campo é colocado em paralelo com o enrolamento de excitação, criando um divisor de corrente que permite regular o fluxo magnético indutor. 

Assim, a corrente do enrolamento série, $$I_s$$, vem dado por:

$$I_s=\frac{R_{cs}}{R{cs}+R_s}I$$

Consultando a característica magnética da máquina série para $$I_s$$ obtém-se o valor do fluxo magnético, traduzido no valor de $$kϕ$$ em (V/rpm):

$$kϕ(I_s)=\frac{E_0(I_s)}{n_{mag}}$$
"""

# ╔═╡ fb887b2d-9639-499b-9f1a-9cb3a4afaf73
md"""
Assim, a expressão da velocidade do motor terá a sua q.d.t. modificada pelo paralelo das resistências relativas ao enrolamento de excitação série e ao reóstato de campo:

$$n=\frac{U-[R_i+(R_s // R_{cs})]I}{kϕ(I_s)}$$

"""

# ╔═╡ a9bab890-8171-41cc-ae1d-80fc64d7196a
begin
	H4=("Rcs", @bind Rcs PlutoUI.Slider(0.05:0.01:4, default=4, show_value=true)) 
	H4
end

# ╔═╡ 0d9375fb-4b18-4c41-8f51-3e2c85af382c
begin
	Iₛ=(Rcs).*I/(Rcs+Rₛ)
	E₀₁=E_int(Iₛ)
	kϕ₁=E₀₁/nmag
end;

# ╔═╡ 86f9c718-dd8d-46dd-930e-aff35147f214
begin
	R₁=(Rcs*Rₛ)/(Rcs+Rₛ)
	n₁=(Uₙ.-(Rᵢ+R₁)I)./kϕ₁
end;

# ╔═╡ adedad68-149d-45e7-8a89-4e9c93c7f08a
plot(I, n₁, title="n=f(I), efeito de Rcs", xlabel = "I (A)", ylabel="n (rpm)", xlims=(0,Iₙ*1.25), ylims=(0,n[10]), framestyle = :origin, minorticks=5, label=:none, linewidth=2)

# ╔═╡ 304dae29-66b9-4349-a3f3-7fb6f0901307
md"""
!!! nota
**Aproveitando esta alínea pode-se verificar o efeito do reostato de campo também na característica de binário do motor série:**  
"""

# ╔═╡ 577bfb9d-0c76-45cd-904c-f4a92f51cbec
md"""
Genericamente, a expressão do binário desenvolvido, $$T_d$$, é obtida por: 
$$T_d=kϕI$$  

No entanto, os valores de $$kϕ$$ têm estado a ser apresentados em V/rpm. Embora as "rotações por minuto" sejam uma unidade de uso generalizado, a velocidade angular é medida em rad/s no Sistema Internacional de Unidades. Assim, mantendo  $$kϕ$$ em V/rpm, a expressão do binário desenvolvido vem dada por:

$$T_d=kϕ\frac{60}{2π}I$$  
"""

# ╔═╡ d4f4837f-0d2f-4062-b943-74cfb2803bb7
Td=kϕ₁*(60/(2π)).*I;

# ╔═╡ 6de1a6c2-11c8-497d-9a28-5dd19d6255c0
plot(I, Td, title="Td=f(I), efeito de Rcs", xlabel = "I (A)", ylabel="Td (Nm)", xlims=(0,Iₙ*1.25), ylims=(0,150), framestyle = :origin, minorticks=5, label=:none, linewidth=2)

# ╔═╡ ca47feed-7bce-4804-bc88-cce163bbc9c2
md"""
> Procure analisar o efeito da variação do reóstato de campo no comportamento das características de velocidade e binário do motor série, justificando.
"""

# ╔═╡ 37fbe5df-7206-4282-a904-7b16123fd6b0


# ╔═╡ 4a91269d-e022-4039-9b1f-cc1a310160cb
version=VERSION;

# ╔═╡ 74f1620e-ad77-4a7a-88d1-0a789762853f
md"""
PME2\
*Notebook* realizado em linguagem de programação *Julia* versão: $(version)  \
**Ricardo Luís** (Professor Adjunto) \
ISEL, 14/Abr/2021
"""

# ╔═╡ Cell order:
# ╟─4614a560-9b71-11eb-091e-4f3ed9bc35e3
# ╟─0adbd32d-c418-4272-a92c-976d6ae95de6
# ╟─a54a544a-0942-449b-9951-718c8d8f387a
# ╟─10181196-8cfe-45ac-a1bb-bd58a6ca9b33
# ╟─7b358be8-59b1-4494-8c48-d842b10c5912
# ╠═8cf2189b-a1fb-454f-a5bb-8c2caa1b6532
# ╠═b099a590-b481-4748-bf4b-b6be08e958ea
# ╟─415a598c-3eaa-4a9a-b2c8-43e6ef34d0a2
# ╠═aa89c8da-459e-4c4f-852b-55373d9c8fa1
# ╟─bcf9e628-959c-4c4d-bb00-9e683413d3f9
# ╟─8e3c4cdd-a4ea-4ab6-82d2-2bb01f176680
# ╟─58ab2478-3e28-461a-97fb-5e50c1248931
# ╟─9a478bbc-1984-436c-8558-53376fc48a04
# ╠═fa13e734-4453-4bfe-910c-71c4734bd07b
# ╠═8ca57c4e-c674-4899-ae77-c03ceaa7c691
# ╟─73c7adad-e494-4566-8ecb-51d657819f30
# ╟─656b989f-f988-4eb5-b464-e1326104a9d6
# ╟─d1664dac-d1c1-491a-b92e-f28470ac4f01
# ╟─e4b2a383-b37e-4b82-ad57-7ae8b743c340
# ╟─77c74f69-5033-4ba9-b0d8-8c17110f477d
# ╠═c2d9b1c5-4330-426e-9b60-e0e37476121d
# ╠═781ddebe-67b7-4a52-bb9d-154f40a1fd28
# ╟─d215327c-a380-471a-a761-faade0c2020d
# ╠═ee722749-602d-4f89-8dd9-fcb1d673f554
# ╟─16259eea-b205-4887-a09c-decba225f381
# ╟─024d8f06-f459-4431-9d46-b0e1b904b19c
# ╟─e348ff8f-16cd-40ca-8f15-057158b5dad2
# ╟─de95a620-19dc-4f7f-8cce-7cf5a4c47d14
# ╟─c5408a8d-8ed4-43cd-b712-65806e55c0da
# ╠═4f617818-ea32-4f00-a9dc-8f0e2c38525d
# ╟─04c1c186-d018-4f27-9632-005e4dd4271e
# ╟─2f428692-91f9-4d6c-a860-07c36a43c939
# ╟─2eef0ec0-6878-479f-b27f-e00795704e61
# ╟─3b1aeb22-712d-429e-a76d-f2d3692af16a
# ╠═765bc8ab-0c8e-482a-b6fb-4020d7813b3c
# ╟─cbfdf1f5-dd00-4796-87ea-529be3934620
# ╠═ddcaf382-9f44-48e1-a44d-747910505e36
# ╟─5931d230-68e9-4003-bf94-800fbda03e79
# ╟─21baaeb1-a64e-4931-abd8-2efb4ec6583d
# ╟─83e8d548-d212-49ec-89f4-d794c9d26c85
# ╠═0d9375fb-4b18-4c41-8f51-3e2c85af382c
# ╟─fb887b2d-9639-499b-9f1a-9cb3a4afaf73
# ╠═86f9c718-dd8d-46dd-930e-aff35147f214
# ╟─adedad68-149d-45e7-8a89-4e9c93c7f08a
# ╟─a9bab890-8171-41cc-ae1d-80fc64d7196a
# ╟─304dae29-66b9-4349-a3f3-7fb6f0901307
# ╟─577bfb9d-0c76-45cd-904c-f4a92f51cbec
# ╠═d4f4837f-0d2f-4062-b943-74cfb2803bb7
# ╟─6de1a6c2-11c8-497d-9a28-5dd19d6255c0
# ╟─ca47feed-7bce-4804-bc88-cce163bbc9c2
# ╟─37fbe5df-7206-4282-a904-7b16123fd6b0
# ╟─74f1620e-ad77-4a7a-88d1-0a789762853f
# ╟─fa4e46d8-b3b0-451c-9a25-a36dfc5b1dfe
# ╟─4a91269d-e022-4039-9b1f-cc1a310160cb
