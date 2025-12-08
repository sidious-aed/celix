#!/usr/bin/env ruby
require "/home/tyrel/celix/sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | samples-node"
  return
end
samples_node = params[0]
binary_name = params[1]
if samples_node[-1] != "/"
	samples_node += "/"
end
bc = BinaryClerk.new(binary_name)
bc.engage_slots
sources = filter_node_nodes(Dir::entries(samples_node)[2..-1])
#puts "sources | #{sources}"
naof_sources = sources.length
asms = []
site = 0
while true
	if site == naof_sources
		break
	end
	name = "#{samples_node}#{sources[site]}/"
	if File::directory?(name)
		bn, bsb16 = name.split("/")[-1].split("-")
		asm_name = "#{name}asm.meta"
		asm = eval(File::open(asm_name).read)
		view_one(poly_clone(asm))
		samples = []
		#$stdin.gets
		node_sources = filter_node_nodes(Dir::entries(name))
		naof_node_sources = node_sources.length
		nsite = 0
		while true
			if nsite == naof_node_sources
				break
			end
			name_in_node = node_sources[nsite]
			components = name_in_node.split(".")
			if components[-1] == "sample-meta"
				sample_name = name_in_node
				samples += [sample_name]
			end
			nsite += 1
		end
		samples = sort_samples(samples)
		naof_samples = samples.length
		ssite = 0
		while true
			if ssite == naof_samples
				break
			end
			sample_name = samples[ssite]
			sample_name = "#{name}#{sample_name}"
			puts "sample-name | #{sample_name}"
			sample = eval(File::open(sample_name).read)
			rsite = 0
			while true
				if rsite == BinaryConstants::NaofRegisters
					break
				end
				register = sample["registers"][rsite]
				if (register["segment"] && register["segment"].index("io.do.9") && register["fz-site"] == 0x1c19c) || (register["number"] == 0x1c19c)
					lasm = poly_clone(asm) # lasm | lead-asm
					lasm["ocurance-site"] = ssite
					lasm["register-mention"] = register["name"]
					asms += [lasm]
				end
				rsite += 1
			end
			ssite += 1
		end
	end
	site += 1
end
view_vecter(asms)
