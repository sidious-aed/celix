#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 4
  puts "params | 4-6"
  puts "1 | binary-name"
	puts "2 | binary-site (base-16)"
	puts "3 | ocurance-site (base-16)"
	puts "4 | binary-comand"
	puts "(5) | object-scope (base-16)"
	puts "(6) | naof-scope-secs (base-16)"
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

droid_stack_scans(bc, binary_name, binary_site, binary_comand, samples_node, false)
ssf1 = stack_segments_for(samples_node, binary_name, binary_site, ocurance_site)
puts "ssf1 | #{ssf1}"
maps = maps_manafest(File::open(ssf1[0]).read)
naof_maps = maps.length
view_vecter(poly_clone(maps))
print "map-site (base16) | "
map_site = $stdin.gets.strip.to_i(16)
puts "map-site | #{map_site.to_s(16)}"
qms = stack_segment_meta(samples_node, binary_name, binary_site, ocurance_site, map_site)
naof_quads = qms.length
puts "naof-quads | #{naof_quads}"
quads = nil
if object_scope
	binary_name = binary_name.gsub(".so.", ".do.")
	binary_name = binary_name.gsub("-do", "-steel")
	msite = 0
	while true
		if msite == naof_maps
			msite = nil
			break
		end
		map = maps[msite]
		#view_one(poly_clone(map))
		if map["category"] == "binary" && map["name"].index(binary_name) != nil
			break
		end
		msite += 1
	end
	puts "msite | #{msite}"
	if msite
		bmap = maps[msite]
		msite = 0
		while true
			if msite == naof_maps
				msite = nil
				break
			end
			map = maps[msite]
			if map["site"] == map_site
				break
			end
			msite += 1
		end
		omap = maps[msite]
		view_vecter(poly_clone([bmap, omap]))
		object_scope -= (omap["origin"] - bmap["origin"])
		puts "object-scope | #{object_scope.to_s(16)}"
		object_scope_com = object_scope + naof_scope_secs
		puts "object-scope-com | #{object_scope_com.to_s(16)}"
		qsite = 0
		quads = []
		while true
			if qsite == naof_quads
				break
			end
			quad = qms[qsite]
			#puts "quad | #{quad}"
			if (quad["in-segment-site"] >= object_scope) && ((quad["in-segment-site"] + 8) < object_scope_com)
				quads += [quad]
			end
			qsite += 1
		end
	end
else
	quads = qms
end
view_vecter(poly_clone(quads))
