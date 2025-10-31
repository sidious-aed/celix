require "./core.rb"
require "./binary.rb"
require "./machine.rb"
require "./binary-clerk.rb"

def maps_manafest(maps_entree, zero_stay=nil)
	segments = maps_entree.split("\n")
	naof_segments = segments.length
  # anaon | ananomous-site
  anaon = 0
  manafest = []
	site = 0
	while true
		if site == naof_segments
			break
		end
		section = segments[site]
		components = section.split(" ")
		naof_components = components.length
		if naof_components == 5
			components += ["anonomous-#{anaon}"]
			anaon += 1
		end
		#puts "section | #{section}"
		#puts "components | #{components}"
		#puts "naof-components | #{naof_components}"
		origin_b16, completion_b16 = components[0].split("-")
		origin = origin_b16.to_i(16)
		completion = completion_b16.to_i(16)
		naof_secs = completion - origin
		name = components[-1]
		if name == "[stack]"
			name = name.gsub("stack", "rack")
		else
			name = [name, components[1], components[2], components[4]].join(" - ")
		end
		category = "dynamic"
		if components[1][2] == "x"
			category = "binary"
		elsif components[1] == "r--p"
			category = "special" # every thing is vast vast; * in prose, of could we.
		end
		name += " - #{category}"
		map_meta = {
			"site" => site,
			"name" => name,
			"origin" => origin,
			"completion" => completion,
			"naof-secs" => naof_secs,
			"category" => category
		}
		if zero_stay
			map_meta["from-zero"] = map_meta["origin"] - zero_stay
		end
		manafest += [map_meta]
		site += 1
  end
  manafest
end

def unlink_file(name)
	comand = "./ul #{name}"
	#puts "comand | #{comand}"
	system(comand)
	true
end

def which_maps(maps, stack_site)
	saught_maps = []
	naof_maps = maps.length
	msite = 0
	while true
		if msite == naof_maps
			break
		end
		map = maps[msite]
		if (stack_site >= map["origin"]) && (stack_site < map["completion"])
			map["segment-site"] = (stack_site - map["origin"])
			saught_maps += [map]
		end
		msite += 1
	end
	print_hash_vecter(saught_maps)
	saught_maps
end

def segmentify_stack_site(maps, stack_site)
	segmentified = {
		"stack-site" => stack_site,
		"segment" => "",
		"segment-site" => nil
	}
	naof_maps = maps.length
	msite = 0
	while true
		if msite == naof_maps
			break
		end
		map = maps[msite]
		if (stack_site >= map["origin"]) && (stack_site < map["completion"])
			segmentified["segment"] = map["name"].split(" - ")[0...2].join(" - ")
			segmentified["segment-site"] = segmentified["stack-site"] - map["origin"]
			break
		end
		msite += 1
	end
	segmentified
end

def droid_select(registers, key, value, site_receive=nil)
	selected_register = nil
	naof_registers = registers.length
	rsite = 0
	while true
		if rsite == naof_registers
			break
		end
		register = registers[rsite]
		if register[key] == value
			selected_register = register
			if site_receive
				site_receive["site"] = rsite
			end
			break
		end
		rsite += 1
	end
	selected_register
end

def sort_bars(space, keys)
	wide_key = keys[0]
	precise_site = keys[1]
	naof_elements = space.length
	sorted_space = []
	see_site = 0
	while true
		naof_sorted = sorted_space.length
		if naof_sorted == naof_elements
			break
		end
		#puts "sorted-space | #{sorted_space}"
		lowest_wide = nil
		esite = 0
		while true
			if esite == naof_elements
				break
			end
			element = space[esite]
			if sorted_space.index(element) == nil
				#puts "element | #{element}"
				elements = element.split(".")
				wide = elements[wide_key].to_i(16)
				#puts "wide | #{wide}"
				if (lowest_wide == nil) || (wide < lowest_wide)
					lowest_wide = wide
				end
			end
			esite += 1
		end
		#puts "lowest-wide | #{lowest_wide}"
		in_wide_bar = []
		esite = 0
		while true
			if esite == naof_elements
				break
			end
			element = space[esite]
			elements = element.split(".")
			wide = elements[wide_key].to_i(16)
			if wide == lowest_wide
				in_wide_bar += [element]
			end
			esite += 1
		end
		#puts "in-wide-bar | #{in_wide_bar}"
		naof_in_wide = in_wide_bar.length
		ssite = 0
		while true
			if ssite == naof_in_wide
				break
			end
			lowest_precise = nil
			lowest_site = nil
			esite = 0
			while true
				if esite == naof_in_wide
					break
				end
				element = in_wide_bar[esite]
				elements = element.split(".")
				if (sorted_space.index(element) == nil)
					#puts "element | #{element}"
					precise = elements[precise_site].to_i(16)
					#puts "precise | #{precise}"
					if ((lowest_precise == nil) || (precise < lowest_precise))
						lowest_precise = precise
						lowest_site = esite
						#puts "lowest-precise | #{lowest_precise}"
					end
				end
				esite += 1
			end
			if lowest_site
				element = in_wide_bar[lowest_site]
				sorted_space += [element]
			end
			#puts "lowest-precise | #{lowest_precise}"
			#puts "lowest-site | #{lowest_site}"
			#puts "sorted-space | #{sorted_space}"
			ssite += 1
		end
		#puts
		#if see_site == 1
			#break
		#end
		see_site += 1
	end
	sorted_space
end

def sort_hash_bars(space, keys)
	wide_key = keys[0]
	precise_key = keys[1]
	naof_elements = space.length
	sorted_space = []
	see_site = 0
	while true
		naof_sorted = sorted_space.length
		if naof_sorted == naof_elements
			break
		end
		#puts "sorted-space | #{sorted_space}"
		lowest_wide = nil
		esite = 0
		while true
			if esite == naof_elements
				break
			end
			element = space[esite]
			if sorted_space.index(element) == nil
				#puts "element | #{element}"
				wide = element[wide_key]
				#puts "wide | #{wide}"
				if (lowest_wide == nil) || (wide < lowest_wide)
					lowest_wide = wide
				end
			end
			esite += 1
		end
		#puts "lowest-wide | #{lowest_wide}"
		in_wide_bar = []
		esite = 0
		while true
			if esite == naof_elements
				break
			end
			element = space[esite]
			wide = element[wide_key]
			if wide == lowest_wide
				in_wide_bar += [element]
			end
			esite += 1
		end
		#puts "in-wide-bar | #{in_wide_bar}"
		naof_in_wide = in_wide_bar.length
		ssite = 0
		while true
			if ssite == naof_in_wide
				break
			end
			lowest_precise = nil
			lowest_site = nil
			esite = 0
			while true
				if esite == naof_in_wide
					break
				end
				element = in_wide_bar[esite]
				if (sorted_space.index(element) == nil)
					#puts "element | #{element}"
					precise = element[precise_key]
					#puts "precise | #{precise}"
					if ((lowest_precise == nil) || (precise < lowest_precise))
						lowest_precise = precise
						lowest_site = esite
						#puts "lowest-precise | #{lowest_precise}"
					end
				end
				esite += 1
			end
			if lowest_site
				element = in_wide_bar[lowest_site]
				sorted_space += [element]
			end
			#puts "lowest-precise | #{lowest_precise}"
			#puts "lowest-site | #{lowest_site}"
			#puts "sorted-space | #{sorted_space}"
			ssite += 1
		end
		#puts
		#if see_site == 1
			#break
		#end
		see_site += 1
	end
	sorted_space
end

def dmap(elements, key)
	map = []
	naof_elements = elements.length
	esite = 0
	while true
		if esite == naof_elements
			break
		end
		map += [elements[esite][key]]
		esite += 1
	end
	map
end

def dselect(elements, key, value)
	selected = []
	selected_register = nil
	naof_elements = elements.length
	esite = 0
	while true
		if esite == naof_elements
			break
		end
		element = elements[esite]
		if element[key] == value
			selected += [element]
		end
		esite += 1
	end
	selected
end

def reg_filter(vecter, filter)
	reg = /#{filter}/i
	filtered = []
	naof_elements = vecter.length
	site = 0
	while true
		if site == naof_elements
			break
		end
		element = vecter[site]
		if (element =~ reg) != nil
			filtered += [element]
		end
		site += 1
	end
	filtered
end

def ensure_droid_clerks
	system("./droid-com &")
	while true
		droid_procs = `ps -e | grep droid-com`
		if droid_procs == ""
			system("sleep 0.01")
		else
			break
		end
	end
	true
end

def releave_droid_clerks(symbols)
	droid_procs = `ps -e | grep droid-com`.split("\n")
	naof_droid_procs = droid_procs.length
	site = 0
	while true
		if site == naof_droid_procs
			break
		end
		pid = droid_procs[site].split(" ")[0]
		#puts "pid | #{pid}"
		system("#{symbols["close"]} -9 #{pid}")
		site += 1
	end
	true
end

def metafy_clerk(node)
	clerk_meta = eval(File::open("clerk/clerk.meta").read)
	bsb16 = clerk_meta["binary-site"].to_s(16)
	meta_node = "#{node}#{clerk_meta["binary-name"]}.#{bsb16}/"
  registers = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp"]
	naof_registers = registers.length
	manafest = manafest_at("clerk")
	naof_files = manafest["files"].length
	has_cnd = false
	site = 0
	while true
		if site == naof_files
			break
		end
		file = manafest["files"][site]
		puts "file | #{file}"
		components = file.split(".")
		if components[-1][0...6] == "relay-" && (components[-1] != "relay-site")
			if has_cnd == false
				comand = "cn #{meta_node}"
				puts "comand | #{comand}"
				system(comand)
			end
			relay_site = components[-1].split("-")[-1].to_i(16)
			file = File::open(file)
			seconds = number_aof(file.read(8).bytes.reverse)
			micro_seconds = number_aof(file.read(8).bytes.reverse)
			at = "#{seconds}.#{micro_seconds}"
			pid = number_aof(file.read(8).bytes.reverse)
			tid = number_aof(file.read(8).bytes.reverse)
			meta = {
				"binary-name" => clerk_meta["binary-name"],
				"binary-site" => bsb16,
				"relay-site" => relay_site,
				"at" => at,
				"pid" => pid,
				"tid" => tid,
				"registers" => [],
				"mm-registers" => [],
				"spaces" => {}
			}
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				register = {
					"name" => registers[rsite],
					"number" => number_aof(file.read(8).bytes.reverse),
					"map-name" => "",
					"map-site" => ""
				}
				meta["registers"] += [register]
				rsite += 1
			end
			naof_maps_secs = number_aof(file.read(8).bytes.reverse)
			maps_entree = file.read(naof_maps_secs)
			puts "maps-entree | #{maps_entree}"
			mmanafest = maps_manafest(maps_entree)
			meta["maps"] = mmanafest
			print_hash_vecter(meta["maps"])
			naof_maps = meta["maps"].length
			naof_registers = meta["registers"].length
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				register = meta["registers"][rsite]
				msite = 0
				while true
					if msite == naof_maps
						break
					end
					map = meta["maps"][msite]
					if (register["number"] >= map["origin"]) && (register["number"] < map["completion"])
						meta["registers"][rsite]["map-name"] = map["name"]
						meta["registers"][rsite]["map-site"] = (register["number"] - map["origin"])
						break
					end
					msite += 1
				end
				rsite += 1
			end
			print_hash_vecter(meta["registers"])
			msite = 0
			while true
				if msite == 0
					break
				end
				mm_secs = file.read(0x20).bytes
				entree = mm_secs.pack("c*")
				mm_register = {
					"name" => "ymm#{msite}",
					"secs" => mm_secs,
					"entree" => entree
				}
				meta["mm-registers"] += [mm_register]
				msite += 1
			end
			print_hash_vecter(meta["mm-registers"])
			file.close
			meta_file_name = "#{meta_node}#{relay_site.to_s(16)}.asm-meta"
			puts "meta-file-name | #{meta_file_name}"
			meta_file = File::open(meta_file_name, "w")
			meta_file.write(meta)
			meta_file.close
		end
		site += 1
	end
end

def clear_bin(node, types)
	sources = Dir::glob("#{node}/*")
	naof_sources = sources.length
	site = 0
	while true
		if site == naof_sources
			break
		end
		source = sources[site]
		components = source.split(".")
		type = components[-1]
		#puts "type | #{type}"
		if types.index(type)
			comand = "./ul #{source}"
			#puts "comand | #{comand}"
			system(comand)
		end
		site += 1
	end
	true
end

def log_heading(relay, bolder=false, no_early=false)
	naof_relay_secs = relay.length
	spacer = ("-" * naof_relay_secs)
	if bolder
		if no_early == false
			puts
		end
		puts "#{spacer}"
		puts "#{relay}"
		puts "#{spacer}"
		puts
	else
		puts "#{relay}"
		puts "#{spacer}"
	end
	true
end

def map_secs_to_com(in_segment_site, naof_secs, map_site, map_name)
	if map_name == "anon"
		map_name = ""
	end
	secs = (secs_aof(in_segment_site, 8).reverse + secs_aof(naof_secs, 8).reverse + secs_aof(map_site, 8).reverse + map_name.bytes)
	chart = File::open("droid/map-secs.com", "wb")
	chart.write(secs.pack("c*"))
	chart.close
	true
end

def sample_asm(bc, binary_site, meta_node, binary_name, binary_comand, conditionals_hash=nil, view_asm_at_com=false)
	comand = "./sf io.zo.9 io.do.9"
	puts "comand | #{comand}"
	system(comand)
	bc.reset_slots
	#bc.ready_binaries["io.so.9"]["slot"] = 0x1c707
	#return
	clear_bin("droid", ["files-meta", "maps-meta", "secs-meta", "try-meta"])
	bmeta = get_binary_meta(binary_name)
	naof_dynsyms = bmeta["dynsym"].length
	bsb16 = binary_site.to_s(16)
	asm = bc.get_asm(binary_name, binary_site)
	from_to = asm["from-to"]
	#from_to = asm.delete("from-to")
	print_hash_vecter([asm])
	if conditionals_hash && conditionals_hash["rs"]
		asm["rs"] = conditionals_hash["rs"]
	end
	conditional = clerical_stay_module_from(asm["alu-module"])
	sample_node = "#{meta_node}#{binary_name}-#{bsb16}/"
	for_droid_name = "#{sample_node}spaces.for-droid"
	droid_bin_name = "droid/spaces.for-droid"
	#clear_bin("droid", ["sample-meta"])
	asm_name = "#{sample_node}asm.meta"
	see_entrees = true
	if conditionals_hash
		if conditionals_hash["sample-names"] == nil
			conditionals_hash["sample-names"] = []
		end
		if (conditionals_hash["see-entrees"] != nil)
			see_entrees = conditionals_hash["see-entrees"]
		end
	end

	#sb16 = binary_site.to_s(16)
	comand = "./sequences-silent assemblies/sat-sample-init.asm secs/sat-sample-init.secs #{bc.ready_binaries[binary_name]["slot"].to_s(16)} #{conditional}"
	puts "comand | #{comand}"
	system(comand)
	comand = "./sequences-silent assemblies/sat-sample-drive.asm secs/sat-sample-drive.secs 0"
	puts "comand | #{comand}"
	system(comand)
	writes = bc.inject("secs/sat-sample-init.secs", binary_name, binary_site)
	#puts "writes | #{writes}"
	puts "binary-name | #{binary_name}"
	bc.write(binary_name, writes)

	comand = "./quad-reader #{droid_bin_name}"
	#puts "comand | #{comand}"
	system(comand)
  stay_to_modules = ["je", "callq", "jmpq", "jne", "jbe", "ja", "js", "jmp", "jb", "jle", "jge", "jg", "jns", "jo", "jae", "jl", "jp", "jrcxz", "bnd jns", "bnd jmpq", "bnd callq"]
	for_droid_name = "#{sample_node}spaces.for-droid"
	for_exists = File::exists?(for_droid_name)
	#puts "for-exists | #{for_exists}"
	dynamic_stay_to_space_name = nil
	asm["is-dynamic-stay-to"] = false
	#puts "asm | #{asm}"
	if stay_to_modules.index(asm["alu-module"]) && (asm["params"][0] == "*")
		log_heading("gs-for-dynamic-stay-to", true)
		segment_sites = sites_aof(",", asm["params"])
		#puts "segment-sites | #{segment_sites}"
		naof_segments = segment_sites.length
		if naof_segments == 0
			is_cast = asm["params"].index("(")
			register = from_to["from"]["register"][1..-1]
			constant = from_to["from"]["constant-site"]
			if constant == nil
				constant = 0
			end
			if register == "rip"
				constant = asm["destination"]
			end
			constant = constant
			if constant >= 0
				gs = "#{register}-+#{constant.to_s(16)}"
			else
				gs = "#{register}-#{constant.to_s(16)}"
			end
			if is_cast
				gs += "*"
			end
			gs += "(40)"
			#puts "gs | #{gs}"
			to_droid_spaces(gs)
			if for_exists
				comand = "./merge #{for_droid_name} #{droid_bin_name} #{droid_bin_name}"
				#puts "comand | #{comand}"
				system(comand)
			end
			comand = "./sf #{droid_bin_name} #{for_droid_name}"
			#puts "comand | #{comand}"
			system(comand)
			dynamic_stay_to_space_name = droid_space_sources()[-1]
			asm["is-dynamic-stay-to"] = dynamic_stay_to_space_name
		end
	end
=begin
=end

	comand = "cn #{sample_node}"
	#puts "comand | #{comand}"
	system(comand)
	comand = binary_comand
	log_heading(comand, true)
	#puts "comand | #{comand}"
	system(comand)
	#status = $?.success? : true : false
	conditionals_hash["stay-status"] = $?

	current_sources = Dir::entries(sample_node)
	naof_currents = current_sources.length
	current_metas = []
	#puts "current-metas"
	csite = 0
	while true
		if csite == naof_currents
			break
		end
		source = current_sources[csite]
		#puts "source | #{source}"
		components = source.split(".")
		if components[-1] == "sample-meta"
			current_metas += [source]
		end
		csite += 1
	end
	naof_currents = current_metas.length
	current_metas = current_metas.sort do |a,b|
		componentsa = a.split(".")
		timea = "#{componentsa[1].to_i(16)}.#{componentsa[2].to_i(16)}".to_f
		componentsb = b.split(".")
		timeb = "#{componentsb[1].to_i(16)}.#{componentsb[2].to_i(16)}".to_f
		timea <=> timeb
	end
	conditionals = []
	gnu_registers = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp"]
	naof_registers = gnu_registers.length
	sources = Dir::glob("droid/*")
	naof_sources = sources.length
	#puts "naof-sources | #{naof_sources}"
	et_site = naof_sources - 1
	least_naof_sequences = nil
	naof_samples = 0
	asm_metas = []
	map_secs_sources = []
	sample_sources = []
	site = 0
	while true
		if site == naof_sources
			break
		end
		source = sources[site]
		components = source.split(".")
		type = components[-1]
		#puts "type | #{type}"
		if type == "secs-meta"
			sample_name = simple_stead(components)
			sample_name[-1] = "sample-meta"
			sample_name = sample_name.join(".")
			sample_name = "#{sample_node}#{sample_name.split("/")[1..-1].join("/")}"
			#puts "sample-name | #{sample_name}"
			#puts "current-metas | #{current_metas}"
			sampled_spaces = {}
			if current_metas[naof_samples]
				sample = eval(File::open("#{sample_node}#{current_metas[naof_samples]}").read)
				sampled_spaces = sample["spaces"]
			end
			if site != et_site
				puts
			end
			files_name = simple_stead(components)
			files_name[-1] = "files-meta"
			files_name = files_name.join(".")
			files_meta = []
			files = File::open(files_name).read.split("\n")
			naof_files = files.length / 2
			fsite = 0
			while true
				if fsite == naof_files
					break
				end
				ssite = fsite * 2
				link = files[ssite].to_i
				name = files[(ssite + 1)]
				files_meta += [{
					"link" => link,
					"name" => name
				}]
				fsite += 1
			end
			#print_hash_vecter(files_meta)
			#log_heading(source)
			#puts "meta-to-parse | #{source}"
			secs_file = File::open(source)
			meta = {
				"pid" => components[0].to_i(16),
				"naof-seconds" => components[1].to_i(16),
				"naof-micro-seconds" => components[2].to_i(16),
				"naof-wide-sequences" => components[3].to_i(16),
				"naof-precise-sequences" => components[4].to_i(16),
				"registers" => [],
				"spaces" => sampled_spaces,
				"space-stack-sites" => {},
				"files" => files_meta
			}
			#zero_stay = number_aof(secs_file.read(8).bytes.reverse)
			#meta["zero-stay"] = zero_stay
			maps_name = simple_stead(components)
			maps_name[-1] = "maps-meta"
			maps_name = maps_name.join(".")
			maps = maps_manafest(File::open(maps_name).read)
			naof_maps = maps.length
			meta["maps"] = maps
			sequences_index = "#{meta["naof-wide-sequences"]}.#{meta["naof-precise-sequences"]}".to_f
			if (least_naof_sequences == nil) || (sequences_index < least_naof_sequences)
				least_naof_sequences = sequences_index
			end
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				secs = secs_file.read(8).bytes
				#puts "secs | #{secs}"
				quad = number_aof(secs.reverse)
				register = {
					"name" => gnu_registers[rsite],
					"quad" => quad,
					"segment" => "",
					"segment-site" => "",
					"link" => ""
				}
				msite = 0
				while true
					if msite == naof_maps
						msite = nil
						break
					end
					map = maps[msite]
					if (quad >= map["origin"]) && (quad < map["completion"])
						register["segment"] = map["name"]
						segment_site = quad - map["origin"]
						register["segment-site"] = segment_site
						#puts "map | #{map}"
						break
					end
					msite += 1
				end
				if msite
					#puts "msite | #{msite}"
					#puts "map | #{maps[msite]}"
					#print_hash_vecter(maps)
					sampler_maps = ["sat-sample-drive.secs", "equations-no-mm.secs", "core.rack", "sat-drive.secs"]
					naof_sampler_maps = sampler_maps.length
					rmap_name = maps[msite]["name"].split(" - ")[0]
					while true
						map = maps[msite]
						name = map["name"]
						#puts "name | #{name}"
						components = name.split(" - ")
						name = components[0]
						access = components[1]
						if access == "r-xp"
							is_in_sampler_maps = false
							msite2 = 0
							while true
								if msite2 == naof_sampler_maps
									break
								end
								smn = sampler_maps[msite2] # sampler-map-name
								#puts "smn | #{smn}"
								if name.index(smn) != nil
									is_in_sampler_maps = true
								end
								msite2 += 1
							end
							if is_in_sampler_maps == false
								register["fz-site"] = register["quad"] - map["origin"]
								break
							end
						end
						if register["fz-site"]
							break
						end
						if msite == 0
							break
						end
						msite -= 1
					end
				end
				if register["fz-site"]
					dsite = 0
					while true
						if dsite == naof_dynsyms
							break
						end
						dynsym = bmeta["dynsym"][dsite]
						completion = dynsym["stay-site"] + dynsym["naof-secs"].to_i
						if (register["fz-site"] >= dynsym["stay-site"]) && (register["fz-site"] < completion)
							register["dynsym-segment"] = dynsym["source"]
							register["dynsym-site"] = register["fz-site"] - dynsym["stay-site"]
						end
						dsite += 1
					end
				end
				fsite = 0
				while true
					if fsite == naof_files
						break
					end
					file_meta = files_meta[fsite]
					if (quad == file_meta["link"])
						register["link"] = file_meta["name"]
					end
					fsite += 1
				end
				meta["registers"] += [register]
				rsite += 1
			end
			#log_heading("registers")
			#print_hash_vecter(meta["registers"])
			quad_secs = secs_file.read(8)
			naof_quad_secs = quad_secs.length
			if naof_quad_secs == 8
				quad = number_aof(quad_secs.bytes.reverse)
				rack_map = droid_select(meta["maps"], "name", "[rack] - dynamic")
				if rack_map
					meta["base-rack-site"] = quad - rack_map["origin"]
				end
			end
			has_breifed = false
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				secs = secs_file.read(8).bytes
				quad = number_aof(secs.reverse)
				#puts "quad | #{quad}"
				if quad == 64
					space = {
						"name" => gnu_registers[rsite],
						"secs" => secs_file.read(0x40).bytes
					}
					meta["spaces"][space["name"]] = (space["secs"])
					if has_breifed == false
						log_heading("register-spaces")
						has_breifed = true
					end
					#puts "#{space["name"]} | #{space["secs"]}"
				end
				rsite += 1
			end
			tell = secs_file.tell
			#puts "at-condtional | #{secs_file.read.bytes}"
			secs_file.seek(tell)
			secs = secs_file.read(8).bytes
			quad = number_aof(secs.reverse)
			meta["is-conditional"] = (quad == 0xaed)
			space_sources = droid_space_sources
			#puts "space-sources | #{space_sources}"
			ssite = 0
			while true
				secs = secs_file.read(8)
				if secs == nil
					break
				end
				quad = number_aof(secs.bytes.reverse)
				#puts "quad | #{quad}"
				if quad != 0xffffffffffffffff
					stack_site = secs_file.read(8)
					stack_site = number_aof(stack_site.bytes.reverse)
					secs = secs_file.read(quad).bytes
					#puts "secs | #{secs}"
					space_source = space_sources[ssite]
					#puts "space-source | #{space_source}"
					meta["spaces"][space_source] = (secs)
					ss = stack_site
					stack_site = {
						"stack-site" => stack_site,
						"segment" => nil,
						"segment-site" => nil
					}
					msite = 0
					while true
						if msite == naof_maps
							break
						end
						map = meta["maps"][msite]
						#puts "map | #{map}"
						if (ss >= map["origin"]) && (ss < map["completion"])
							stack_site["segment"] = map["name"]
							stack_site["segment-site"] = (ss - map["origin"])
						end
						msite += 1
					end
					meta["space-stack-sites"][space_source] = stack_site
				end
				ssite += 1
			end
			#puts "is-conditional | #{meta["is-conditional"]}"
			#puts "meta | #{meta}"
			#puts "sample-name | #{sample_name}"
			meta["sample-name"] = sample_name
			chart = File::open(sample_name, "w")
			chart.write(meta)
			chart.close
			sample_sources += [sample_name]
			asm_metas += [meta]
			naof_samples += 1
			#print_asm(meta)
		elsif type == "map-secs"
			components = source.split(".")
			if components[-2]
				components[-2] = "anonomous"
			end
			map_secs_name = "#{sample_node}#{source.split("/")[1..-1].join("/")}"
			comand = "sf #{source} #{map_secs_name}"
			#puts "comand | #{comand}"
			system(comand)
			map_secs_sources += [map_secs_name]
		end
		site += 1
	end
	if dynamic_stay_to_space_name && (naof_samples > 0)
		meta = asm_metas[0]
		space = meta["space-stack-sites"][dynamic_stay_to_space_name]
		#puts "space | #{space}"
		if space
			stay_to = nil
			if space["segment"]
				stay_to = space["segment"].split(" - ")
				stay_to = ([stay_to[0].split("/")[-1]] + [space["segment-site"].to_s(16)])
				stay_to = stay_to.join("-")
			else
				stay_to = space["stack-site"].to_s(16)
			end
			puts "stay-to | #{stay_to}"
			asm["stay-to"] = stay_to
			asm["stay-to-site"] = space["segment-site"]
		end
	end
	asm_metas = asm_metas.sort do |a,b|
		#puts "i-sim."
		#puts "a | #{a}"
		#puts "b | #{b}"
		time_a = "#{a["naof-seconds"]}.#{a["naof-micro-seconds"]}".to_f
		time_b = "#{b["naof-seconds"]}.#{b["naof-micro-seconds"]}".to_f
		#puts "#{time_a} | #{time_b}"
		time_a <=> time_b
	end
	sample_sources = sample_sources.sort do |a,b|
		a_components = a.split("/")[-1].split(".")
		a_time = "#{a_components[1].to_i(16)}.#{a_components[2].to_i(16)}".to_f
		b_components = b.split("/")[-1].split(".")
		b_time = "#{b_components[1].to_i(16)}.#{b_components[2].to_i(16)}".to_f
		a_time <=> b_time
	end
	if conditionals_hash
		conditionals_hash["sample-names"] = sample_sources
	end
	site = 0
	while true
		if site == naof_samples
			break
		end
		conditionals += [asm_metas[site]["is-conditional"]]
		site += 1
	end
	site = 0
	if (conditionals_hash && conditionals_hash["see-site"])
		site = conditionals_hash["see-site"]
	end
	while true
		if site == naof_samples
			break
		end
		if asm_metas[site]
			print_asm(asm_metas[site], see_entrees)
		end
		if (conditionals_hash && conditionals_hash["see-site"])
			break
		end
		site += 1
	end
	map_secs_sources = map_secs_sources.sort do |a,b|
		components1 = a.split("/")[-1].split(".")
		time1 = components1[1].to_i(16) + "0.#{components1[2].to_i(16)}".to_f
		components2 = b.split("/")[-1].split(".")
		time2 = components2[1].to_i(16) + "0.#{components2[2].to_i(16)}".to_f
		time1 <=> time2
	end
	#puts "least-naof-sequences | #{least_naof_sequences}"
	if conditionals_hash
		conditionals_hash["conditionals"] = conditionals
		conditionals_hash["asm"] = asm
	end
	csite = 0
	while true
		if csite == naof_currents
			break
		end
		source = current_metas[csite]
		comand = "./ul #{sample_node}#{source}"
		#puts "comand | #{comand}"
		system(comand)
		csite += 1
	end
	#puts "asm-name | #{asm_name}"
	#puts "naof-samples | #{naof_samples}"
	if (naof_samples > 0)
		unlink_file(asm_name)
		puts "asm | #{asm}"
		chart = File::open(asm_name, "w")
		#puts "chart-is-open | #{chart.closed? ? false : true}"
		chart.write(asm)
		chart.close
	else
		comand = "./rn #{sample_node}"
		puts "comand | #{comand}"
		system(comand)
	end
	#puts "naof-samples | #{naof_samples.to_s(16)}"
	#puts "sample-sources | #{sample_sources}"
	#puts "map-secs-sources | #{map_secs_sources}"
	#puts "meta-node | #{meta_node}"
	#puts "sample-node | #{sample_node}"
	if view_asm_at_com
		print_hash_vecter([asm])
	end
	return true
end

def print_asm(meta, see_entrees=true)
	meta_keys = ["pid", "naof-seconds", "naof-micro-seconds", "naof-wide-sequences", "naof-precise-sequences", "sample-name", "zero-stay"]
	naof_meta_keys = meta_keys.length
	header = {}
	site = 0
	while true
		if site == naof_meta_keys
			break
		end
		key = meta_keys[site]
		header[key] = meta[key]
		site += 1
	end
	puts
	log_heading("meta")
	print_hash(header)
	puts
	log_heading("registers")
	print_hash_vecter(meta["registers"])
	if meta["base-rack-site"]
		puts "base-rack-site | #{meta["base-rack-site"].to_s(16)}"
	end
	puts
	space_names = meta["spaces"].keys
	naof_spaces = space_names.length
	site = 0
	while true
		if site == naof_spaces
			break
		end
		space_name = space_names[site]
		space = meta["spaces"][space_name]
		#puts "space | #{space}"
		stack_site = meta["space-stack-sites"][space_name]
		if stack_site
			print_hash_vecter([stack_site])
		end
		puts "#{space_name} | #{space}"
		if see_entrees
			entree = space.pack("c*").gsub("\x00", " | ")
			puts "entree | #{entree}"
		end
		puts
		site += 1
	end
	puts
	log_heading("maps")
	print_hash_vecter(meta["maps"])
	log_heading("is-conditional")
	puts "is-conditional | #{meta["is-conditional"]}"
	puts
end

def stead_register64_name(register_name)
	register_name = register_name[1..-1]
	register_names = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp"]
	sec_register_names = ["r8b", "r9b", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b", "al", "bl", "cl", "dl", "dil", "sil", "spl", "bpl"]
	dyno_register_names = ["r8w", "r9w", "r10w", "r11w", "r12w", "r13w", "r14w", "r15w", "ax", "bx", "cx", "dx", "di", "si", "sp", "bp"]
	word_register_names = ["r8d", "r9d", "r10d", "r11d", "r12d", "r13d", "r14d", "r15d", "eax", "ebx", "ecx", "edx", "edi", "esi", "esp", "ebp"]
	sec_site = sec_register_names.index(register_name)
	if sec_site
		register_name = register_names[sec_site]
	end
	dyno_site = dyno_register_names.index(register_name)
	if dyno_site
		register_name = register_names[dyno_site]
	end
	word_site = word_register_names.index(register_name)
	if word_site
		register_name = register_names[word_site]
	end
	register_name
end

def stead_stack_site(stack_site, sample)
	sss = {
		"stack-site" => stack_site,
		"binary" => nil,
		"fz-site" => nil
	} # sss | stead-stack-site
	naof_maps = sample["maps"].length
	msite = 0
	while true
		if msite == naof_maps
			msite = nil
			break
		end
		map = sample["maps"][msite]
		if stack_site >= map["origin"] && stack_site < map["completion"]
			break
		end
		msite += 1
	end
	if msite
		map = sample["maps"][msite]
		sss["segment"] = map["name"].split(" - ")[0...2].join(" - ")
		sss["segment-site"] = sss["stack-site"] - map["origin"]
		map = nil
		while true
			map = sample["maps"][msite]
			access = map["name"].split(" - ")[1]
			if access == "r-xp"
				break
			end
			if msite == 0
				map == nil
				break
			end
			msite -= 1
		end
		if map
			sss["binary"] = map["name"].split(" - ")[0] # in mights of say
			sss["fz-site"] = sss["stack-site"] - map["origin"]
		end
	end
	sss
end

def fz_sites_for_from_to(asm, sample)
	mms = ["x", "y", "z"]
	fz_site_ffts = []
	categories = ["from", "to"]
	naof_categories = 2
	csite = 0
	while true
		if csite == naof_categories
			break
		end
		category = categories[csite]
		if asm["from-to"] && asm["from-to"][category] && asm["from-to"][category]["register"] && mms.index(asm["from-to"][category]["register"][1]) == nil
			register = dselect(sample["registers"], "name", stead_register64_name(asm["from-to"][category]["register"]))[0]
			if register
				#puts "register | #{register}"
				stack_site = register["quad"]
				if asm["from-to"][category]["constant-site"]
					stack_site += asm["from-to"][category]["constant-site"]
				end
				if asm["from-to"][category]["naof-register"]
					naof_secs_register = dselect(sample["registers"], "name", stead_register64_name(asm["from-to"][category]["naof-register"]))[0]
					#puts "naof-secs-register | #{naof_secs_register}"
					naof_secs = asm["from-to"][category]["naof-secs"].to_i
					#puts "naof-secs | #{naof_secs}"
					stack_site += naof_secs_register["quad"] * naof_secs
				end
				sss = stead_stack_site(stack_site, sample)
				#casm = asm.clone
				fz_site_fft = {
					"binary-site" => asm["binary-site"],
					"alu-module" => asm["alu-module"],
					"params" => asm["params"],
					"category" => category,
					"stack-site" => stack_site,
					"segment" => sss["segment"],
					"segment-site" => sss["segment-site"],
					"binary" => sss["binary"],
					"fz-site" => sss["fz-site"]
				}
				fz_site_ffts += [fz_site_fft]
			end
		end
		csite += 1
	end
	fz_site_ffts
end

def clerically_assemify(bc, meta_node, binary_name, binary_site)
	if meta_node[-1] != "/"
		meta_node += "/"
	end
	bsb16 = binary_site.to_s(16)
	sample_node = "#{meta_node}#{binary_name}-#{bsb16}/"
	asm_name = "#{sample_node}asm.meta"
	comand = "cn #{sample_node}"
	system(comand)
	bmeta = get_binary_meta(binary_name)
	naof_dynsyms = bmeta["dynsym"].length
	asm = bc.get_asm(binary_name, binary_site)

	current_sources = Dir::entries(sample_node)
	naof_currents = current_sources.length
	current_metas = []
	#puts "current-metas"
	csite = 0
	while true
		if csite == naof_currents
			break
		end
		source = current_sources[csite]
		#puts "source | #{source}"
		components = source.split(".")
		if components[-1] == "sample-meta"
			current_metas += [source]
		end
		csite += 1
	end
	naof_currents = current_metas.length
	current_metas = current_metas.sort do |a,b|
		componentsa = a.split(".")
		timea = "#{componentsa[1].to_i(16)}.#{componentsa[2].to_i(16)}".to_f
		componentsb = b.split(".")
		timeb = "#{componentsb[1].to_i(16)}.#{componentsb[2].to_i(16)}".to_f
		timea <=> timeb
	end
	gnu_registers = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp"]
	naof_registers = gnu_registers.length
	sources = Dir::entries("droid")
	naof_sources = sources.length
	#puts "naof-sources | #{naof_sources}"
	et_site = naof_sources - 1
	least_naof_sequences = nil
	naof_samples = 0
	asm_metas = []
	map_secs_sources = []
	sample_sources = []
	site = 0
	while true
		if site == naof_sources
			break
		end
		source = sources[site]
		source = "droid/#{source}"
		components = source.split(".")
		type = components[-1]
		#puts "type | #{type}"
		if type == "secs-meta"
			sample_name = simple_stead(components)
			sample_name[-1] = "sample-meta"
			sample_name = sample_name.join(".")
			sample_name = "#{sample_node}#{sample_name.split("/")[1..-1].join("/")}"
			puts "sample-name | #{sample_name}"
			puts "current-metas | #{current_metas}"
			sampled_spaces = {}
			if current_metas[naof_samples]
				sample = eval(File::open("#{sample_node}#{current_metas[naof_samples]}").read)
				sampled_spaces = sample["spaces"]
			end
			if site != et_site
				puts
			end
			files_name = simple_stead(components)
			files_name[-1] = "files-meta"
			files_name = files_name.join(".")
			files_meta = []
			files = File::open(files_name).read.split("\n")
			naof_files = files.length / 2
			fsite = 0
			while true
				if fsite == naof_files
					break
				end
				ssite = fsite * 2
				link = files[ssite].to_i
				name = files[(ssite + 1)]
				files_meta += [{
					"link" => link,
					"name" => name
				}]
				fsite += 1
			end
			#print_hash_vecter(files_meta)
			#log_heading(source)
			#puts "meta-to-parse | #{source}"
			secs_file = File::open(source)
			meta = {
				"pid" => components[0].to_i(16),
				"naof-seconds" => components[1].to_i(16),
				"naof-micro-seconds" => components[2].to_i(16),
				"naof-wide-sequences" => components[3].to_i(16),
				"naof-precise-sequences" => components[4].to_i(16),
				"registers" => [],
				"spaces" => sampled_spaces,
				"space-stack-sites" => {},
				"files" => files_meta
			}
			#zero_stay = number_aof(secs_file.read(8).bytes.reverse)
			#meta["zero-stay"] = zero_stay
			maps_name = simple_stead(components)
			maps_name[-1] = "maps-meta"
			maps_name = maps_name.join(".")
			maps = maps_manafest(File::open(maps_name).read)
			naof_maps = maps.length
			meta["maps"] = maps
			sequences_index = "#{meta["naof-wide-sequences"]}.#{meta["naof-precise-sequences"]}".to_f
			if (least_naof_sequences == nil) || (sequences_index < least_naof_sequences)
				least_naof_sequences = sequences_index
			end
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				secs = secs_file.read(8).bytes
				#puts "secs | #{secs}"
				quad = number_aof(secs.reverse)
				register = {
					"name" => gnu_registers[rsite],
					"quad" => quad,
					"segment" => "",
					"segment-site" => "",
					"link" => ""
				}
				msite = 0
				while true
					if msite == naof_maps
						msite = nil
						break
					end
					map = maps[msite]
					if (quad >= map["origin"]) && (quad < map["completion"])
						register["segment"] = map["name"]
						segment_site = quad - map["origin"]
						register["segment-site"] = segment_site
						#puts "map | #{map}"
						break
					end
					msite += 1
				end
				if msite
					#puts "msite | #{msite}"
					#puts "map | #{maps[msite]}"
					#print_hash_vecter(maps)
					sampler_maps = ["sat-sample-drive.secs", "equations-no-mm.secs", "core.rack", "sat-drive.secs"]
					naof_sampler_maps = sampler_maps.length
					rmap_name = maps[msite]["name"].split(" - ")[0]
					while true
						map = maps[msite]
						name = map["name"]
						#puts "name | #{name}"
						components = name.split(" - ")
						name = components[0]
						access = components[1]
						if access == "r-xp"
							is_in_sampler_maps = false
							msite2 = 0
							while true
								if msite2 == naof_sampler_maps
									break
								end
								smn = sampler_maps[msite2] # sampler-map-name
								#puts "smn | #{smn}"
								if name.index(smn) != nil
									is_in_sampler_maps = true
								end
								msite2 += 1
							end
							if is_in_sampler_maps == false
								register["fz-site"] = register["quad"] - map["origin"]
								break
							end
						end
						if register["fz-site"]
							break
						end
						if msite == 0
							break
						end
						msite -= 1
					end
				end
				if register["fz-site"]
					dsite = 0
					while true
						if dsite == naof_dynsyms
							break
						end
						dynsym = bmeta["dynsym"][dsite]
						completion = dynsym["stay-site"] + dynsym["naof-secs"].to_i
						if (register["fz-site"] >= dynsym["stay-site"]) && (register["fz-site"] < completion)
							register["dynsym-segment"] = dynsym["source"]
							register["dynsym-site"] = register["fz-site"] - dynsym["stay-site"]
						end
						dsite += 1
					end
				end
				fsite = 0
				while true
					if fsite == naof_files
						break
					end
					file_meta = files_meta[fsite]
					if (quad == file_meta["link"])
						register["link"] = file_meta["name"]
					end
					fsite += 1
				end
				meta["registers"] += [register]
				rsite += 1
			end
			#log_heading("registers")
			#print_hash_vecter(meta["registers"])
			quad_secs = secs_file.read(8)
			naof_quad_secs = quad_secs.length
			if naof_quad_secs == 8
				quad = number_aof(quad_secs.bytes.reverse)
				rack_map = droid_select(meta["maps"], "name", "[rack] - dynamic")
				if rack_map
					meta["base-rack-site"] = quad - rack_map["origin"]
				end
			end
			has_breifed = false
			rsite = 0
			while true
				if rsite == naof_registers
					break
				end
				secs = secs_file.read(8).bytes
				quad = number_aof(secs.reverse)
				#puts "quad | #{quad}"
				if quad == 64
					space = {
						"name" => gnu_registers[rsite],
						"secs" => secs_file.read(0x40).bytes
					}
					meta["spaces"][space["name"]] = (space["secs"])
					if has_breifed == false
						#log_heading("register-spaces")
						has_breifed = true
					end
					#puts "#{space["name"]} | #{space["secs"]}"
				end
				rsite += 1
			end
			tell = secs_file.tell
			puts "at-condtional | #{secs_file.read.bytes}"
			secs_file.seek(tell)
			secs = secs_file.read(8).bytes
			quad = number_aof(secs.reverse)
			meta["is-conditional"] = (quad == 0xaed)
			space_sources = droid_space_sources
			puts "space-sources | #{space_sources}"
			ssite = 0
			while true
				secs = secs_file.read(8)
				if secs == nil
					break
				end
				quad = number_aof(secs.bytes.reverse)
				puts "quad | #{quad}"
				if quad != 0xffffffffffffffff
					stack_site = secs_file.read(8)
					stack_site = number_aof(stack_site.bytes.reverse)
					secs = secs_file.read(quad).bytes
					puts "secs | #{secs}"
					space_source = space_sources[ssite]
					puts "space-source | #{space_source}"
					meta["spaces"][space_source] = (secs)
					ss = stack_site
					stack_site = {
						"stack-site" => stack_site,
						"segment" => nil,
						"segment-site" => nil
					}
					msite = 0
					while true
						if msite == naof_maps
							break
						end
						map = meta["maps"][msite]
						#puts "map | #{map}"
						if (ss >= map["origin"]) && (ss < map["completion"])
							stack_site["segment"] = map["name"]
							stack_site["segment-site"] = (ss - map["origin"])
						end
						msite += 1
					end
					meta["space-stack-sites"][space_source] = stack_site
				end
				ssite += 1
			end
			#puts "is-conditional | #{meta["is-conditional"]}"
			#puts "meta | #{meta}"
			puts "sample-name | #{sample_name}"
			meta["sample-name"] = sample_name
			chart = File::open(sample_name, "w")
			chart.write(meta)
			chart.close
			sample_sources += [sample_name]
			asm_metas += [meta]
			naof_samples += 1
			#print_asm(meta)
		elsif type == "map-secs"
			components = source.split(".")
			if components[-2]
				components[-2] = "anonomous"
			end
			map_secs_name = "#{sample_node}#{source.split("/")[1..-1].join("/")}"
			comand = "sf #{source} #{map_secs_name}"
			puts "comand | #{comand}"
			system(comand)
			map_secs_sources += [map_secs_name]
		end
		site += 1
	end
	asm_metas = asm_metas.sort do |a,b|
		#puts "i-sim."
		#puts "a | #{a}"
		#puts "b | #{b}"
		time_a = "#{a["naof-seconds"]}.#{a["naof-micro-seconds"]}".to_f
		time_b = "#{b["naof-seconds"]}.#{b["naof-micro-seconds"]}".to_f
		#puts "#{time_a} | #{time_b}"
		time_a <=> time_b
	end
	sample_sources = sample_sources.sort do |a,b|
		a_components = a.split("/")[-1].split(".")
		a_time = "#{a_components[1].to_i(16)}.#{a_components[2].to_i(16)}".to_f
		b_components = b.split("/")[-1].split(".")
		b_time = "#{b_components[1].to_i(16)}.#{b_components[2].to_i(16)}".to_f
		a_time <=> b_time
	end
	map_secs_sources = map_secs_sources.sort do |a,b|
		components1 = a.split("/")[-1].split(".")
		time1 = components1[1].to_i(16) + "0.#{components1[2].to_i(16)}".to_f
		components2 = b.split("/")[-1].split(".")
		time2 = components2[1].to_i(16) + "0.#{components2[2].to_i(16)}".to_f
		time1 <=> time2
	end
	#puts "least-naof-sequences | #{least_naof_sequences}"
	csite = 0
	while true
		if csite == naof_currents
			break
		end
		source = current_metas[csite]
		comand = "./ul #{sample_node}#{source}"
		#puts "comand | #{comand}"
		system(comand)
		csite += 1
	end
	puts "asm-name | #{asm_name}"
	puts "naof-samples | #{naof_samples}"
	if (naof_samples > 0)
		unlink_file(asm_name)
		puts "asm | #{asm}"
		chart = File::open(asm_name, "w")
		#puts "chart-is-open | #{chart.closed? ? false : true}"
		chart.write(asm)
		chart.close
	else
		comand = "./rn #{sample_node}"
		puts "comand | #{comand}"
		system(comand)
	end
	puts "naof-samples | #{naof_samples.to_s(16)}"
	puts "sample-sources | #{sample_sources}"
	puts "map-secs-sources | #{map_secs_sources}"
	puts "meta-node | #{meta_node}"
	puts "sample-node | #{sample_node}"
	return true
end

def droid_space_sources
  registers = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp", "rip"]
	for_droid = "droid/spaces.for-droid"
	if File::exists?(for_droid) == false
		return []
	end
	task_chart = File::open(for_droid)
	sources = []
	source = []
	mode = 0
	while true
		quad = task_chart.read(8)
		if quad == nil
			break
		end
		quad1 = number_aof(quad.bytes.reverse)
		quad2 = number_aof(task_chart.read(8).bytes.reverse)
		quad3 = number_aof(task_chart.read(8).bytes.reverse)
		quad4 = number_aof(task_chart.read(8).bytes.reverse)
		quad5 = number_aof(task_chart.read(8).bytes.reverse)
		component = nil
		if mode == 0
			if quad1 == 1
				component = ("rip")
			else
				component = registers[(quad3 / 8)]
			end
			mode = 1
		elsif mode == 1
			component = ""
			if quad2 == 0
				component += "-"
			else
				component += "+"
			end
			siteb16 = quad3.to_s(16)
			component += siteb16
			if quad4 == 1
				component += "*"
			end
		end
		if quad5 != 0xffffffffffffffff
			naof_secs_b16 = quad5.to_s(16)
			component += ("(#{naof_secs_b16})")
			#if component != nil
				source += [component]
				sources += [source.join("-")]
				source = []
			#end
			mode = 0
		else
			source += [component]
		end
	end
	sources
end

# rax-+aed*-+aedaed(100)
# 1|40|1|ffffffffffffffff|1|aed|1|ffffffffffffffff|1|aedaed|0|100
def to_droid_spaces(dsl)
  registers = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp", "rip"]
	for_droid = "droid/spaces.for-droid"
	micro_name = "droid/micro.quad"
	comand = "ul #{for_droid}"
	puts "comand | #{comand}"
	system(comand)
	is_from = nil
	quads = []
	dsl = dsl.gsub("--", "-#")
	components = dsl.split("-")
	naof_components = components.length
	site = 0
	while true
		if site == naof_components
			break
		end
		component = components[site]
		#puts "component | #{component}"
		if site == 0
			if component == "rip"
				is_from = "1"
			else
				is_from = "0"
			end
			quads += [is_from]
			quads += ["1"]
			if is_from == "0"
				rsite = registers.index(component)
				quads += [(8 * rsite).to_s(16)]
			else
				quads += ["0"]
			end
			#puts "is-from | #{is_from}"
			if is_from == "1"
				quads += ["0"]
			else
				quads += ["1"]
			end
			#puts "quads | #{quads}"
			quads += ["ffffffffffffffff"]
		else
			quads += [is_from]
			if component[0] == "+"
				quads += ["1"]
			elsif component[0] == "#"
				quads += ["0"]
			end
			component = component[1..-1]
			naof_secs = "ffffffffffffffff"
			naof_secs_site = component.index("(")
			if naof_secs_site
				naof_secs = component[(naof_secs_site + 1)..-2]
				component = component[0...naof_secs_site]
			end
			is_cast = "0"
			if component[-1] == "*"
				is_cast = "1"
				component = component[0..-2]
			end
			quads += [component]
			quads += [is_cast]
			quads += [naof_secs]
		end
		site += 1
	end
	puts "quads | #{quads}"
	naof_quads = quads.length
	completion = naof_quads * 8
	dsite = 0
	site = 0
	while true
		if dsite == completion
			break
		end
		quadb16 = quads[site]
		comand = "./write-quad #{micro_name} #{quadb16}"
		puts "comand | #{comand}"
		system(comand)
		psb16 = dsite.to_s(16)
		comand = "./place-sites #{micro_name} 0 8 #{for_droid} #{psb16}"
		puts "comand | #{comand}"
		system(comand)
		site += 1
		dsite += 8
	end
	comand = "ul droid/micro.quad"
end

def save_maps(meta_source, source)
	meta = eval(File::open(meta_source).read)
	maps = meta["maps"]
	maps_source = meta_source.split(".")
	maps_source[-1] = "maps-meta"
	maps_source = (maps_source[0...-1] + [source] + [maps_source[-1]])
	maps_source = maps_source.join(".")
	puts "maps-source | #{maps_source}"
	chart = File::open(maps_source, "w")
	chart.write(maps)
	chart.close
	true
end

def map_quads_sheat(space, maps, filter_zeros=false)
	naof_secs = space.length
	naof_quads = naof_secs / 8
	naof_maps = maps.length
	quad_sheat = []
	last_qsite = nil
	qsite = 0
	while true
		if qsite == naof_quads
			break
		end
		site = qsite * 8
		quad_secs = space[site...(site + 8)]
		#puts "quad-secs | #{quad_secs}"
		naof_quad_secs = quad_secs.length
		if naof_quad_secs != 8
			break
		end
		quad = number_aof(quad_secs.reverse)
		if (filter_zeros == false) || (quad != 0)
			sheat_quad = {
				"q-site" => site,
				"quad" => quad,
				"segment" => nil,
				"segment-site" => nil,
				"entree" => quad_secs.pack("c*").gsub("\n", "|")
			}
			msite = 0
			while true
				if msite == naof_maps
					break
				end
				map = maps[msite]
				if (quad >= map["origin"]) && (quad < map["completion"])
					sheat_quad["segment"] = map["name"]
					sheat_quad["segment-site"] = (quad - map["origin"])
					break
				end
				msite += 1
			end
			if (last_qsite != nil) && (last_qsite != (qsite - 1))
				segment_sheat_quad = {
					"q-site" => "-----",
					"quad" => "-----",
					"segment" => "-----",
					"segment-site" => "-----",
					"entree" => "-----"
				}
				quad_sheat += [segment_sheat_quad]
			end
			last_qsite = qsite
			quad_sheat += [sheat_quad]
		end
		qsite += 1
	end
	quad_sheat
end

def map_quads_sheat_ultra(space, maps, filter_zeros=false)
	naof_secs = space.length
	naof_quads = naof_secs / 8
	naof_maps = maps.length
	#quad_sheat = []
	qsite = 0
	while true
		if qsite == naof_quads
			break
		end
		site = qsite * 8
		quad_secs = space[site...(site + 8)]
		naof_quad_secs = quad_secs.length
		if naof_quad_secs != 8
			break
		end
		quad = number_aof(quad_secs.reverse)
		if (filter_zeros == false) || (quad != 0)
			sheat_quad = {
				"q-site" => qsite,
				"quad" => quad,
				"segment" => nil,
				"segment-site" => nil,
				"entree" => quad_secs.pack("c*")
			}
			msite = 0
			while true
				if msite == naof_maps
					break
				end
				map = maps[msite]
				if (quad >= map["origin"]) && (quad < map["completion"])
					sheat_quad["segment"] = map["name"]
					sheat_quad["segment-site"] = (quad - map["origin"])
					break
				end
				msite += 1
			end
			#quad_sheat += [sheat_quad]
			print_hash_vecter([sheat_quad])
		end
		qsite += 1
	end
	#quad_sheat
end

# todo | if ambiguity see if clarity is possible with space quads compair
class ThreadClerk
	def sequence_site
		@sequence_site
	end
	def initialize(origin_site)
		@sample_site = origin_site
		@back_sample = nil
		@naof_sample = nil
	end

	def same_facter(sample)
		#log_heading("same-facter", true)
		naof_registers = sample["registers"].length
		naof_rack_sites = 0
		naof_same = 0
		rsite = 0
		while true
			if rsite == naof_registers
				break
			end
			back_register = @back_sample["registers"][rsite]
			register = sample["registers"][rsite]
			#print_hash_vecter([back_register, register])
			if register["segment"] != "" && register["segment"] && back_register["segment"]
				if register["segment"] == back_register["segment"] && register["segment-site"] == back_register["segment-site"]
					#puts "segment-same"
					naof_same += 1
				elsif back_register["segment"].index("[rack]")
					#puts "rack-float-to-clerical-back"
					naof_rack_sites += 1
				end
			else
				if register["quad"] == back_register["quad"]
					#puts "quads-same"
					naof_same += 1
				end
			end
			rsite += 1
			#puts
		end
		sf = naof_same / (naof_registers - naof_rack_sites).to_f # sf | same-facter
		sf
	end

	def same_facter_aux_from_spaces(sample)
		space_names = sample["spaces"].keys
		space_names += @back_sample["spaces"].keys
		space_names = space_names.uniq
		naof_spaces = space_names.length
		naof_compaired_quads = 0
		naof_same_quads = 0
		ssite = 0
		while true
			if ssite == naof_spaces
				break
			end
			space_name = space_names[ssite]
			space = sample["spaces"][space_name]
			back_space = @back_sample["spaces"][space_name]
			if space && back_space
				naof_quads = space.length / 8
				naof_back_quads = back_space.length / 8
				naof_compair_quads = naof_quads >= naof_back_quads ? naof_quads : naof_back_quads
				site = 0
				qsite = 0
				while true
					quad = qsite <= naof_quads ? number_aof(space[site...(site + 8)].reverse) : nil
					back_quad = qsite <= naof_back_quads ? number_aof(back_space[site...(site + 8)].reverse) : nil
					is_same = false
					is_compair = true
					if quad && back_quad
						quad = segmentify_stack_site(sample["maps"], quad)
						back_quad = segmentify_stack_site(@back_sample["maps"], back_quad)
						#print_hash_vecter([quad,back_quad])
						if quad["segment"]
							# vast | is a warm alias for the statusquoer void (which of course could be meant warm but in refining conjurage you might find)
							if quad["segment"].index("[rack]") && back_quad["segment"].index("[rack]")
								#$stdin.gets
								is_compair = false
							else
								is_same = quad["segment"] == back_quad["segment"] && quad["segment-site"] == back_quad["segment-site"]
							end
						else
							is_same = quad["stack-site"] == back_quad["stack-site"]
						end
					elsif quad == nil && back_quad == nil
						break
					end
					if is_compair
						naof_compaired_quads += 1
						if is_same
							naof_same_quads += 1
						end
					end
					qsite += 1
					site += 8
				end
			end
			ssite += 1
			#puts
		end
		sf = naof_same_quads / (naof_compaired_quads).to_f # sf | same-facter
		sf
	end

	def set_clerically(sample_site, sample)
		@back_sample = sample
		@sample_site = sample_site
	end

	def registers_stat(sample)
		log_heading("registers stat", true)
		chart = []
		naof_registers = sample["registers"].length
		rsite = 0
		while true
			if rsite == naof_registers
				break
			end
			register = @back_sample["registers"][rsite]
			record = {
				"name" => register["name"],
				"quad-1" => register["quad"],
				"segment-1" => register["segment"].split(" - ")[0...2].join(" - "),
				"segment-site-1" => register["segment-site"],
				"fz-site-1" => register["fz-site"]
			}
			register = sample["registers"][rsite]
			record["quad-2"] = register["quad"]
			record["segment-2"] = register["segment"].split(" - ")[0...2].join(" - ")
			record["segment-site-2"] = register["segment-site"]
			record["fz-site-2"] = register["fz-site"]
			chart += [record]
			rsite += 1
		end
		print_hash_vecter(chart)
		puts
		true
	end

	def add_samples(sample_names, alreadies)
		if @back_sample == nil
			sample_name = sample_names[@sample_site]
			sample = eval(File::open(sample_name).read)
			@back_sample = sample
			return {"status" => "no-ambiguity", "aux-status" => "first-add", "sample-site" => @sample_site, "sfs" => [[0,1.0]]}
		else
			naof_samples = sample_names.length
			if naof_samples == 0
				return {"status" => "trail-faded"}
			end
			sfs = []
			site = 0
			while true
				if site == naof_samples
					break
				end
				if alreadies.index(site)
					site += 1
					next
				end
				sample_name = sample_names[site]
				sample = eval(File::open(sample_name).read)
				#puts "sample-site | #{site.to_s(16)}"
				#self.registers_stat(sample)
				sf = self.same_facter(sample)
				#puts "facter | #{sf}"
				sfs += [[site, sf]]
				site += 1
			end
			naof_sfs = sfs.length
			sfs = sfs.sort{|a,b| b[1] <=> a[1]}
			puts "sfs | #{sfs}"
			if sfs[1]
				if sfs[0][1] == sfs[1][1]
					puts "engaging aux-facter-from-spaces"
					sfs = []
					site = 0
					while true
						if site == naof_samples
							break
						end
						sample_name = sample_names[site]
						sample = eval(File::open(sample_name).read)
						puts "sample-site | #{site.to_s(16)}"
						#self.registers_stat(sample)
						sf = self.same_facter_aux_from_spaces(sample)
						puts "facter | #{sf}"
						sfs += [[site, sf]]
						site += 1
					end
					sfs = sfs.sort{|a,b| b[1] <=> a[1]}
					naof_sfs = sfs.length
				end
				#if sfs[0][1] == sfs[1][1]
					#return {"status" => "ambiguity", "sfs" => sfs}
				#end
			end
			site = sfs[0][0]
			sample_name = sample_names[site]
			sample = eval(File::open(sample_name).read)
			@back_sample = sample
			@sample_site = site
		end
		return {"status" => "no-ambiguity", "sample-site" => @sample_site, "same-facter" => sfs[0][1], "sfs" => sfs}
	end
end

def dso_meta(source)
	secs = File::open(source).read.bytes
	naof_secs = secs.length
	sample_source = source.split(".")
	sample_source[-1] = "sample-meta"
	sample_source = sample_source.join(".")
	sample = eval(File::open(sample_source).read)
	maps = sample["maps"]
	naof_maps = maps.length
	log_heading("quads-sheat")
	print_quads_sheat(secs)
	quads = []
	naof_quads = naof_secs / 8
	site = 0
	while true
		#puts "site | #{site}"
		qsite = site * 8
		quad_secs = secs[qsite...(qsite + 8)]
		naof_quad_secs = quad_secs.length
		if naof_quad_secs != 8
			break
		end
		quad = number_aof(quad_secs.reverse)
		quads += [qsite, quad]
		site += 1
	end
	map_quads = []
	site = 0
	while true
		if site == naof_quads
			break
		end
		quad = {
			"quad" => quads[site][1],
			"segment" => "",
			"segment-site" => nil,
			"quad-site" => quads[site][0]
		}
		is_map_quad = false
		msite = 0
		while true
			if msite == naof_maps
				break
			end
			map = maps[msite]
			#puts "map | #{map}"
			if (quad["quad"] >= map["origin"]) && (quad["quad"] < map["completion"])
				quad["segment"] = map["name"]
				quad["segment-site"] = (quad["quad"] - map["origin"])
				is_map_quad = true
				break
			end
			msite += 1
		end
		if is_map_quad
			map_quads += [quad]
		end
		site += 1
	end
	log_heading("map-quads")
	print_hash_vecter(map_quads)
	true
end
