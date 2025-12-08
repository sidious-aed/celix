#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 4
  puts "params | 4"
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
comand = "rm -r cents"
puts "comand | #{comand}"
system(comand)
comand = "cn cents"
puts "comand | #{comand}"
system(comand)
meta = get_binary_meta(binary_name)
dynsyms = get_binary_meta(binary_name)["dynsym"]
bc = BinaryClerk.new(binary_name)

droid_stack_scans(bc, binary_name, binary_site, binary_comand, samples_node)
ssf1 = stack_segments_for(samples_node, binary_name, binary_site, ocurance_site)
puts "ssf1 | #{ssf1}"
maps = maps_manafest(File::open(ssf1[0]).read)
view_vecter(maps)
print "map-site (base16) | "
map_site = $stdin.gets.strip.to_i(16)
qms = stack_segment_meta(samples_node, binary_name, binary_site, ocurance_site, map_site, dynsyms)
view_vecter(poly_clone(qms))
