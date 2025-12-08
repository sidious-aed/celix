#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 7
  puts "params | 7"
	puts "1 | samples-node"
  puts "2 | binary-name-1"
	puts "3 | binary-site-1 (base-16)"
	puts "4 | ocurance-site-1 (base-16)"
  puts "5 | binary-name-2"
	puts "6 | binary-site-2 (base-16)"
	puts "7 | ocurance-site-2 (base-16)"
  return
end
samples_node = params[0]
binary_name_1 = params[1]
binary_site_1 = params[2].to_i(16)
ocurance_site_1 = params[3].to_i(16)
binary_name_2 = params[4]
binary_site_2 = params[5].to_i(16)
ocurance_site_2 = params[6].to_i(16)
meta = get_binary_meta(binary_name_1)
dynsyms = get_binary_meta(binary_name_1)["dynsym"]
ssf1 = stack_segments_for(samples_node, binary_name_1, binary_site_1, ocurance_site_1)
maps_1 = maps_manafest(File::open(ssf1[0]).read)
view_vecter(maps_1)
print "map-site (base16) | "
map_site_1 = $stdin.gets.strip.to_i(16)
ssf2 = stack_segments_for(samples_node, binary_name_2, binary_site_2, ocurance_site_2)
maps_2 = maps_manafest(File::open(ssf2[0]).read)
view_vecter(maps_2)
print "map-site (base16) | "
map_site_2 = $stdin.gets.strip.to_i(16)
qms1 = stack_segment_meta(samples_node, binary_name_1, binary_site_1, ocurance_site_1, map_site_1, dynsyms)
qms2 = stack_segment_meta(samples_node, binary_name_2, binary_site_2, ocurance_site_2, map_site_2, dynsyms)
log_heading("diff")
diff = stack_segments_diff(qms1, qms2)
naof_elements = diff.length
naof_added = 0
site = 0
while true
	if site == naof_elements
		break
	end
	element = diff[site]
	if element["diff"] == "added"
		naof_added += 1
	end
	site += 1
end
view_vecter(diff)
puts "naof-elements | #{naof_elements.to_s(16)}"
puts "naof-added | #{naof_added.to_s(16)}"
