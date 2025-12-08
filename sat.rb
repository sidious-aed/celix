require "/home/tyrel/celix/binary-clerk.rb"

def maps_manafest(maps_entree, zero_stay=nil)
	segments = maps_entree.split("\n")
	naof_segments = segments.length
	droid_drive_maps = ["equations.secs", "core.rack", "sat-drive.secs", "droid-drive.secs"]
	naof_droid_drive_maps = droid_drive_maps.length
  # anaon | ananomous-site
  anaon = 0
  manafest = []
	binary_anons = {}
	site = 0
	while true
		if site == naof_segments
			break
		end
		section = segments[site]
		map_site = site
		site += 1
		components = section.split(" ")
		naof_components = components.length
		is_anon = false
		if naof_components == 5
			is_anon = true
			bsite = site - 1
			puts "bsite | #{bsite}"
			if bsite < 0
				bsite = nil
			else
				while true
					map = manafest[bsite]
					if map == nil
						if bsite == 0
							break
						end
						bsite -= 1
						next
					end
					if map["category"] == "binary"
						break
					end
					if bsite == 0
						bsite = nil
						break
					end
					bsite -= 1
				end
			end
			if bsite
				bmap = manafest[bsite]
				binary_name = bmap["name"].split(" - ")[0]
				bin_name = binary_name.split("/")[-1]
				components += ["#{bin_name}-anon-#{binary_anons[binary_name]}"]
			else
				components += ["anonomous-#{anaon}"]
				anaon += 1
			end
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
		if components[1] == "r-xp"
			category = "binary"
			binary_name = name.split(" - ")[0]
			binary_anons[binary_name] ||= 0
		end
		name += " - #{category}"
		map_meta = {
			"site" => map_site,
			"name" => name,
			"origin" => origin,
			"completion" => completion,
			"naof-secs" => naof_secs,
			"category" => category
		}
		if zero_stay
			map_meta["from-zero"] = map_meta["origin"] - zero_stay
		end
		#puts "is-anon | #{is_anon}"
		#puts "naof-secs | #{map_meta["naof-secs"]}"
		#view_one(poly_clone(map_meta))
		#$stdin.gets
		if is_anon && map_meta["naof-secs"] == 0xf5000
			next
		end
		is_droid_drive_map = false
		dsite = 0
		while true
			if dsite == naof_droid_drive_maps
				break
			end
			droid_drive_map = droid_drive_maps[dsite]
			#puts "droid-drive-map | #{droid_drive_map}"
			if map_meta["name"].index(droid_drive_map)
				is_droid_drive_map = true
				break
			end
			dsite += 1
		end
		if is_droid_drive_map
			next
		end
		if is_anon
			binary_anons[binary_name] += 1
		end
		manafest += [map_meta]
  end
  manafest
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
			cmap = poly_clone(map)
			cmap["segment-site"] = (stack_site - cmap["origin"])
			saught_maps += [cmap]
		end
		msite += 1
	end
	#view_vecter(poly_clone(saught_maps))
	saught_maps
end

# @ | our times.rb reveals that there is a noteable pass cost but it can be nice clerically to get sites of a compair out of a vecter.
def droid_select(elements, compair)
	sites = []
	naof_elements = elements.length
	site = 0
	while true
		if site == naof_elements
			break
		end
		element = elements[site]
		#puts "element | #{element}"
		if compair.call(element)
			sites += [site]
		end
		site += 1
	end
	return sites
end

def write_quad(file_name, quad)
	comand = "./write-quad #{file_name} #{quad.to_s(16)}"
	puts "comand | #{comand}"
	system(comand)
end

def quad_meta(name, quad, sample, dynsyms=[], rack_init=nil)
	#puts "qm | #{name}"
	qm = {
		"name" => name,
		"number" => quad,
		"segment" => nil,
		"segment-site" => nil,
		"fz-segment" => nil,
		"fz-site" => nil,
		"dyn-source" => nil,
		"dyn-site" => nil,
		"file-alias" => nil
	}
	naof_maps = sample["maps"].length
	site = 0
	while true
		if site == naof_maps
			site = nil
			break
		end
		map = sample["maps"][site]
		if quad >= map["origin"] && quad < map["completion"]
			qm["segment"] = map["name"].split(" - ")[0..1].join(" - ")
			if rack_init && qm["segment"] == "[rack] - dynamic"
				quad -= rack_init
			end
			qm["segment-site"] = quad - map["origin"]
			break
		end
		site += 1
	end
	if site
		while true
			map = sample["maps"][site]
			if map["category"] == "binary"
				qm["fz-segment"] = map["name"].split(" - ")[0..1].join(" - ")
				qm["fz-site"] = quad - map["origin"]
				break
			end
			if site == 0
				break
			end
			site -= 1
		end
	end
	fa = sample["files"][quad]
	if fa
		qm["file-alias"] = fa
	end
	naof_dynsyms = dynsyms.length
	site = 0
	while true
		if site == naof_dynsyms
			site = nil
			break
		end
		dynsym = dynsyms[site]
		if qm["fz-site"] && qm["fz-site"] >= dynsym["stay-site"] && qm["fz-site"] < dynsym["completion"]
			qm["dyn-source"] = dynsym["source"]
			qm["dyn-site"] = quad - dynsym["stay-site"]
			break
		end
		site += 1
	end
	qm
end

def aux_space_name_for_dynamic(asm, from_to)
	from = from_to[0]
	aux_name = from["register"]
	if from["constant"]
		aux_name += "|#{asm["destination"].to_s(16)}"
	end
	if from["stead"] == "cast"
		aux_name += "*"
	end
	aux_name += "|40"
end

# aux-spaces-dsl    | "rip|229a0b*|100^rbp|-100|100^r8|10*|-100|100"
# aux-spaces-vecter | ["rip|229a0b*|100", "rbp|-100|100", "r8|10*|-100|100"]
def write_aux_spaces_request(aux_spaces, samples_inner_node=nil, asm=nil, from_to=nil)
	if aux_spaces == nil
		aux_spaces = []
	elsif aux_spaces.class == String
		aux_spaces = aux_spaces.split("^")
	end
	puts "aux-spaces | #{aux_spaces}"
	if samples_inner_node
		back_aux_spaces_name = "#{samples_inner_node}aux-spaces.request"
		if File::exists?(back_aux_spaces_name)
			back_aux_spaces = eval(File::open(back_aux_spaces_name).read)
			aux_spaces = back_aux_spaces + aux_spaces
		else
			#from["register"] && from["constant"]
			from = from_to[0]
			#puts "from | #{from}"
			if from
				puts "from | #{from}"
				view_one(poly_clone(from))
				if from["register"] && from["register"] != "" && from["constant"] && from["naof-register"] == nil
					constant = 0
					if from["constant"]
						constant = (asm["completion"] + from["constant"]).to_s(16)
					end
					aux_name = "#{from["register"]}|#{constant}"
					if from["stead"] == "cast"
						aux_name += "*"
					end
					aux_name += "|40"
					#puts "aux-name | #{aux_name}"
					aux_spaces = [aux_name] + aux_spaces
				end
			end
		end
		chart = File::open(back_aux_spaces_name, "w")
		chart.write(aux_spaces)
		chart.close
	end
	puts "aux-spaces | #{aux_spaces}"
	request_name = "droid/aux-spaces.request"
	secs = []
	naof_requests = aux_spaces.length
	site = 0
	while true
		if site == naof_requests
			break
		end
		request = aux_spaces[site]
		puts "request | #{request}"
		components = request.split("|")
		#puts "components | #{components}"
		naof_components = components.length
		et = naof_components - 1
		#puts "naof-components | #{naof_components}"
		register_name = components[0]
		if register_name == "rip"
			secs += secs_aof(0xaed, 8).reverse
		else
			secs += secs_aof((BinaryConstants::Register64Names.index(register_name) * 8), 8).reverse
		end
		secs += secs_aof((et - 1), 8).reverse
		csite = 1
		while true
			if csite == et
				break
			end
			#puts "csite | #{csite}"
			component = components[csite]
			is_cast = false
			if component[-1] == "*"
				is_cast = true
				component = component[0..-2]
			end
			#puts "component | #{component}"
			constant = component.to_i(16)
			secs += secs_aof(constant, 8).reverse
			if is_cast
				secs += secs_aof(1, 8).reverse
			else
				secs += secs_aof(0, 8).reverse
			end
			csite += 1
		end
		#puts "secs | #{secs}"
		#puts "et | #{components[et].to_i(16).to_s(16)}"
		secs += secs_aof(components[et].to_i(16), 8).reverse
		site += 1
	end
	unlink_file(request_name)
	if naof_requests > 0
		chart = File::open(request_name, "w")
		chart.write(secs.pack("c*"))
		chart.close
	end
	aux_spaces.join("^")
end

def naof_aux_params(from)
	params = [0, 0, 0, 0, 0, nil]
	if from && from["naof-register"]
		register_name = BinaryConstants::register64_name(from["register"])
		puts "register-name | #{register_name}"
		naof_register_name = BinaryConstants::register64_name(from["naof-register"])
		puts "naof-register-name | #{naof_register_name}"
		space_name = "naof-#{register_name}-#{naof_register_name}-#{from["naof-secs"]}"
		is_cast = 0
		if from["stead"] == "cast"
			is_cast = 1
		end
		register_rack_site = 0xaed
		if register_name != nil
			register_rack_site = (BinaryConstants::Register64Names.index(register_name) * 8)
		end
		params = [1, (register_rack_site), (BinaryConstants::Register64Names.index(naof_register_name) * 8), from["naof-secs"], is_cast, space_name]
	end
	params
end

def sample_asm(bc, binary_name, binary_site, binary_comand, samples_node, aux_spaces=[], with_rack_init=false)
	if samples_node[-1] != "/"
		samples_node += "/"
	end
	bsb16 = binary_site.to_s(16)
	samples_inner_node = "#{samples_node}#{binary_name}-#{bsb16}/"
	if File::exists?(samples_inner_node) == false
		comand = "cn #{samples_inner_node}"
		puts "comand | #{comand}"
		system(comand)
	end
	# init and engage
	clear_bin("droid", ["files-meta", "try-meta", "maps-meta", "secs-meta", "stat-meta", "sched-meta", "schedstat-meta", "rack-init"])
	puts "samples-inner-node | #{samples_inner_node}"
	#$stdin.gets
	clear_bin(samples_inner_node, ["sample-meta"])
	bc.engage_slots
	rack_init = nil
	if with_rack_init
		comand = "./sequences assemblies/droid-init.asm secs/droid-init.secs 0 secs/droid-rack-init.secs"
		puts "comand | #{comand}"
		system(comand)
		comand = "./sequences assemblies/droid-rack-init.asm secs/droid-rack-init.secs 0"
		puts "comand | #{comand}"
		system(comand)
		puts "bc.slots | #{bc.slots}"
		bc.inject("secs/droid-init.secs", "io.so.9", 0x1090)
		if binary_name != "io.so.9"
			bc.write("io.so.9")
			bc.engage_slots
		end
		#puts "rack-init | #{rack_init}"
		#puts "after io.so.9-1090"
		#$stdin.gets
	end
	slotb16 = bc.slots[binary_name]["slot"].to_s(16)
	asm = bc.get_asm(binary_name, binary_site)
	view_one(poly_clone(asm))
	from_to = bc.ametas[binary_name]["from-tos"][asm["site"]]
	view_one(poly_clone(from_to[0]))
	if from_to[1]
		view_one(poly_clone(from_to[1]))
	end
	conditional_mod = clericall_conditional_name(asm["alu-module"])
	if BinaryConstants::NopAluModules.index(asm["mod"])
		aux_spaces = write_aux_spaces_request(aux_spaces, samples_inner_node, asm, [])
		#puts "aux-spaces | #{aux_spaces}"
	else
		aux_spaces = write_aux_spaces_request(aux_spaces, samples_inner_node, asm, from_to)
	end
	if aux_spaces
		aux_space_names = aux_spaces.split("^")
	end
	#puts "aux-spaces | #{aux_spaces}"
	#$stdin.gets
	aux_name = nil
	if BinaryConstants::StayToAluModules.index(asm["mod"]) && asm["params"][0] == "*"
		aux_name = aux_space_names[0]
	end
	comand = "./sequences assemblies/sat-init.asm secs/sat-init.secs #{slotb16} #{conditional_mod}"
	puts "comand | #{comand}"
	system(comand)
	if BinaryConstants::NopAluModules.index(asm["mod"])
		is_naof_aux, naof_aux_rack_site, naof_aux_naof_rack_site, naof_aux_per, aux_is_cast, naof_aux_space_name = [0, 0 ,0 , 0, 0, 0]
	else
		is_naof_aux, naof_aux_rack_site, naof_aux_naof_rack_site, naof_aux_per, aux_is_cast, naof_aux_space_name = naof_aux_params(from_to[0])
	end
	comand = "./sequences assemblies/sat-drive.asm secs/sat-drive.secs 0 #{is_naof_aux} #{naof_aux_rack_site.to_s(16)} #{naof_aux_naof_rack_site.to_s(16)} #{naof_aux_per.to_s(16)} #{aux_is_cast}"
	puts "comand | #{comand}"
	system(comand)
	bc.inject("secs/sat-init.secs", binary_name, binary_site)
	bc.write(binary_name)
	comand = binary_comand
	puts "comand | #{comand}"
	system(comand)
	droid_entrees = filter_node_nodes(Dir::entries("droid"))
	naof_entrees = droid_entrees.length
	sample_names = []
	rack_init_name = nil
	site = 0
	while true
		if site == naof_entrees
			break
		end
		entree = droid_entrees[site]
		puts "entree | #{entree}"
		components = entree.split(".")
		puts "type | #{components[-1]}"
		if components[-1] == "secs-meta"
			sample_names += [entree]
		end
		if components[-1] == "rack-init"
			rack_init_name = "droid/#{entree}"
		end
		site += 1
	end
	if rack_init_name
		rack_init = number_aof(File::open(rack_init_name).read.bytes.reverse)
		puts "rack-init | #{rack_init.to_s(16)}"
		#$stdin.gets
	end
	sample_names.sort! do |a,b|
		components_a = a.split(".")
		time_a = "#{components_a[1].to_i(16)}.#{components_a[2].to_i(16)}".to_f
		components_b = b.split(".")
		time_b = "#{components_b[1].to_i(16)}.#{components_b[2].to_i(16)}".to_f
		time_a <=> time_b
	end
	naof_samples = sample_names.length
	#puts "sample-names | #{sample_names}"
	#puts "naof-samples | #{naof_samples}"
	#$stdin.gets
	is_conditional = BinaryConstants::ConditionalAluModules.index(asm["mod"]) != nil
	site = 0
	while true
		if site == naof_samples
			break
		end
		entree = sample_names[site]
		components = entree.split(".")
		#puts "entree | #{entree}"
		log_heading(entree)
		#puts "components | #{components}"
		base = "droid/#{components[0..-2].join(".")}"
		#puts "base | #{base}"
		#$stdin.gets
		maps_name = "#{base}.maps-meta"
		maps = maps_manafest(File::open(maps_name).read)
		view_vecter(poly_clone(maps))
		files_name = "#{base}.files-meta"
		files_meta = {}
		if File::exists?(files_name)
			files_aliases = File::open(files_name).read.split("\n")
			naof_aliases = files_aliases.length / 2
			fsite = 0
			while true
				if fsite == naof_aliases
					break
				end
				fasite = fsite * 2
				a1 = files_aliases[fasite].to_i
				a2 = files_aliases[(fasite + 1)]
				extension = a2.split(".")[-1]
				if BinaryConstants::SampleageFileExtensionsFilter.index(extension) == nil
					files_meta[a1] = a2
				end
				fsite += 1
			end
		end
		puts "files-meta | #{files_meta}"
		sample = {
			"meta" => {
				"time-seconds" => components[1].to_i(16),
				"time-micro-seconds" => components[2].to_i(16),
				"naof-sequences" => components[3].to_i(16),
				"naof-micro-sequences" => components[4].to_i(16)
			},
			"registers" => [],
			"rack-init" => rack_init,
			"spaces" => [],
			"maps" => maps,
			"files" => files_meta
		}
		view_hash(sample["meta"])
		secs_name = "#{base}.secs-meta"
		naof_maps = maps.length
		secs_file = File::open(secs_name)
		rsite = 0
		while true
			if rsite == BinaryConstants::NaofRegisters
				break
			end
			register_name = BinaryConstants::Register64Names[rsite]
			number = number_aof(secs_file.read(8).bytes.reverse)
			qm = quad_meta(register_name, number, sample, bc.metas[binary_name]["dynsym"], rack_init)
			sample["registers"] += [qm]
			rsite += 1
		end
		view_vecter(poly_clone(sample["registers"]))
		sample["zero-stay"] = number_aof(secs_file.read(8).bytes.reverse)
		puts "zero-stay | #{sample["zero-stay"].to_s(16)}"
		sample["is-conditional"] = number_aof(secs_file.read(8).bytes.reverse) == 0xaed
		puts "is-conditional | #{sample["is-conditional"]}"
		rsite = 0
		while true
			if rsite == BinaryConstants::NaofRegisters
				break
			end
			register_name = BinaryConstants::Register64Names[rsite]
			#puts "register-name | #{register_name}"
			naof_secs = number_aof(secs_file.read(8).bytes.reverse)
			#puts "naof-secs | #{naof_secs}"
			if naof_secs != 0xffffffffffffffff
				secs = secs_file.read(naof_secs).bytes
				#puts "secs | #{secs}"
				sample["spaces"] += [{
					"name" => register_name,
					"secs" => secs
				}]
			end
			rsite += 1
		end
		#puts "aux-spaces | #{aux_spaces}"
		puts "aux-space-names | #{aux_space_names}"
		puts "aux-name | #{aux_name}"
		naof_aux_spaces = aux_space_names.length
		asite = 0
		while true
			if asite == naof_aux_spaces
				break
			end
			#fs = secs_file.pos
			#puts "secs | #{secs_file.read.bytes}"
			#secs_file.seek(fs)
			#$stdin.gets
			naof_secs = number_aof(secs_file.read(8).bytes.reverse)
			puts "naof-secs | #{naof_secs}"
			if naof_secs != 0xffffffffffffffff
				stack_site = number_aof(secs_file.read(8).bytes.reverse)
				secs = secs_file.read(naof_secs).bytes
				space_name = aux_space_names[asite]
				qm = quad_meta(space_name, stack_site, sample, bc.metas[binary_name]["dynsym"])
				if space_name == aux_name
					bn = qm["fz-segment"].split(" - ")[0].split("/")[-1]
					sample["stay-to"] = {
						"binary-name" => bn,
						"bs" => qm["fz-site"]
					}
				end
				#puts "secs | #{secs}"
				sample["spaces"] += [{
					"name" => space_name,
					"stack-site" => qm,
					"secs" => secs
				}]
			end
			asite += 1
		end
		#puts "secs | #{secs_file.read.bytes}"
		if is_naof_aux == 1
			puts "naof-aux-space-name | #{naof_aux_space_name}"
			stack_site_secs = secs_file.read(8)
			if stack_site_secs != nil
				stack_site = number_aof(secs_file.read(8).bytes.reverse)
				qm = quad_meta(naof_aux_space_name, stack_site, sample, bc.metas[binary_name]["dynsym"])
				secs = secs_file.read.bytes
				sample["spaces"] += [{
					"name" => naof_aux_space_name,
					"stack-site" => qm,
					"secs" => secs
				}]
			end
		end
		naof_spaces = sample["spaces"].length
		ssite = 0
		while true
			if ssite == naof_spaces
				break
			end
			space = sample["spaces"][ssite]
			puts "#{space["name"]} | #{space["secs"]}"
			if space["stack-site"]
				view_one(poly_clone(space["stack-site"]))
			end
			puts
			ssite += 1
		end
		if sample["stay-to"]
			view_one(poly_clone(sample["stay-to"]))
		end
		#view_vecter(poly_clone(sample["spaces"]))
		#puts "is-conditional | #{is_conditional}"
		if BinaryConstants::SetConditionalModules.index(asm["mod"])
			#puts "micro-conditional-init"
			comand = "./write-quad ocurance.meta 0"
			#puts "comand | #{comand}"
			system(comand)
			comand = "./sequences assemblies/set-conditional.asm secs/set-conditional.secs 0 #{site.to_s(16)} #{asm["mod"]}"
			puts "comand | #{comand}"
			system(comand)
			bc.engage_slots
			bc.inject("secs/set-conditional.secs", binary_name, binary_site)
			bc.write(binary_name)
			comand = binary_comand
			#puts "comand | #{comand}"
			system(comand)
			if File::exists?("droid/micro.secs")
				quad = number_aof(File::open("droid/micro.secs").read.bytes.reverse)
				sample["is-conditional"] = quad == 1
			else
				puts "<--> | seems micro-conditional did not run."
			end
			#puts "micro-conditional-com"
			puts "sample[\"is-condtional\"] | #{sample["is-conditional"]}"
			#$stdin.gets
		end
		sample_name = "#{samples_inner_node}#{components[0..-2].join(".")}.sample-meta"
		puts "sample-name | #{sample_name}"
		chart = File::open(sample_name, "w")
		chart.write(sample)
		chart.close
		if rack_init
			#$stdin.gets
		end
		#$stdin.gets
		site += 1
	end

	view_one(poly_clone(asm))
	puts "naof-samples | #{naof_samples}"
	if naof_samples == 0
		comand = "rm -r #{samples_inner_node}"
		puts "comand | #{comand}"
		system(comand)
	else
		asm_meta_name = "#{samples_inner_node}asm.meta"
		chart = File::open(asm_meta_name, "w")
		chart.write(asm)
		chart.close
	end
end

def view_sample(sample, site=nil, view_quads_meta=false)
	vsample = poly_clone(sample)
	heading = "sample"
	if site
		heading = "ocurance | #{site.to_s(16)}"
	end
	log_heading(heading)
	view_hash(vsample["meta"])
	log_heading("registers")
	view_vecter(vsample["registers"])
	log_heading("maps")
	view_vecter(vsample["maps"])
	naof_spaces = vsample["spaces"].length
	if naof_spaces > 0
		log_heading("spaces")
		ssite = 0
		while true
			if ssite == naof_spaces
				break
			end
			space = vsample["spaces"][ssite]
			puts "#{space["name"]} | #{space["secs"]}"
			if space["stack-site"]
				view_one(space["stack-site"])
			end
			if view_quads_meta
				naof_secs = space["secs"].length
				naof_quads = naof_secs / 8
				quads = []
				qsite = 0
				while true
					if qsite == naof_quads
						break
					end
					site = qsite * 8
					quad = number_aof(space["secs"][qsite...(qsite + 8)].reverse)
					qm = quad_meta("#{site.to_s(16)}", quad, sample)
					quads += [qm]
					qsite += 1
				end
				view_vecter(quads)
			end
			puts
			ssite += 1
		end
	end
	if sample["rack-init"]
		puts "rack-init | #{sample["rack-init"].to_s(16)}"
	end
	puts "is-conditional | #{sample["is-conditional"]}"
end

def sort_samples(sample_names)
	naof_sample_names = sample_names.length
	seconds_vecters = {}
	seconds = []
	site = 0
	while true
		if site == naof_sample_names
			break
		end
		name = sample_names[site]
		components = name.split(".")
		element = {
			"naof-seconds" => components[1].to_i(16),
			"naof-micro-seconds" => components[2].to_i(16),
			"name" => name
		}
		seconds_vecters[element["naof-seconds"]] ||= []
		seconds_vecters[element["naof-seconds"]] += [element]
		if seconds.index(element["naof-seconds"]) == nil
			seconds += [element["naof-seconds"]]
		end
		site += 1
	end
	seconds.sort{|a,b| a <=> b}
	naof_seconds = seconds.length
	sorted = []
	site = 0
	while true
		if site == naof_seconds
			break
		end
		naof_stat_seconds = seconds[site]
		seconds_vecter = seconds_vecters[naof_stat_seconds]
		seconds_vecter.sort!{|a,b| a["naof-micro-seconds"] <=> b["naof-micro-seconds"]}
		sorted += seconds_vecter
		site += 1
	end
	site = 0
	while true
		if site == naof_sample_names
			break
		end
		name = sorted[site]["name"]
		sorted[site] = name
		site += 1
	end
	sorted
end

def droid_sort_bars(elements, bar1_name, bar2_name)
	naof_elements = elements.length
	vecters = {}
	bar1s = []
	site = 0
	while true
		if site == naof_elements
			break
		end
		element = elements[site]
		vecters[element[bar1_name]] ||= []
		vecters[element[bar1_name]] += [element]
		if bar1s.index(element[bar1_name]) == nil
			bar1s += [element[bar1_name]]
		end
		site += 1
	end
	bar1s.sort{|a,b| a <=> b}
	#puts "bar1s | #{bar1s}"
	naof_bar1s = bar1s.length
	sorted = []
	site = 0
	while true
		if site == naof_bar1s
			break
		end
		stat_bar1 = bar1s[site]
		#puts "naof-stat-bar1s | #{stat_bar1}"
		vecter = vecters[stat_bar1]
		vecter.sort!{|a,b| a[bar2_name] <=> b[bar2_name]}
		sorted += vecter
		site += 1
	end
	sorted
end

# <--> | for a future check if binary-site is 0x1090 for the interpreter and handle that case. for now; we should be fine without handling that case, as you can see.
def droid_stack_scans(bc, binary_name, binary_site, binary_comand, samples_node, rack_init=true)
	if samples_node[-1] != "/"
		samples_node += "/"
	end
	bsb16 = binary_site.to_s(16)
	components = samples_node.split("/")
	puts "components | #{components}"
	naof_components = components.length
	if naof_components == 1
		samples_node = samples_node + "#{binary_name}-#{bsb16}/"
		comand = "cn #{samples_node}"
		puts "comand | #{comand}"
		system(comand)
	end
	puts "samples-node | #{samples_node}"
	#$stdin.gets
	clear_bin("droid", ["maps-meta", "stack-segment", "rack-init"])
	bc.engage_slots
	if rack_init
		comand = "./sequences assemblies/droid-init.asm secs/droid-init.secs 0 secs/droid-rack-init.secs"
		puts "comand | #{comand}"
		system(comand)
		comand = "./sequences assemblies/droid-rack-init.asm secs/droid-rack-init.secs 0"
		puts "comand | #{comand}"
		system(comand)
		puts "bc.slots | #{bc.slots}"
		bc.inject("secs/droid-init.secs", "io.so.9", 0x1090)
		if binary_name != "io.so.9"
			bc.write("io.so.9")
			bc.engage_slots
		end
		#puts "rack-init | #{rack_init}"
		#puts "after io.so.9-1090"
		#$stdin.gets
	end
	comand = "./sequences assemblies/droid-init.asm secs/droid-init.secs 0 secs/droid-drive.secs"
	puts "comand | #{comand}"
	system(comand)
	comand = "./sequences assemblies/droid-drive.asm secs/droid-drive.secs 0"
	puts "comand | #{comand}"
	system(comand)
	bc.inject("secs/droid-init.secs", binary_name, binary_site)
	bc.write(binary_name)
	#puts "after #{binary_name}-#{binary_site.to_s(16)}"
	#$stdin.gets
	comand = binary_comand
	puts "comand | #{comand}"
	system(comand)
	#$stdin.gets
	sources = filter_node_nodes(Dir::entries("droid"))
	naof_sources = sources.length
	map_metas = {}
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		components = name.split(".")
		if components[-1] == "maps-meta"
			map_metas[components[0..-2].join(".")] ||= []
		end
		site += 1
	end
	accesses = map_metas.keys
	naof_ocurances = accesses.length
	puts "accesses | #{accesses}"
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		components = name.split(".")
		puts "components | #{components}"
		if components[-1] == "stack-segment"
			access = components[0..-3].join(".")
			map_metas[access] += [name]
		end
		site += 1
	end
	clear_bin(samples_node, ["stack-segment", "stack-maps-meta", "rack-init"])
	site = 0
	while true
		if site == naof_ocurances
			break
		end
		access = accesses[site]
		maps_name = "droid/#{access}.maps-meta"
		puts "maps-name | #{maps_name}"
		maps = maps_manafest(File::open(maps_name).read)
		view_vecter(poly_clone(maps))
		stack_names = map_metas[access]
		puts "stack-names | #{stack_names}"
		comand = "./sf #{maps_name} #{samples_node}#{access}.stack-maps-meta"
		puts "comand | #{comand}"
		system(comand)
		naof_maps = maps.length
		puts "naof-maps | #{naof_maps}"
		msite = 0
		while true
			if msite == naof_maps
				break
			end
			map = maps[msite]
			msb16 = map["site"].to_s(16)
			stack_name = "droid/#{access}.#{msb16}.stack-segment"
			puts "stack-name | #{stack_name}"
			if File::exists?(stack_name)
				puts "stack-name | #{stack_name}"
				stack_alias = "#{samples_node}#{access}.#{msb16}.stack-segment"
				puts "stack-alias | #{stack_alias}"
				comand = "./sf #{stack_name} #{stack_alias}"
				puts "comand | #{comand}"
				system(comand)
			end
			msite += 1
		end
		site += 1
	end
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		components = name.split(".")
		if components[-1] == "rack-init"
			map_metas[components[0..-2].join(".")] ||= []
			comand = "./sf droid/#{name} #{samples_node}#{name}"
			puts "comand | #{comand}"
			system(comand)
		end
		site += 1
	end
end

def samples_for(samples_node, binary_name, binary_site)
	if samples_node[-1] != "/"
		samples_node += "/"
	end
	bsb16 = binary_site.to_s(16)
	asm_samples_node = "#{samples_node}#{binary_name}-#{bsb16}/"
	sources = filter_node_nodes(Dir::entries(asm_samples_node))
	samples = []
	naof_sources = sources.length
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		components = name.split(".")
		if components[-1] == "sample-meta"
			samples += [name]
		end
		site += 1
	end
	samples = sort_samples(samples)
	naof_samples = samples.length
	site = 0
	while true
		if site == naof_samples
			break
		end
		name = samples[site]
		samples[site] = "#{asm_samples_node}#{name}"
		site += 1
	end
	samples
end

def stack_segments_for(samples_node, binary_name, binary_site, ocurance_site)
	if samples_node[-1] != "/"
		samples_node += "/"
	end
	bsb16 = binary_site.to_s(16)
	asm_samples_node = "#{samples_node}#{binary_name}-#{bsb16}/"
	sources = filter_node_nodes(Dir::entries(asm_samples_node))
	stack_segments = []
	naof_sources = sources.length
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		#puts "name | #{name}"
		components = name.split(".")
		if components[-1] == "stack-maps-meta"
			stack_segments += [name]
		end
		site += 1
	end
	stack_segments = sort_samples(stack_segments)
	#puts "stack-segments | #{stack_segments}"
	#$stdin.gets
	stack_segment = stack_segments[ocurance_site]
	maps_name = "#{asm_samples_node}#{stack_segment}"
	#puts "maps-name | #{maps_name}"
	#$stdin.gets
	#puts "maps-name | #{maps_name}"
	access = maps_name.split("/")[-1].split(".")[0..-2].join(".")
	#puts "access | #{access}"
	stack_segments = []
	stack_site = 0
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		site += 1
		components = name.split(".")
		if components[-1] == "stack-segment"
			access2 = components[0..-3].join(".")
			stack_segment_site = components[5].to_i(16)
			#puts "access2 | #{access2}"
			if access == access2
				#puts "segment-name | #{name}"
				name = "#{asm_samples_node}#{name}"
				stack_segments += [name]
			end
		end
	end
	stack_segments = sort_samples(stack_segments)
	rack_init = nil
	site = 0
	while true
		if site == naof_sources
			break
		end
		name = sources[site]
		#puts "name | #{name}"
		components = name.split(".")
		if components[-1] == "rack-init"
			rack_init = name
			break
		end
		site += 1
	end
	if rack_init
		rack_init = "#{asm_samples_node}#{rack_init}"
	end
	[maps_name, rack_init, stack_segments]
end

def light_quad_meta(quad, maps, rack_init=nil, replaces={})
	qm = {
		"number" => quad,
		"segment" => nil,
		"segment-site" => nil,
		"fz-segment" => nil,
		"fz-site" => nil
	}
	naof_maps = maps.length
	fz_name = nil
	site = 0
	while true
		if site == naof_maps
			site = nil
			break
		end
		map = maps[site]
		if quad >= map["origin"] && quad < map["completion"]
			name_components = map["name"].split(" - ")
			#puts "name-components | #{name_components}"
			#$stdin.gets
			fz_name = name_components[0] # <--> bins are good for types or categories
			qm["segment"] = name_components[0...2].join(" - ")
			qm["segment-site"] = quad - map["origin"]
			break
		end
		site += 1
	end
	#if qm["segment-site"] == 0x3ae0
		#puts "site | #{site}"
		#puts "fz-name | #{fz_name}"
		#puts "name-components | #{name_components}"
		#$stdin.gets
	#end
	if site
		while true
			map = maps[site]
			if map["category"] == "binary"
				name_components = map["name"].split(" - ")
				#if fz_name == name_components[0]
					qm["fz-segment"] = name_components[0...2].join(" - ")
					qm["fz-site"] = quad - map["origin"]
					puts "qm | #{qm}"
					break
				#end
			end
			if site == 0
				break
			end
			site -= 1
		end
	end
	if replaces[qm["segment"]]
		qm["segment"] = replaces[qm["segment"]]
	end
	if qm["segment"] == "[rack]"
		qm["segment"] = "[rack] - dynamic"
	end
	if rack_init && qm["segment"] == "[rack] - dynamic"
		#puts "in rack-init"
		#$stdin.gets
		qm["segment"] = "[rack] - dynamic"
		qm["segment-site"] = quad - rack_init
	end
	#qm["entree"] = secs_aof(qm["number"], 8).reverse.pack("c*")
	#naof_dynsyms = dynsyms.length
	#puts "naof-dynsyms | #{naof_dynsyms}"
	#puts "dynsyms | #{dynsyms}"
	#site = 0
	#while true
		#if site == naof_dynsyms
			#break
		#end
		#puts "site | #{site}"
		#dynsym = dynsyms[site]
		#puts "dynsym | #{dynsym}"
		#if qm["fz-site"] && qm["fz-site"] >= dynsym["stay-site"] && qm["fz-site"] < dynsym["completion"]
			#qm["dyn-source"] = dynsym["source"]
			#qm["dyn-site"] = quad - dynsym["stay-site"]
			#break
		#end
		#site += 1
	#end
	qm
end

def stack_segment_meta(samples_node, binary_name, binary_site, ocurance_site, map_site, replaces={})
	aliases = stack_segments_for(samples_node, binary_name, binary_site, ocurance_site)
	#puts "aliases | #{aliases}"
	#$stdin.gets
	maps = maps_manafest(File::open(aliases[0]).read)
	naof_maps = maps.length
	msite = 0
	while true
		if msite == naof_maps
			break
		end
		map = maps[msite]
		if map["site"] == map_site
			view_one(poly_clone(map))
			break
		end
		msite += 1
	end
	map = maps[msite]
	view_one(poly_clone(map))
	map_name = map["name"].split(" - ")[0].split("/")[-1]
	#puts "map-name | #{map_name}"
	rack_init = nil
	if aliases[1]
		rack_init = number_aof(File::open(aliases[1]).read(8).bytes.reverse)
		#puts "rack-init | #{rack_init.to_s(16)}"
		#$stdin.gets
	end
	stack_segment = nil
	segments = aliases[2]
	naof_segments = segments.length
	site = 0
	while true
		if site == naof_segments
			break
		end
		name = segments[site]
		components = name.split(".")
		ms = components[-2].to_i(16)
		if ms == map_site
			stack_segment = name
			break
		end
		site += 1
	end
	#puts "stack-segment | #{stack_segment}"
	#$stdin.gets
	meta = []
	naof_quads = File::size(stack_segment) / 8
	stack = File::open(stack_segment)
	site = 0
	while true
		if site == naof_quads
			break
		end
		quad = number_aof(stack.read(8).bytes.reverse)
		#if site == 0x24
			#puts "site | #{site.to_s(16)}"
			#qm = light_quad_meta(quad, maps, rack_init)
			#view_one(poly_clone(qm))
			#$stdin.gets
		#end
		if quad != 0
			#puts "quad | #{quad.to_s(16)}"
			qm = light_quad_meta(quad, maps, rack_init, replaces)
			qm["site"] = site
			qm["in-segment"] = map_name
			qm["in-segment-site"] = (site * 8)
			meta += [qm]
		end
		site += 1
	end
	meta
end

def stack_segments_diff(qms1, qms2, is_rack)
	site_motion = 0
	if is_rack
		qm1 = qms1[0]
		qm2 = qms2[0]
		#view_vecter(poly_clone([qm1, qm2]))
		site_motion = qm1["site"] - qm2["site"]
	end
	#puts "site-motion | #{site_motion.to_s(16)}"
	#$stdin.gets
	diff = []
	naof_quads1 = qms1.length
	first_dynamic_rack1 = nil
	qm1_sites = []
	site = 0
	while true
		if site == naof_quads1
			break
		end
		qm = qms1[site]
		if (first_dynamic_rack1 == nil) && (qm["segment"] == "[rack] - dynamic") && (qm["segment-site"] == 0)
			first_dynamic_rack1 = qm["site"]
		end
		#if (is_rack && first_dynamic_rack1) || is_rack == false
			qm1_sites += [qm["site"]]
		#end
		site += 1
	end
	naof_quads2 = qms2.length
	first_dynamic_rack2 = nil
	qm2_sites = []
	site = 0
	while true
		if site == naof_quads2
			break
		end
		qm = qms2[site]
		if (first_dynamic_rack2 == nil) && (qm["segment"] == "[rack] - dynamic") && (qm["segment-site"] == 0)
			first_dynamic_rack2 = qm["site"]
		end
		#if (is_rack && first_dynamic_rack2) || is_rack == false
			qm2_sites += [qm["site"]]
		#end
		site += 1
	end
	if is_rack
		site_motion = first_dynamic_rack1 - first_dynamic_rack2
	end
	#puts "qm1-sites | #{qm1_sites}"
	#puts "qm2-sites | #{qm2_sites}"
	site = 0
	while true
		if site == naof_quads1
			break
		end
		#puts "site | #{site}"
		qm1 = qms1[site]
		#view_one(poly_clone(qm1))
		qm2_site = qm1["site"] - site_motion
		#puts "qm2-site | #{qm2_site.to_s(16)}"
		qm2_site = qm2_sites.index(qm2_site)
		#puts "qm2-site | #{qm2_site.to_s(16)}"
		if qm2_site
			naof_diff = diff.length
			#puts "naof-diff | #{naof_diff}"
			qm2 = qms2[qm2_site]
			#view_vecter(poly_clone([qm1, qm2]))
			#$stdin.gets
			if qm1["number"] != qm2["number"]
				#puts "constants are different might be float."
				is_changed = true
				if qm1["segment"] && qm1["segment"] == qm2["segment"]
					if qm1["segment-site"] == qm2["segment-site"]
						#puts "is float but relativly the same."
						is_changed = false
					end
				end
				if is_changed
					#puts "is different."
					qm2["diff"] = "changed"
					qm2.delete("fz-segment")
					#qm2["segment"] = qm2["segment"].split(" - ")[0]
					qm2["ancient"] = qm1["number"]
					#qm2["ancient-segment"] = qm1["segment"].split(" - ")[0]
					qm2["ancient-segment"] = qm1["segment"]
					qm2["ancient-site"] = qm1["segment-site"]
					qm2["ancient-fz"] = qm1["fz-site"]
					qm2["asite"] = qm1["site"]
					diff += [qm2]
				end
			end
		else
			qm1["diff"] = "naoified"
			diff += [qm1]
		end
		site += 1
	end
	site = 0
	while true
		if site == naof_quads2
			break
		end
		qm2 = qms2[site]
		qm1_site = qm2["site"] + site_motion
		qm1_site = qm1_sites.index(qm1_site)
		#puts "qm1-site | #{qm1_site}"
		#$stdin.gets
		if qm1_site == nil
			qm2["diff"] = "added"
			diff += [qm2]
		end
		site += 1
	end
	diff.sort!{|a,b| a["site"] <=> b["site"]}
	diff
end

def time_bar_from_gt(gt_name)
	file = File::open(gt_name)
	seconds_1 = number_aof(file.read(8).bytes.reverse)
	micro_bar = number_aof(file.read(8).bytes.reverse)
	time = seconds_1 + (micro_bar.to_f / 0x1000000)
	time
end
