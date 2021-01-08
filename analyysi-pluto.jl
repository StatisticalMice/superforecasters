### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ b8a0ad70-510e-11eb-11db-433a77f65b2f
using Pkg, PlutoUI, CSV, DataFrames, StatsPlots

# ╔═╡ 0cdb58ae-510f-11eb-12d4-5393fb3dec0c
df_raw = CSV.read("data2020.csv", DataFrame)[!,3:end];

# ╔═╡ e804f34e-5197-11eb-0646-b127893f0b17


# ╔═╡ e7d7697e-5197-11eb-22d8-33d90761fba1


# ╔═╡ 06e2bc36-5186-11eb-3a97-65b85b57388d


# ╔═╡ 79040c14-5110-11eb-3e9a-4bfb5ae917f2
ENV["COLUMNS"]=1000

# ╔═╡ 78dba6c0-5110-11eb-237f-4ba69887f14a
Pkg.add("StatsPlots")

# ╔═╡ 78b70752-5110-11eb-1c11-c7c8123c1839
using  
#plotly()

# ╔═╡ 9ebdd936-5187-11eb-2ed8-3fa4ec45d80c


# ╔═╡ 3a965f9c-510e-11eb-08dc-8d1cdc52e218
with_terminal() do
	Pkg.status()
end

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

# ╔═╡ 9312c0c2-5189-11eb-2b25-57488418a6a2
describe(df, :first, :eltype, :nmissing)

# ╔═╡ 0717884e-5186-11eb-1bbd-9b146a295fd1
df[!, 7:end]

# ╔═╡ 0d8cddd6-510f-11eb-149c-cbcd4a6a416d
begin
	@df df histogram(:row_id, ticks=:native)
	yaxis!("count")
	xaxis!("row_id")
end

# ╔═╡ 3006417c-5187-11eb-0d0c-1bcaaf659578
clean_column_name("27.  ")

# ╔═╡ 9c4bc926-518f-11eb-3bd9-312fdacf8168
Symbol(clean_column_name("27.  "))

# ╔═╡ 8a5eca56-5194-11eb-2e18-9d8b842aba0c
function string_with_na_to_float(s)
    s=="NA" && return missing
    parse(Int32, s)
end

# ╔═╡ 8e371412-5194-11eb-221f-152be903cc6e
string_with_na_to_float("20")

# ╔═╡ 8ded747e-5194-11eb-122d-a90e49de9b31
string_with_na_to_float("NA")

# ╔═╡ Cell order:
# ╠═0cdb58ae-510f-11eb-12d4-5393fb3dec0c
# ╠═93b434d4-5189-11eb-32be-e97d67e6f555
# ╠═93552228-5189-11eb-0a42-5776e305433f
# ╠═9312c0c2-5189-11eb-2b25-57488418a6a2
# ╠═0717884e-5186-11eb-1bbd-9b146a295fd1
# ╠═e804f34e-5197-11eb-0646-b127893f0b17
# ╠═e7d7697e-5197-11eb-22d8-33d90761fba1
# ╠═06e2bc36-5186-11eb-3a97-65b85b57388d
# ╠═0d8cddd6-510f-11eb-149c-cbcd4a6a416d
# ╠═79040c14-5110-11eb-3e9a-4bfb5ae917f2
# ╠═78dba6c0-5110-11eb-237f-4ba69887f14a
# ╠═78b70752-5110-11eb-1c11-c7c8123c1839
# ╠═9ebdd936-5187-11eb-2ed8-3fa4ec45d80c
# ╠═3a965f9c-510e-11eb-08dc-8d1cdc52e218
# ╠═b8a0ad70-510e-11eb-11db-433a77f65b2f
# ╠═c9f9c422-5185-11eb-3e8d-3f96592baac1
# ╠═ef460ef8-5186-11eb-360f-cfb255b92d0f
# ╠═0bce4e76-5187-11eb-2fbd-a5a81560ac90
# ╠═3006417c-5187-11eb-0d0c-1bcaaf659578
# ╠═9c4bc926-518f-11eb-3bd9-312fdacf8168
# ╠═8a5eca56-5194-11eb-2e18-9d8b842aba0c
# ╠═8e371412-5194-11eb-221f-152be903cc6e
# ╠═8ded747e-5194-11eb-122d-a90e49de9b31