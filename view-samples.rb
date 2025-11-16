#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | samples-node"
  return
end
samples_node = params[0]
if samples_node[-1] != "/"
	samples_node += "/"
end

view_asms = Chart.new
sample_nodes = filter_node_nodes(Dir::entries(samples_node))
naof_sample_nodes = sample_nodes.length
asms = []
sample_sites = []
sample_names = []
sample_site = 0
asite = 0
site = 0
while true
	if site == naof_sample_nodes
		break
	end
	sample_node = sample_nodes[site]
	binary_name, bsb16 = sample_node.split("-")
	sample_node = "#{samples_node}#{sample_node}/"
	#puts "sample-node | #{sample_node}"
	asm_name = "#{sample_node}asm.meta"
	asm = eval(File::open(asm_name).read)
	asm["binary-name"] = binary_name
	asm["asite"] = asite
	view_asm = poly_clone(asm)
	view_asm.delete("secs")
	view_asm.delete("naof-secs")
	view_asm["asite"] = asite
	sources = filter_node_nodes(Dir::entries(sample_node))
	#puts "sources | #{sources}"
	naof_sources = sources.length
	asm_sample_names = []
	ssite = 0
	while true
		if ssite == naof_sources
			break
		end
		name = sources[ssite]
		components = name.split(".")
		if components[-1] == "sample-meta"
			sample_name = "#{sample_node}#{name}"
			#puts "sample-name | #{sample_name}"
			asm_sample_names += [sample_name]
		end
		ssite += 1
	end
	naof_asm_samples = asm_sample_names.length
	site_com = sample_site + naof_asm_samples
	if naof_asm_samples > 0
		asm_sample_names.sort! do |a,b|
			comps1 = a.split("/")[-1].split(".")
			#puts "comps1 | #{comps1}"
			time1 = "#{comps1[1].to_i(16)}.#{comps1[2].to_i(16)}".to_f
			#puts "time1 | #{time1}"
			comps2 = b.split("/")[-1].split(".")
			#puts "comps2 | #{comps2}"
			time2 = "#{comps2[1].to_i(16)}.#{comps2[2].to_i(16)}".to_f
			#puts "time2 | #{time2}"
			time1 <=> time2
		end
		#puts "sample-site | #{sample_site}"
		sample_names += asm_sample_names
		asm["naof-ocurances"] = naof_asm_samples
		view_asm["naof-ocurances"] = naof_asm_samples
		view_asms.add(view_asm)
		asms += [asm]
		sample_sites += [(sample_site...(site_com))]
		#puts "sample-sites | #{sample_sites}"
		#if asm["bs"] == 0xd306
			#$stdin.gets
		#end
		sample_site = site_com
		asite += 1
	end
	site += 1
end
asm_sites = (0...asite).to_a
naof_asms = asite
view_sites = poly_clone(asm_sites)
#puts "asm-sites | #{asm_sites}"
#$stdin.gets
#puts "sample-names | #{sample_names}"
naof_sample_names = sample_names.length
#puts "naof-sample-names | #{naof_sample_names}"
#view_asms.engage_pause
while true
	naof_vsites = view_sites.length
	naof_vsamples = 0
	vsite = 0
	while true
		if vsite == naof_vsites
			break
		end
		asm = asms[view_sites[vsite]]
		#view_one(poly_clone(asm))
		#puts "sites-vecter | #{sample_sites[asm["site"]].to_a}"
		naof_vsamples += sample_sites[asm["asite"]].to_a.length
		vsite += 1
	end
	view_asms.view_sites(view_sites)
	puts "naof-asms    | #{naof_vsites.to_s(16)}"
	puts "naof-samples | #{naof_vsamples.to_s(16)}"
	print "comand | "
	comand = $stdin.gets.strip
	components = comand.split(" ")
	naof_components = components.length
	is_pause = true
	if components[0] == "v"
		asite = components[1].to_i(16)
		sites_r = sample_sites[asite]
		#puts "sites-r | #{sites_r}"
		names = sample_names[sites_r]
		puts "names | #{names}"
		naof_names = names.length
		puts "naof-names | #{naof_names}"
		puts
		view_asms.view(asite, asite)
		et = naof_names - 1
		ssite = 0
		while true
			if ssite == naof_names
				break
			end
			name = names[ssite]
			sample = eval(File::open(name).read)
			view_sample(sample, ssite)
			puts "sample-name | #{name}"
			if ssite == et
				puts
			end
			ssite += 1
		end
		view_asms.view(asite, asite)
		puts
	elsif components[0] == "vcs"
		asite = components[1].to_i(16)
		sites_r = sample_sites[asite]
		#puts "sites-r | #{sites_r}"
		names = sample_names[sites_r]
		puts "names | #{names}"
		naof_names = names.length
		puts "naof-names | #{naof_names}"
		puts
		view_asms.view(asite, asite)
		conditionals = []
		ssite = 0
		while true
			if ssite == naof_names
				break
			end
			name = names[ssite]
			sample = eval(File::open(name).read)
			conditionals += [{
				"site" => ssite,
				"conditional" => sample["is-conditional"]
			}]
			ssite += 1
		end
		view_vecter(conditionals)
		view_asms.view(asite, asite)
		puts
	elsif components[0] == "vrm"
		asite = components[1].to_i(16)
		sites_r = sample_sites[asite]
		register_name = components[2]
		#puts "sites-r | #{sites_r}"
		names = sample_names[sites_r]
		puts "names | #{names}"
		naof_names = names.length
		puts "naof-names | #{naof_names}"
		puts
		registers = []
		view_asms.view(asite, asite)
		ssite = 0
		while true
			if ssite == naof_names
				break
			end
			name = names[ssite]
			sample = eval(File::open(name).read)
			rsite = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
			register = sample["registers"][rsite]
			register["site"] = ssite
			registers += [register]
			ssite += 1
		end
		view_vecter(registers)
		view_asms.view(asite, asite)
		puts
	elsif components[0] == "vrs"
		vasms = []
		register_name = components[1]
		avsite = 0
		site = 0
		while true
			if site == naof_vsites
				break
			end
			asite = view_sites[site]
			sites_r = sample_sites[asite]
			names = sample_names[sites_r]
			naof_names = names.length
			ssite = 0
			while true
				if ssite == naof_names
					break
				end
				asm = poly_clone(asms[asite])
				name = names[ssite]
				sample = eval(File::open(name).read)
				rsite = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
				register = sample["registers"][rsite]
				asm["number"] = register["number"]
				asm["fz-segment"] = register["fz-segment"]
				asm["fz-site"] = register["fz-site"]
				asm["site"] = avsite
				vasms += [asm]
				avsite += 1
				ssite += 1
			end
			site += 1
		end
		view_vecter(vasms)
		puts
	elsif components[0] == "afs"
		filters = []
		values = []
		naof_filters = (naof_components - 1) / 2
		fsite = 0
		while true
			if fsite == naof_filters
				break
			end
			filter_site = (fsite * 2) + 1
			filters += [components[filter_site]]
			values += [components[(filter_site + 1)]]
			fsite += 1
		end
		puts "filters | #{filters}"
		puts "values | #{values}"
		vsites = []
		vsite = 0
		while true
			if vsite == naof_vsites
				break
			end
			asite = view_sites[vsite]
			asm = asms[asite]
			is_filter = false
			fsite = 0
			while true
				if fsite == naof_filters
					break
				end
				filter = filters[fsite]
				value = values[fsite]
				asm_value = asm[filter]
				if asm_value.class == Integer
					if (asm_value == value.to_i(16))
						is_filter = true
						break
					end
				else
					if (asm_value =~ /#{value}/i)
						is_filter = true
						break
					end
				end
				fsite += 1
			end
			if is_filter
				vsites += [asite]
			end
			vsite += 1
		end
		view_sites = vsites
		is_pause = false
	elsif components[0] == "sfs"
		filters = []
		values = []
		naof_filters = (naof_components - 1) / 2
		fsite = 0
		while true
			if fsite == naof_filters
				break
			end
			filter_site = (fsite * 2) + 1
			filters += [components[filter_site]]
			values += [components[(filter_site + 1)]]
			fsite += 1
		end
		puts "filters | #{filters}"
		puts "values | #{values}"
		vsites = []
		asite = 0
		while true
			if asite == naof_asms
				break
			end
			asm = asms[asite]
			is_filter = true
			fsite = 0
			while true
				if fsite == naof_filters
					break
				end
				filter = filters[fsite]
				value = values[fsite]
				asm_value = asm[filter]
				if asm_value.class == Integer
					asm_value = asm_value.to_s(16)
					if (asm_value != value)
						is_filter = false
						break
					end
				else
					if (asm_value =~ /#{value}/i) == nil
						is_filter = false
						break
					end
				end
				fsite += 1
			end
			if is_filter
				vsites += [asite]
			end
			asite += 1
		end
		view_sites = vsites
		is_pause = false
	elsif components[0] == "cfs"
		view_sites = poly_clone(asm_sites)
		is_pause = false
	elsif components[0] == "vl"
		bs_sites = []
		site = 0
		while true
			if site == naof_vsites
				break
			end
			asite = view_sites[site]
			asm = asms[asite]
			bs_sites += [asm["bs"]]
			site += 1
		end
		puts "view-list | #{bs_sites}"
	elsif components[0] == "c"
		break
	end
	if is_pause
		$stdin.gets
	end
end
