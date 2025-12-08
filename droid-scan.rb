#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 4
  puts "params | 4-6"
  puts "1 | binary-name"
	puts "2 | binary-site (base-16)"
	puts "3 | ocurance-site (base-16)"
	puts "4 | binary-comand"
  return
end
samples_node = "cents/"
binary_name = params[0]
binary_site = params[1].to_i(16)
ocurance_site = params[2].to_i(16)
binary_comand = params[3]
object_scope = nil
naof_scope_secs = nil
if params[4]
	object_scope = params[4].to_i(16)
	naof_scope_secs = params[5].to_i(16)
end
comand = "rm -r cents"
puts "comand | #{comand}"
system(comand)
comand = "cn cents"
puts "comand | #{comand}"
system(comand)
meta = get_binary_meta(binary_name)
dynsyms = get_binary_meta(binary_name)["dynsym"]
puts "binary-name | #{binary_name}"
bc = BinaryClerk.new(binary_name)

droid_stack_scans(bc, binary_name, binary_site, binary_comand, samples_node)
ssf = stack_segments_for(samples_node, binary_name, binary_site, ocurance_site)
puts "ssf | #{ssf}"
maps = maps_manafest(File::open(ssf[0]).read)
naof_maps = maps.length
view_vecter(poly_clone(maps))
print "map-site (base16) | "
map_site = $stdin.gets.strip.to_i(16)
print "segment-site (base-16) | "
segment_site = $stdin.gets.strip.to_i(16)
puts "segment-site | #{segment_site.to_s(16)}"
map = maps[map_site]
stack_site = map["origin"] + segment_site
puts "stack-site | #{stack_site.to_s(16)}"
naof_segments = ssf[2].length
puts "naof-segments | #{naof_segments}"
leads = []
site = 0
while true
	if site == naof_segments
		break
	end
	segment_name = ssf[2][site]
	naof_quads = File::size(segment_name) / 8
	segment = File::open(segment_name)
	qsite = 0
	while true
		if qsite == naof_quads
			break
		end
		quad_site = qsite * 8
		quad_secs = segment.read(8).bytes.reverse
		quad = number_aof(quad_secs)
		if quad == stack_site || quad == segment_site
			puts "quad | #{quad.to_s(16)}"
			leads += [{
				"segment" => segment_name,
				"segment-site" => quad_site
			}]
		end
		qsite += 1
	end
	site += 1
end
view_vecter(leads)
