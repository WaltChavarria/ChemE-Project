### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 915e211e-5853-11ec-1c6b-51ba02d42502
begin

	# load some external packages 
	using PlutoUI
	using DataFrames
	using BSON
	using GLPK
	using PrettyTables
	using Plots
	
	# setup my paths (where are my files?)
	_PATH_TO_ROOT = pwd() 
	_PATH_TO_SRC = joinpath(_PATH_TO_ROOT,"src")
	_PATH_TO_MODEL = joinpath(_PATH_TO_ROOT,"model")
	_PATH_TO_FIGS = joinpath(_PATH_TO_ROOT,"figs")
	
	# load the ENGRI 1120 project code library -
	include(joinpath(_PATH_TO_SRC,"Include.jl"))

	# load the model -
	MODEL = BSON.load(joinpath(_PATH_TO_MODEL,"model_v2.bson"), @__MODULE__)

	# show -
	nothing
end

# ╔═╡ 9b33620b-d922-4416-9880-50b5d7ad7753
md"""
## ENGRI 1120: Design and Analysis of a Sustainable Cell-Free Production Process for Industrially Important Small Molecules
"""

# ╔═╡ 50d38e3a-60e1-43f9-8bf6-0a9ea34bc5a4
html"""
<p style="font-size:20px;">Team name: The Best Team Plus Jess</br> Walt Chavarria, Ashley An, Jessica Kim</br>
Smith School of Chemical and Biomolecular Engineering, Cornell University, Ithaca NY 14850</p>
"""

# ╔═╡ 46c352c3-60f1-4718-8878-d0031d5bd0ca
md"""
### Introduction

For our team, the client has mandated that we utilize sucrose to produce isoprene at a 95% pure target molecule stream at a rate of 1.0 g/per hour. Sucrose is used and consumed in everyday life as it is commonly known as table sugar. It is a type of carbohydrate and is a disaccharide made of equal parts of two monosaccharides: glucose and fructose. Sucrose is produced naturally in various plants, such as vegetables, fruits, and nuts. It can also be extracted from sugarcane and sugar beets to be used as a sweetener in foods and beverages. Isoprene is a clear, colorless, volatile liquid used as a chemical raw material in a wide variety of industrial applications, such as the production of synthetic rubber used in tires. The hydrocarbon is obtained from processing petroleum or coal tar. It can be used either alone or in combination with other unsaturated compounds to make polymeric materials. For example, isoprene is also used with isobutene and aluminum chloride initiator to create butyl rubber, which is greatly impermeable to gases and therefore is widely utilized in inner tubes. Not only is isoprene crucial in the manufacture of butyl and synthetic rubber, plastics, and a variety of other chemicals, but it is also “the most important building block for lipids, steroids, terpenoids, and a wide variety of natural products, including latex, the raw material for natural rubber.” Isoprene rubber is a commonly used material in engineering applications due to its “outstanding mechanical properties and low cost” and is typically used in “anti-vibration mounts, drive couplings, tires, springs, bearings, and adhesives.” In order to successfully and efficiently produce our desired product, isoprene, we must obtain ATP and beta-d-fructose 1,6-bisphosphate, both of which will be discussed below, to be used as reactants with the sucrose. These reactants will be fed into the specially designed well-mixed reactors and specially fabricated universal separator units provided by Varnerlab to produce isoprene.

"""

# ╔═╡ 4bcb9ef8-ea0a-480f-82f0-d15f5a7a7e43
md"""
### Materials and Methods

To reach the maximum theoretical yield of isoprene from sucrose (2.466 mmol/hr), three different reactants were used. Those reactants were sucrose (the starting compound), ATP, and beta-d-fructose 1,6-bisphosphate. By consulting the list of reactions involved in the glycolysis of sucrose, it was apparent that ATP (adenosine triphosphate) played a crucial role, and was one of the limiting factors of the yield of isoprene. ATP is a reactant in the second reaction that sucrose goes through and is not created in the first reaction, therefore it was logical to add it in order to let this beginning reaction fully proceed. In order to avoid confusion between a lack of a third reactant and a lack of the amount of sucrose/ATP, ample amounts of sucrose and ATP, i.e. 10 mmol/hr, were added to the feed, which then allowed the limiting reaction to be identified. The extent of the reaction was the maximum theoretical extent up until the 12th reaction (R01058) where the extent decreased from 2.466 mmol/hr to 1.8495 mmol/hr. The main reactant in this reaction was D-Glyceraldehyde 3-phosphate. By adding an ample amount of D-Glyceraldehyde 3-phosphate as a third reactant in the feed, the process was able to reach maximum theoretical yield. This compound was then traced back up through the reaction list to see what compounds produced it. Two other compounds were found to come before D-Glyceraldehyde 3-phosphate that also allowed for maximum theoretical yield of isoprene. Those compounds were beta-D-Fructose 1,6-bisphosphate and beta-D-Fructose 6-phosphate. Although there were other compounds that these were derived from, they did not achieve the maximum yield. This is most likely because those compounds were used up by other reactions when added into the feed. We then compared the prices of these three compounds to determine the cheapest method to produce the maximum yield of isoprene. The cheapest compound among those three was beta-D-Fructose 1,6-bisphosphate, and therefore that was our third reactant.

The next aspect that we looked at was the amount of reactant that we needed to put in the feed. By adding 10.0 mmol/hr of each reactant, it was found that 2.466 mmol/hr of sucrose and beta-d-fructose 1,6-bisphosphate were used, therefore leaving 7.534 mmol of unused reactant per hour. Both of these reactants were decreased to 2.466 mmol/hr. We then manually reduced the amount of ATP and checked the extent of isoprene to ensure that we were maintaining maximum theoretical yield. The lowest amount of ATP that could be added to the feed and still maintain an output of 2.466 mmol/hr of isoprene was 4.932 mmol/hr. Take note that 4.932 is exactly double 2.466. We attributed this to a 2:1:1 stoichiometric relationship between ATP, sucrose, and beta-d-fructose 1,6-bisphosphate throughout the long series of reactions. Using these values, there was no unused reactant exiting the reactor.

Now that the reactants and their respective amounts had been identified to maximize the amount of isoprene created for a single chip, we had to figure out how to produce the required 1 gram/hr of isoprene. It was found that the mass of isoprene produced by one single chip using these quantities was 0.167977 g/hr. Unfortunately, that does not mean that we can stack six of these reactors to produce 1 g/hr. This mass of isoprene is mixed with all of the other compounds that exited the reactor, and therefore as we separate them using the MSU’s (Magical Separator Units), the mass produced is decreased heavily. The two approaches to increase the mass of isoprene created are to create a series of reactors, or to stack reactors in parallel. Through analysis using the compounds and quantities described above, it was found that 33 chips, 7 separators, and a mixer would need to be used to achieve a 95% purity and a yield of 1 g/hr of isoprene using the parallel method. Every chip takes the same amount of the three reactants, therefore, the whole system would use 81.378 mmol/hr of sucrose and beta-d-fructose 1,6-bisphosphate and 162.756 mmol/hr of ATP. We also tried the series method in order to see which one was cheaper and more efficient. In a series, one feed goes into chip 1, and the feed coming out of chip 1 then goes into chip 2. In addition, a secondary feed goes into each individual chip. In the series, sucrose and ATP were in feed one, and beta-d-fructose 1,6-bisphosphate was in feed 2. Using this approach, 37 chips and 6 separators would need to be used to achieve a 95% purity and a yield of 1 g/hr of isoprene. In feed one, it was found that 67 mmol/hr of sucrose and 4.932 mmol/hr of ATP were needed to fulfill the requirements. Given that this feed goes through every chip and therefore we don’t need to multiply it by 37, this method is much cheaper and more efficient than the parallel method described above. Feed 2 is fed individually to every chip so the total amount of beta-d-fructose 1,6-bisphosphate required is equal to 2.466*37 = 91.242 mmol/hr. This approach is much cheaper than the parallel method given that not nearly as much ATP is required. ATP and beta-d-fructose 1,6-bisphosphate are much more expensive than sucrose, therefore the substantial minimization of the amount of ATP required lowers the hourly price of reactants heavily. The price reduction in both sucrose and ATP offsets the price increase from the higher number of chips and the slight increase in total beta-d-fructose 1,6-bisphosphate required per hour. Further financial evaluation will be presented later.


"""

# ╔═╡ 47bddebd-389d-41d9-ba71-2489040c1925
md"""
##### Configure the Flux Balance Analysis (FBA) calculation for a _single_ chip
"""

# ╔═╡ 7b34264c-2a59-43fb-a079-a1c7ef367b8f
begin

	# setup the FBA calculation for the project -

	# === SELECT YOUR PRODUCT HERE ==================================================== #
	# What rate are trying to maximize? (select your product)
	# rn:R08199 = isoprene
	# rn:28235c0c-ec00-4a11-8acb-510b0f2e2687 = PGDN
	# rn:rn:R09799 = Hydrazine
	# rn:R03119 = 3G
	idx_target_rate = find_reaction_index(MODEL,:reaction_number=>"rn:R08199")
	# ================================================================================= #

	# First, let's build the stoichiometric matrix from the model object -
	(cia,ria,S) = build_stoichiometric_matrix(MODEL);

	# Next, what is the size of the system? (ℳ = number of metabolites, ℛ = number of reactions)
	(ℳ,ℛ) = size(S)

	# Next, setup a default bounds array => update specific elements
	# We'll correct the directionality below -
	Vₘ = (13.7)*(3600)*(50e-9)*(1000) # units: mmol/hr
	flux_bounds = [-Vₘ*ones(ℛ,1) Vₘ*ones(ℛ,1)]

	# update the flux bounds -> which fluxes can can backwards? 
	# do determine this: sgn(v) = -1*sgn(ΔG)
	updated_flux_bounds = update_flux_bounds_directionality(MODEL,flux_bounds)

	# hard code some bounds that we know -
	updated_flux_bounds[44,1] = 0.0  # ATP synthesis can't run backwards 

	# What is the default mol flow input array => update specific elements
	# strategy: start with nothing in both streams, add material(s) back
	n_dot_input_stream_1 = zeros(ℳ,1)	# stream 1
	n_dot_input_stream_2 = zeros(ℳ,1)	# stream 2

	# === YOU NEED TO CHANGE BELOW HERE ====================================================== #
	# Let's lookup stuff that we want/need to supply to the chip to get the reactiont to go -
	# what you feed *depends upon your product*
	compounds_that_we_need_to_supply_feed_1 = [
		"sucrose", "atp"
	]

	# what are the amounts that we need to supply to chip in feed stream 1 (units: mmol/hr)?
	mol_flow_values_feed_1 = [
		67 		; # sucrose mmol/hr
		4.932	; # atp mmol/hr (or maybe 6.1?)
	]

	# what is coming into feed stream 2?
	compounds_that_we_need_to_supply_feed_2 = [
		"beta-d-fructose 1,6-bisphosphate"
	]

	# let's always add Vₘ into feed stream 2
	mol_flow_values_feed_2 = [
		2.466 		; # glycerol mmol/hr
	]
	
	
	# === YOU NEED TO CHANGE ABOVE HERE ====================================================== #

	# stream 1:
	idx_supply_stream_1 = Array{Int64,1}()
	for compound in compounds_that_we_need_to_supply_feed_1
		idx = find_compound_index(MODEL,:compound_name=>compound)
		push!(idx_supply_stream_1,idx)
	end

	# stream 2:
	idx_supply_stream_2 = Array{Int64,1}()
	for compound in compounds_that_we_need_to_supply_feed_2
		idx = find_compound_index(MODEL,:compound_name=>compound)
		push!(idx_supply_stream_2,idx)
	end
	
	# supply for stream 1 and stream 2
	n_dot_input_stream_1[idx_supply_stream_1] .= mol_flow_values_feed_1
	n_dot_input_stream_2[idx_supply_stream_2] .= mol_flow_values_feed_2
	
	# setup the species bounds array -
	species_bounds = [-1.0*(n_dot_input_stream_1.+n_dot_input_stream_2) 1000.0*ones(ℳ,1)]

	# Lastly, let's setup the objective function -
	c = zeros(ℛ)
	c[idx_target_rate] = -1.0

	# show -
	nothing
end

# ╔═╡ 5bf9e5fb-c9fc-4962-a453-9948e5c6d79c
md"""
##### Theory of downstream separation using Magical Separation Units (MSUs)

To separate the desired product from the unreacted starting materials and by-products, let's suppose the teaching team invented a magical separation unit or MSU. MSUs have one stream in, and two streams out (called the top, and bottom, respectively) and a fixed separation ratio for all products (that's what makes them magical), where the desired product is _always_ in the top stream at some ratio $\theta$. In particular, if we denote $i=\star$ as the index for the desired product (in this case 1,3 propanediol), then after one pass (stream 1 is the input, stream 2 is the top, and stream 3 is the bottom) we have:

$$\begin{eqnarray}
\dot{m}_{\star,2} &=& \theta_{\star}\dot{m}_{\star,1}\\
\dot{m}_{\star,3} &=& (1-\theta_{\star})\dot{m}_{\star,1}\\
\end{eqnarray}$$

for the product. In this case, we set $\theta_{\star}$ = 0.75. On the other hand, for _all_ other materials in the input, we have $\left(1-\theta_{\star}\right)$ in the top, and $\theta_{\star}$ in the bottom, i.e.,

$$\begin{eqnarray}
\dot{m}_{i,2} &=& (1-\theta_{\star})\dot{m}_{i,1}\qquad{\forall{i}\neq\star}\\
\dot{m}_{i,3} &=& \theta_{\star}\dot{m}_{i,1}\\
\end{eqnarray}$$

If we chain these units together we can achieve a desired degree of separation.
"""

# ╔═╡ 928ef8ae-264a-4448-ac08-3970a8d8d1db
md"""
### Results and Discussion

To illustrate how much cheaper it is to run the series version of this process, here are the setup costs and hourly costs for both the parallel and series version. First, for the parallel version, it requires 1 syringe pump, 1 splitter, 33 reactor chips, 1 mixer, and 7 separators. One syringe pump costs $1000, the splitter and mixer are free, each reactor costs $100, and each separator costs $20. Therefore, the total cost of setup for the parallel process is $4440. To calculate the hourly price of the process, we must first convert mmol/hr rates to g/hr, given that all prices of compounds are in terms of mass. The molar mass of sucrose is 342.20 g/mol, therefore 81.378 mmol/hr equals 27.848 g/hr. Ten kilograms of sucrose can currently be purchased for $190, therefore 27.848 g/hr equals $0.53 per hour. The molar mass of the ATP salt hydrate that can be purchased is 551.14 g/mol. For every one mole of the compound there is one mole of ATP, therefore this molar mass can be used to calculate the mass flow rate of ATP. The 162.756 mmol/hr of ATP required equates to 89.707 g/hr of the compound available for purchase. Fifty grams of ATP can currently be purchased for $696, therefore it would cost $1248.72 per hour to reach the required amount of ATP. The molar mass of the beta-d-fructose 1,6-bisphosphate salt hydrate that can be purchased is 406.06 g/mol. For every one mole of the compound, there is one mole of beta-d-fructose 1,6-bisphosphate, therefore this molar mass can be used to calculate the mass flow rate of beta-d-fructose 1,6-bisphosphate. The 81.378 mmol/hr of beta-d-fructose 1,6-bisphosphate required equates to 33.044 g/hr of the compound available for purchase. Five grams of beta-d-fructose 1,6-bisphosphate can currently be purchased for $275, therefore it would cost $1817.42 per hour. The current setup cost of the parallel process is $4440, and the current hourly cost is $3066.67. To see the price as the number of hours of production varies (not accounting for inflation or price changes), the linear equation P(x) = 3066.67x + 4440 can be used, where “x” is the number of hours of operation, and “P(x)” is the total cost of production.

The series process requires 1 syringe pump, 37 reactor chips, and 6 separators. Using the prices shown above, the total setup cost is $4820. Using the conversions shown above, the required flow rate of sucrose, 67 mmol/hr, equates to 22.927 g/hr. Using the same prices shown above, this equates to a current price of $0.44 per hour. The required flow rate of ATP in this process is 4.932 mmol/hr which equates to 2.718 g/hr. The current cost of this mass flow rate is $37.83 per hour. This price is calculated using a bulk option of ATP available on Sigma-aldrich which has a lower price per gram. We will assume that the process will be run enough to make full use of this bulk purchase. Notice the difference in the price of ATP between the parallel and series processes; this is the main reason why we chose the series process. The cost of beta-d-fructose 1,6-bisphosphate is the same for both parallel and series, $1817.42 per hour. The total cost of setup for the series process is currently $4820 and the hourly cost is currently $1855.69. Although the setup cost of series is slightly higher than the setup cost of parallel, the overall price of production is much lower seeing as how the hourly cost is much lower; in fact, for just one hour of production, series is already $830.98 cheaper. To see the price as the number of hours of production varies (not accounting for inflation or price changes), the linear equation P(x) = 1855.69x + 4820 can be used.

To calculate the profit we make from selling off the isoprene that we create, the mass flow rate can be converted to a volumetric flow rate using the density of isoprene (0.681 g/mL). Therefore, the mass flow rate after separation, 1.032 g/hr, is equal to 1.515 mL/hr. On Sigma-Aldrich 100 mL of isoprene is currently sold for $30.20, therefore we are making $0.46 per hour. As you can see, the production of isoprene using this method is extremely economically unfavorable.


The financial performance of the process was then analyzed in order to determine the economic feasibility of it in comparison to an alternative investment with a yield of 1% and 10% per year. The net present value is used to analyze the relative value of the asset in comparison to a hypothetical alternative. To find the NPV, the summation of the net cash flows at each time point discounted back to the first time period is used. First, the discount rate of 0.01 is used over a span of 10 years. To determine the cash flow, the hourly costs are converted to yearly costs, resulting in a cash flow array of: [-16,260,664.4, 4029.6, 4029.6, 4029.6, 4029.6, 4029.6, … 4029.6]. This results in a NPV of -1.622e7, and a negative NPV indicates that the proposed asset will generate less income than the alternative investment. This was repeated for an alternative investment with a yield of 10% which had an NPV of -1.624e7 which is also negative, indicating less income will be generated than the hypothetical alternative. The negative NPV is mostly due to the high costs of the reactants and the low price of the resulting product, isoprene. 

"""

# ╔═╡ ce17d0fa-b262-4d94-b7c1-4fa16d3e16a6
begin

	# compute the optimal flux -
	result = calculate_optimal_flux_distribution(S, updated_flux_bounds, species_bounds, c);

	# get the open extent vector -
	ϵ_dot = result.calculated_flux_array

	# what is the composition coming out of the first chip?
	n_dot_out_chip_1 = (n_dot_input_stream_1 + n_dot_input_stream_2 + S*ϵ_dot);

	# did this converge?
	with_terminal() do

		# get exit/status information from the solver -
		exit_flag = result.exit_flag
		status_flag = result.status_flag

		# display -
		println("Computed optimal flux distribution Chip 1 exit_flag = 0: $(exit_flag==0) and status_flag = 5: $(status_flag == 5)")
	end
end

# ╔═╡ 723b1c85-e463-4c30-99f3-66bf59b46988
md"""
##### Compute the output of chips $i=2,\dots,N$ by solving the flux balance analysis problem for each chip
"""

# ╔═╡ fe1908c6-2d1d-4eda-b880-1eebc086b92f
# setup calculation for chips i = 2,....,N
N = 37;  # number of chips in the series

# ╔═╡ 61a5a07b-532e-47e6-9e93-31cca9366843
begin

	# initialize some space to store the mol flow rates -
	series_mol_state_array = zeros(ℳ,N)
	exit_flag_array = Array{Int64,1}()
	status_flag_array = Array{Int64,1}()

	# the initial col of this array is the output of from chip 1
	for species_index = 1:ℳ
		series_mol_state_array[species_index,1] = n_dot_out_chip_1[species_index]
	end
	
	# assumption: we *always* feed glycerol into port 2 - so we only need to update the input flow into port 1
	for chip_index = 2:N

		# update the input into the chip -
		n_dot_input_port_1 = series_mol_state_array[:,chip_index - 1] 		# the input to chip j comes from j - 1
	
		# setup the species bounds array -
		species_bounds_next_chip = [-1.0*(n_dot_input_port_1.+n_dot_input_stream_2) 1000.0*ones(ℳ,1)]

		# run the optimal calculation -
		result_next_chip = calculate_optimal_flux_distribution(S, updated_flux_bounds, species_bounds_next_chip, c);

		# grab the status and exit flags ... so we can check all is right with the world ...
		push!(exit_flag_array, result_next_chip.exit_flag)
		push!(status_flag_array, result_next_chip.status_flag)

		# Get the flux from the result object -
		ϵ_dot_next_chip = result_next_chip.calculated_flux_array

		# compute the output from chip j = chip_index 
		n_dot_out_next_chip = (n_dot_input_port_1 + n_dot_input_stream_2 + S*ϵ_dot_next_chip);

		# copy this state vector into the state array 
		for species_index = 1:ℳ
			series_mol_state_array[species_index,chip_index] = n_dot_out_next_chip[species_index]
		end

		# go around again ...
	end
end

# ╔═╡ 66b3e443-6d26-4600-a150-35254e3ce0c8
(exit_flag_array, status_flag_array)

# ╔═╡ 0c8d9d3d-dcca-4dd2-9656-327659b7aa50
md"""
##### Table 1: State table describing the exit composition (mol/hr) for each chip

Each row of the table shows a different compound, while the columns show the mol flow rate for component $i$ in the output from chip $i$. 
The last two columns show the mass flow rate and mass fraction for component $i$ in the exit from chip $N$.
"""

# ╔═╡ d59173a6-2dd4-4354-9ad9-c0e6d1cee03b
begin

	# what chip r we looking at?
	n_dot_output_chip = series_mol_state_array[:,end]

	# get the array of MW -
	MW_array = MODEL[:compounds][!,:compound_mw]

	# convert the output mol stream to a mass stream -
	mass_dot_output = (n_dot_output_chip.*MW_array)*(1/1000)

	# what is the total coming out?
	total_mass_out = sum(mass_dot_output)
	
	# display code makes the table -
	with_terminal() do

		# what are the compound names and code strings? -> we can get these from the MODEL object 
		compound_name_strings = MODEL[:compounds][!,:compound_name]
		compound_id_strings = MODEL[:compounds][!,:compound_id]
		
		# how many molecules are in the state array?
		ℳ_local = length(compound_id_strings)
	
		# initialize some storage -
		number_of_cols = 3 + N + 2
		state_table = Array{Any,2}(undef,ℳ_local,number_of_cols)

		# get the uptake array from the result -
		uptake_array = result.uptake_array

		# populate the state table -
		for compound_index = 1:ℳ_local
			state_table[compound_index,1] = compound_index
			state_table[compound_index,2] = compound_name_strings[compound_index]
			state_table[compound_index,3] = compound_id_strings[compound_index]

			for chip_index = 1:N
				tmp_value = abs(series_mol_state_array[compound_index, chip_index])
				state_table[compound_index,chip_index + 3] = (tmp_value) <= 1e-6 ? 0.0 : 
					series_mol_state_array[compound_index, chip_index]
			end

			# show the mass -
			tmp_value = abs(mass_dot_output[compound_index])
			state_table[compound_index,(N + 3 + 1)] = (tmp_value) <= 1e-6 ? 0.0 : mass_dot_output[compound_index]

			# show the mass fraction -
			# show the mass -
			tmp_value = abs(mass_dot_output[compound_index])
			state_table[compound_index, (N + 3 + 2)] = (tmp_value) <= 1e-6 ? 0.0 : 	
				(1/total_mass_out)*mass_dot_output[compound_index]
		end

		# build the table header -
		id_header_row = Array{String,1}()
		units_header_row = Array{String,1}()

		# setup id row -
		push!(id_header_row, "i")
		push!(id_header_row, "name")
		push!(id_header_row, "id")
		for chip = 1:N
			push!(id_header_row, "Chip $(chip)")
		end
		push!(id_header_row, "m_dot")
		push!(id_header_row, "ωᵢ_output")

		# setup units header row -
		push!(units_header_row, "")
		push!(units_header_row, "")
		push!(units_header_row, "")
		for chip = 1:N
			push!(units_header_row, "mmol/hr")
		end
		push!(units_header_row, "g/hr")
		push!(units_header_row, "")
		
		# header row -
		state_table_header_row = (id_header_row, units_header_row)
		
		# write the table -
		pretty_table(state_table; header=state_table_header_row)
	end
end

# ╔═╡ 745ffb9e-6ae4-413e-b484-1942c40002c1
md"""
###### Downstream separation using Magical Separation Units (MSUs)
"""

# ╔═╡ 24acbfa2-6700-4c2e-97cb-0a74000b741a
# how many levels are we going to have in the separation tree?
number_of_levels = 6;

# ╔═╡ 73f5e8a5-0e53-4b25-94ed-93dd0aba92e0
# However: the desired product has the opposite => correct for my compound of interest -> this is compound i = ⋆
idx_target_compound = find_compound_index(MODEL,:compound_name=>"isoprene");

# ╔═╡ 19848d78-d595-427f-aca5-ac190a5edf47
begin

	# define the split -
	θ = 0.75

	# most of the "stuff" has a 1 - θ in the up, and a θ in the down
	u = (1-θ)*ones(ℳ,1)
	d = θ*ones(ℳ,1)

	# correct defaults -
	u[idx_target_compound] = θ
	d[idx_target_compound] = 1 - θ

	# let's compute the composition of the *always up* stream -
	
	# initialize some storage -
	species_mass_flow_array_top = zeros(ℳ,number_of_levels)
	species_mass_flow_array_bottom = zeros(ℳ,number_of_levels)

	for species_index = 1:ℳ
		value = mass_dot_output[species_index]
		species_mass_flow_array_top[species_index,1] = value
		species_mass_flow_array_bottom[species_index,1] = value
	end
	
	for level = 2:number_of_levels

		# compute the mass flows coming out of the top -
		m_dot_top = mass_dot_output.*(u.^(level-1))
		m_dot_bottom = mass_dot_output.*(d.^(level-1))

		# update my storage array -
		for species_index = 1:ℳ
			species_mass_flow_array_top[species_index,level] = m_dot_top[species_index]
			species_mass_flow_array_bottom[species_index,level] = m_dot_bottom[species_index]
		end
	end
	
	# what is the mass fraction in the top stream -
	species_mass_fraction_array_top = zeros(ℳ,number_of_levels)
	species_mass_fraction_array_bottom = zeros(ℳ,number_of_levels)

	# array to hold the *total* mass flow rate -
	total_mdot_top_array = zeros(number_of_levels)
	total_mdot_bottom_array = zeros(number_of_levels)
	
	# this is a dumb way to do this ... you're better than that JV come on ...
	T_top = sum(species_mass_flow_array_top,dims=1)
	T_bottom = sum(species_mass_flow_array_bottom,dims=1)
	for level = 1:number_of_levels

		# get the total for this level -
		T_level_top = T_top[level]
		T_level_bottom = T_bottom[level]

		# grab -
		total_mdot_top_array[level] = T_level_top
		total_mdot_bottom_array[level] = T_level_bottom

		for species_index = 1:ℳ
			species_mass_fraction_array_top[species_index,level] = (1/T_level_top)*
				(species_mass_flow_array_top[species_index,level])
			species_mass_fraction_array_bottom[species_index,level] = (1/T_level_bottom)*
				(species_mass_flow_array_bottom[species_index,level])
		end
	end
end

# ╔═╡ b6d0376c-9348-4ef7-a16b-ee3c1fd06398
begin

	stages = (1:number_of_levels) |> collect
	plot(stages,species_mass_fraction_array_top[idx_target_compound,:], linetype=:steppre,lw=2,legend=:bottomright, 
		label="Mass fraction i = PDO Tops")
	xlabel!("Stage index l",fontsize=18)
	ylabel!("Tops mass fraction ωᵢ (dimensionless)",fontsize=18)

	# make a 0.95 line target line -
	target_line = 0.95*ones(number_of_levels)
	plot!(stages, target_line, color="red", lw=2,linestyle=:dash, label="Target 95% purity")
end

# ╔═╡ c1146166-6d6b-43bc-8500-40c2f65b6ecb
with_terminal() do

	# initialize some space -
	state_table = Array{Any,2}(undef, number_of_levels, 3)
	for level_index = 1:number_of_levels
		state_table[level_index,1] = level_index
		state_table[level_index,2] = species_mass_fraction_array_top[idx_target_compound, level_index]
		state_table[level_index,3] = total_mdot_top_array[level_index]
	end
	
	# header -
	state_table_header_row = (["stage","ωᵢ i=⋆ top","mdot"],
			["","","g/hr"]);

	# write the table -
	pretty_table(state_table; header=state_table_header_row)
end

# ╔═╡ fe7af914-b934-480d-af63-01265ddb19d8
md"""
### Conclusion

With the task of creating a bioprocess to manufacture high-value small molecules using renewable sugar feedstocks and cell-free bioreactors, Olin Engineering designed a continuous production process that produces 95% pure isoprene from sucrose feedstock. In order to produce a stream at a rate of 1.0 grams per hour, first, sucrose, ATP, and beta-d-fructose 1,6-bisphosphate were chosen as the three reactants and their respective quantities were determined. Finally, a financial analysis was conducted comparing the costs of using a parallel or series method to yield 1 gram of isoprene per hour, and the series version was determined to be more inexpensive. Furthermore, the financial performance of this model was analyzed in order to conclude the economic feasibility of the process compared to an alternative investment. 
"""

# ╔═╡ 1fad21b1-365b-4cbb-9a38-c42bf5f46951
md"""
### References


Sucrose Price: https://www.sigmaaldrich.com/US/en/product/sigma/s8501 

ATP Price: https://www.sigmaaldrich.com/US/en/product/aldrich/a26209 

Beta-d-fructose 1,6 bisphosphate Price: https://www.sigmaaldrich.com/US/en/product/sigma/f6803 

Isoprene Price: https://www.sigmaaldrich.com/US/en/search/isoprene focus=products&page=1&perPage=30&sort=relevance&term=isoprene&type=product

Isoprene Rubber: https://polymerdatabase.com/Polymer%20Brands/Isoprene.html 

Isoprene: https://webwiser.nlm.nih.gov/substance?substanceId=81&identifier=Isoprene&identifierType=name&menuItemId=22&catId=24 
"""

# ╔═╡ 8262c84a-1f81-469b-8e7e-b86266c578cd
html"""
<script>

	// initialize -
	var section = 0;
	var subsection = 0;
	var headers = document.querySelectorAll('h3, h4');
	
	// main loop -
	for (var i=0; i < headers.length; i++) {
	    
		var header = headers[i];
	    var text = header.innerText;
	    var original = header.getAttribute("text-original");
	    if (original === null) {
	        
			// Save original header text
	        header.setAttribute("text-original", text);
	    } else {
	        
			// Replace with original text before adding section number
	        text = header.getAttribute("text-original");
	    }
	
	    var numbering = "";
	    switch (header.tagName) {
	        case 'H3':
	            section += 1;
	            numbering = section + ".";
	            subsection = 0;
	            break;
	        case 'H4':
	            subsection += 1;
	            numbering = section + "." + subsection;
	            break;
	    }

		// update the header text 
		header.innerText = numbering + " " + text;
	};
</script>
"""

# ╔═╡ 3d738ed7-f784-489b-89d2-842ffaa770b9
html"""
<style>
main {
    max-width: 1200px;
    width: 75%;
    margin: auto;
    font-family: "Roboto, monospace";
}

a {
    color: blue;
    text-decoration: none;
}

.H1 {
    padding: 0px 30px;
}
</style>"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BSON = "fbb218c0-5317-5bc6-957e-2ee96dd4b1f0"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
GLPK = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"

[compat]
BSON = "~0.3.4"
DataFrames = "~1.3.0"
GLPK = "~0.15.2"
Plots = "~1.25.1"
PlutoUI = "~0.7.21"
PrettyTables = "~1.2.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.6.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.BSON]]
git-tree-sha1 = "ebcd6e22d69f21249b7b8668351ebf42d6dc87a1"
uuid = "fbb218c0-5317-5bc6-957e-2ee96dd4b1f0"
version = "0.3.4"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "365c0ea9a8d256686e97736d6b7fb0c880261a7a"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.1"

[[deps.BinaryProvider]]
deps = ["Libdl", "Logging", "SHA"]
git-tree-sha1 = "ecdec412a9abc8db54c0efc5548c64dfce072058"
uuid = "b99e7846-7c00-51b0-8f62-c81ae34c0232"
version = "0.5.10"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f2202b55d816427cd385a9a4f3ffb226bee80f99"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+0"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "4c26b4e9e91ca528ea212927326ece5918a04b47"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.2"

[[deps.ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "9a1d594397670492219635b35a3d830b04730d62"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.1"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "Libdl", "TranscodingStreams"]
git-tree-sha1 = "2e62a725210ce3c3c2e1a3080190e7ca491f18d7"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.7.2"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "a851fec56cb73cfdf43762999ec72eff5b86882a"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.15.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "2e993336a3f68216be91eb8ee4625ebbaba19147"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "0c603255764a1fa0b61752d2bec14cfbd18f7fe8"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+1"

[[deps.GLPK]]
deps = ["BinaryProvider", "CEnum", "GLPK_jll", "Libdl", "MathOptInterface"]
git-tree-sha1 = "ab6d06aa06ce3de20a82de5f7373b40796260f72"
uuid = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
version = "0.15.2"

[[deps.GLPK_jll]]
deps = ["Artifacts", "GMP_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "fe68622f32828aa92275895fdb324a85894a5b1b"
uuid = "e8aa6df9-e6ca-548a-97ff-1f85fc5b8b98"
version = "5.0.1+0"

[[deps.GMP_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "781609d7-10c4-51f6-84f2-b8444358ff6d"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "30f2b340c2fff8410d89bfcdc9c0a6dd661ac5f7"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.62.1"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fd75fa3a2080109a2c0ec9864a6e14c60cca3866"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.62.0+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "74ef6288d071f58033d54fd6708d4bc23a8b8972"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+1"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a8f4f279b6fa3c3c4f1adadd78a621b13a506bce"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.9"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "be9eef9f9d78cecb6f262f3c10da151a6c5ab827"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.5"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "JSON", "LinearAlgebra", "MutableArithmetics", "OrderedCollections", "Printf", "SparseArrays", "Test", "Unicode"]
git-tree-sha1 = "92b7de61ecb616562fd2501334f729cc9db2a9a6"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "0.10.6"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "7bb6853d9afec54019c1397c6eb610b9b9a19525"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "0.3.1"

[[deps.NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "b084324b4af5a438cd63619fd006614b3b20b87b"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.15"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun"]
git-tree-sha1 = "3e7e9415f917db410dcc0a6b2b55711df434522c"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.25.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "b68904528fd538f1cb6a3fbc44d2abdc498f9e8e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.21"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "d940010be611ee9d67064fe559edbb305f8cc0eb"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "7ad0dfa8d03b7bcf8c597f59f5292801730c55b8"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.4.1"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3c76dde64d03699e074ac02eb2e8ba8254d428da"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.13"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
git-tree-sha1 = "0f2aa8e32d511f758a2ce49208181f7733a0936a"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.1.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2bb0cb32026a66037360606510fca5984ccc6b75"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.13"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "2ce41e0d042c60ecd131e9fb7154a3bfadbf50d3"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.3"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "66d72dc6fcc86352f01676e8f0f698562e60510f"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.23.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─9b33620b-d922-4416-9880-50b5d7ad7753
# ╟─50d38e3a-60e1-43f9-8bf6-0a9ea34bc5a4
# ╟─46c352c3-60f1-4718-8878-d0031d5bd0ca
# ╟─4bcb9ef8-ea0a-480f-82f0-d15f5a7a7e43
# ╟─47bddebd-389d-41d9-ba71-2489040c1925
# ╠═7b34264c-2a59-43fb-a079-a1c7ef367b8f
# ╟─5bf9e5fb-c9fc-4962-a453-9948e5c6d79c
# ╟─928ef8ae-264a-4448-ac08-3970a8d8d1db
# ╠═ce17d0fa-b262-4d94-b7c1-4fa16d3e16a6
# ╟─723b1c85-e463-4c30-99f3-66bf59b46988
# ╠═fe1908c6-2d1d-4eda-b880-1eebc086b92f
# ╠═61a5a07b-532e-47e6-9e93-31cca9366843
# ╠═66b3e443-6d26-4600-a150-35254e3ce0c8
# ╟─0c8d9d3d-dcca-4dd2-9656-327659b7aa50
# ╟─d59173a6-2dd4-4354-9ad9-c0e6d1cee03b
# ╟─745ffb9e-6ae4-413e-b484-1942c40002c1
# ╠═24acbfa2-6700-4c2e-97cb-0a74000b741a
# ╠═73f5e8a5-0e53-4b25-94ed-93dd0aba92e0
# ╟─19848d78-d595-427f-aca5-ac190a5edf47
# ╟─b6d0376c-9348-4ef7-a16b-ee3c1fd06398
# ╟─c1146166-6d6b-43bc-8500-40c2f65b6ecb
# ╟─fe7af914-b934-480d-af63-01265ddb19d8
# ╟─1fad21b1-365b-4cbb-9a38-c42bf5f46951
# ╟─915e211e-5853-11ec-1c6b-51ba02d42502
# ╟─8262c84a-1f81-469b-8e7e-b86266c578cd
# ╟─3d738ed7-f784-489b-89d2-842ffaa770b9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
