#!/usr/bin/env ruby
require "/home/tyrel/celix/charts.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 2
  puts "params | 2"
  puts "1 | samples-node"
	puts "2 | binary-name"
  return
end
samples_node = params[0]
binary_name = params[1]
if samples_node[-1] != "/"
	samples_node += "/"
end
sources = Dir::entries(samples_node)[2..-1]
#puts "sources | #{sources}"
naof_sources = sources.length
asms = {}
mods = []
site = 0
while true
	if site == naof_sources
		break
	end
	name = "#{samples_node}#{sources[site]}/"
	if File::directory?(name)
		bn, bsb16 = name.split("/")[-1].split("-")
		if bn == binary_name
			asm_name = "#{name}asm.meta"
			#puts "asm-name | #{asm_name}"
			#puts "binary-name | #{binary_name}"
			#puts "binary-site-base-16 | #{bsb16}"
			asm = eval(File::open(asm_name).read)
			sample_sources = Dir::entries(name)
			naof_sample_sources = sample_sources.length
			naof_ocurances = 0
			ssite = 0
			while true
				if ssite == naof_sample_sources
					break
				end
				sample_source = sample_sources[ssite]
				if sample_source.split(".")[-1] == "sample-meta"
					naof_ocurances += 1
				end
				ssite += 1
			end
			asm["naof-ocurances"] = naof_ocurances
			mod = asm["mod"]
			asms[mod] ||= []
			asms[mod] += [asm]
			mods += [mod]
		end
	end
	site += 1
end
mods.uniq!
mods.sort!{|a,b| a <=> b}
naof_mods = mods.length
chart = Chart.new
site = 0
while true
	if site == naof_mods
		break
	end
	mod = mods[site]
	asms[mod].sort!{|a,b| a["bs"] <=> b["bs"]}
	chart.add_vecter(asms[mod])
	site += 1
end
chart.view
