#!/usr/bin/env ruby
require "/home/tyrel/celix/binary-clerk.rb"
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
	sample_sources = filter_node_nodes(Dir::entries(name))
	naof_sample_sources = sample_sources.length
	ssite = 0
	while true
		if ssite == naof_sample_sources
			break
		end
		components = sample_sources[ssite].split(".")
		if components[-1] == "sample-meta"
			sample_source = "#{name}#{sample_sources[ssite]}"
			puts "sample-source | #{sample_source}"
			sample = eval(File::open(sample_source).read)
			view_vecter(poly_clone(sample["maps"]))
			maps = []
			naof_maps = sample["maps"].length
			after_droid_space = false
			msite = 0
			while true
				if msite == naof_maps
					break
				end
				#puts "msite | #{msite}"
				map = sample["maps"][msite]
				view_one(poly_clone(map))
				if after_droid_space && map["name"].index("io.do.9-anon")
					components = map["name"].split(" - ")
					anon_components = components[0].split("-")
					anon_components[-1] = "#{(anon_components[-1].to_i - 1)}"
					components[0] = anon_components.join("-")
					map["name"] = components.join(" - ")
				end
				next_map = sample["maps"][(msite + 1)]
				if next_map && next_map["name"].split(" - ")[0] == "/home/tyrel/celix/secs/equations.secs"
					after_droid_space = true
					msite += 4
					next
				end
				maps += [map]
				msite += 1
			end
			sample["maps"] = maps
			chart = File::open(sample_source, "w")
			chart.write(sample)
			chart.close
			view_vecter(poly_clone(maps))
			#$stdin.gets
		end
		ssite += 1
	end
	site += 1
end
