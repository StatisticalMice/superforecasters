### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ bd3a666c-51c4-11eb-0ea5-3beaf9b624c2
begin
  import Pkg
  Pkg.add("CSV")
  Pkg.add("DataFrames")
  Pkg.add("PlutoUI")
  Pkg.add("StatsPlots")
  using PlutoUI, CSV, DataFrames, StatsPlots
  plotly()
end

# ╔═╡ 3a965f9c-510e-11eb-08dc-8d1cdc52e218
with_terminal() do
	Pkg.status()
end

# ╔═╡ 0cdb58ae-510f-11eb-12d4-5393fb3dec0c
df_raw = CSV.read("data2020_b.csv", DataFrame)[!,3:end];

# ╔═╡ 3493c430-51b9-11eb-2b59-6bd9bde30ed5


# ╔═╡ 9ebdd936-5187-11eb-2ed8-3fa4ec45d80c


# ╔═╡ c9f9c422-5185-11eb-3e8d-3f96592baac1
function split_column_name(s)
    rxa = r"^\d+\.\s*"
    n = match(rxa, s).match
    text = s[length(n)+1:end]
    n, text
end

# ╔═╡ ef460ef8-5186-11eb-360f-cfb255b92d0f
split_column_name("25. Ensimmainen laillisesti crispr-tekniikalla geenimuunneltu ihminen syntyy vuoden 2028 loppuun mennessa.")

# ╔═╡ 0bce4e76-5187-11eb-2fbd-a5a81560ac90
function clean_column_name(s)
    rxb = r"^\d+"
    "Q" * match(rxb, s).match
end

# ╔═╡ 93b434d4-5189-11eb-32be-e97d67e6f555
begin
	column_names = Dict{Symbol,String}()
	df = DataFrame()
	
	let cnames, nimi, tyyppi
		cnames = names(df_raw)
		nimi = popfirst!(cnames)
		tyyppi = popfirst!(cnames)
		column_names[:nimi] = nimi
		df[!, :nimi] = df_raw[!, nimi]
		column_names[:tyyppi] = tyyppi
		df[!, :tyyppi] = df_raw[!, tyyppi]
		for cn in cnames
			n,t = split_column_name(cn)
			n = Symbol(clean_column_name(n))
			df[!, n] = df_raw[!, cn]
			column_names[n] = t
		end
	end	
	select!(df, :nimi, :tyyppi, :Q1, :Q2, :Q3, :Q5, :)
end;

# ╔═╡ 93552228-5189-11eb-0a42-5776e305433f
column_names

# ╔═╡ 3006417c-5187-11eb-0d0c-1bcaaf659578
clean_column_name("27.  ")

# ╔═╡ 9c4bc926-518f-11eb-3bd9-312fdacf8168
Symbol(clean_column_name("27.  "))

# ╔═╡ 8a5eca56-5194-11eb-2e18-9d8b842aba0c
function string_with_na_to_float(s)
    s=="NA" && return missing
    parse(Float32, s)
end

# ╔═╡ 06e2bc36-5186-11eb-3a97-65b85b57388d
df2 = select(df, 
	1:6, 
	names(df, 7:32) .=> ByRow(string_with_na_to_float),
	renamecols=false)

# ╔═╡ 9312c0c2-5189-11eb-2b25-57488418a6a2
describe(df2, :first, :median, :mean, :eltype, :nmissing)

# ╔═╡ 35013218-51b9-11eb-275e-d5a3685e2ea0
begin
	@df df2 histogram(:Q1, ticks=:native)
	#yaxis!("count")
	xaxis!(column_names[:Q1])
end

# ╔═╡ 8e371412-5194-11eb-221f-152be903cc6e
string_with_na_to_float("20")

# ╔═╡ 8ded747e-5194-11eb-122d-a90e49de9b31
string_with_na_to_float("NA")

# ╔═╡ Cell order:
# ╠═bd3a666c-51c4-11eb-0ea5-3beaf9b624c2
# ╠═3a965f9c-510e-11eb-08dc-8d1cdc52e218
# ╠═0cdb58ae-510f-11eb-12d4-5393fb3dec0c
# ╠═93b434d4-5189-11eb-32be-e97d67e6f555
# ╠═93552228-5189-11eb-0a42-5776e305433f
# ╠═06e2bc36-5186-11eb-3a97-65b85b57388d
# ╠═9312c0c2-5189-11eb-2b25-57488418a6a2
# ╠═35013218-51b9-11eb-275e-d5a3685e2ea0
# ╠═3493c430-51b9-11eb-2b59-6bd9bde30ed5
# ╠═9ebdd936-5187-11eb-2ed8-3fa4ec45d80c
# ╠═c9f9c422-5185-11eb-3e8d-3f96592baac1
# ╠═ef460ef8-5186-11eb-360f-cfb255b92d0f
# ╠═0bce4e76-5187-11eb-2fbd-a5a81560ac90
# ╠═3006417c-5187-11eb-0d0c-1bcaaf659578
# ╠═9c4bc926-518f-11eb-3bd9-312fdacf8168
# ╠═8a5eca56-5194-11eb-2e18-9d8b842aba0c
# ╠═8e371412-5194-11eb-221f-152be903cc6e
# ╠═8ded747e-5194-11eb-122d-a90e49de9b31
