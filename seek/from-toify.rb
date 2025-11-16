#!/usr/bin/env ruby
require "/home/tyrel/celix/binary-clerk.rb"
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
bc = BinaryClerk.new(binary_name)
bc.engage_slots
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
			asm = eval(File::open(asm_name).read)
			view_one(poly_clone(asm))
			from_to_name = "#{name}from-to.meta"
			puts "from-to-name | #{from_to_name}"
			#$stdin.gets
			from_to = bc.ametas[binary_name]["from-tos"][asm["site"]]
			puts "from-to | #{from_to}"
			chart = File::open(from_to_name, "w")
			chart.write(from_to)
			chart.close
		end
	end
	site += 1
end
