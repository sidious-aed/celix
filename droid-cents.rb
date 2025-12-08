#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 6
  puts "params | 6-8"
  puts "1 | binary-name"
	puts "2 | binary-site-1 (base-16)"
	puts "3 | ocurance-site-1 (base-16)"
	puts "4 | binary-site-2 (base-16)"
	puts "5 | ocurance-site-2 (base-16)"
	puts "6 | binary-comand"
	puts "(7) | view-full-quads (yes|no)"
	puts "(8) | map-replaces ([\"io.do.9-anon-1|io.do.9-anon-0\", \"io.do.9-anon-2|io.do.9-anon-1\"])"
  return
end
samples_node = "cents/"
binary_name = params[0]
binary_site_1 = params[1].to_i(16)
ocurance_site_1 = params[2].to_i(16)
binary_site_2 = params[3].to_i(16)
ocurance_site_2 = params[4].to_i(16)
binary_comand = params[5]
view_full_quads = params[6] == "yes"
replaces = {}
if params[7]
	replaces_vecter = eval(params[7])
	naof_replaces = replaces_vecter.length
	replaces = {}
	site = 0
	while true
		if site == naof_replaces
			break
		end
		replacer = replaces_vecter[site]
		name, replace_name = replacer.split("|")
		replaces[name] = replace_name
		site += 1
	end
	puts "replaces | #{replaces}"
	#$stdin.gets
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

droid_stack_scans(bc, binary_name, binary_site_1, binary_comand, samples_node)
ssf1 = stack_segments_for(samples_node, binary_name, binary_site_1, ocurance_site_1)
puts "ssf1 | #{ssf1}"
maps_1 = maps_manafest(File::open(ssf1[0]).read)
view_vecter(poly_clone(maps_1))
print "map-site (base16) | "
map_site_1 = $stdin.gets.strip.to_i(16)
puts "map-site-1 | #{map_site_1.to_s(16)}"
is_rack = false
naof_maps = maps_1.length
msite = 0
while true
	if msite == naof_maps
		break
	end
	map = maps_1[msite]
	view_one(poly_clone(map))
	#puts "map-site | #{map["site"].to_s(16)}"
	if map["site"] == map_site_1
		if map["name"] == "[rack]" || map["name"] == "[rack] - dynamic"
			is_rack = true
		end
		break
	end
	msite += 1
end
#puts "is-rack | #{is_rack}"
#$stdin.gets

droid_stack_scans(bc, binary_name, binary_site_2, binary_comand, samples_node)
ssf2 = stack_segments_for(samples_node, binary_name, binary_site_2, ocurance_site_2)
maps_2 = maps_manafest(File::open(ssf2[0]).read)
view_vecter(maps_2)
print "map-site (base16) | "
map_site_2 = $stdin.gets.strip.to_i(16)
qms1 = stack_segment_meta(samples_node, binary_name, binary_site_1, ocurance_site_1, map_site_1, replaces)
#puts "qms1 | #{qms1}"
#return
qms2 = stack_segment_meta(samples_node, binary_name, binary_site_2, ocurance_site_2, map_site_2)
if view_full_quads
	view_vecter(poly_clone(qms1))
	$stdin.gets
	view_vecter(poly_clone(qms2))
	$stdin.gets
end
log_heading("diff")
diff = stack_segments_diff(qms1, qms2, is_rack)
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
