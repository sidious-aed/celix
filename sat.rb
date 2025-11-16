require "/home/tyrel/celix/binary-clerk.rb"

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
		if components[1] == "r-xp"
			category = "binary"
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

def quad_meta(name, quad, sample, dyn_meta)
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
			qm["segment-site"] = quad - map["origin"]
			break
		end
		site += 1
	end
	if site
		smap = sample["maps"][site]
		sname = smap["name"].split(" - ")[0]
		while true
			map = sample["maps"][site]
			mname = map["name"].split(" - ")[0]
			if mname == sname && map["category"] == "binary"
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
		qm["files-alias"] = fa
	end
	qm
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

def sample_asm(bc, binary_name, binary_site, binary_comand, samples_node, aux_spaces=[])
	bsb16 = binary_site.to_s(16)
	samples_inner_node = "#{samples_node}#{binary_name}-#{bsb16}/"
	if File::exists?(samples_inner_node) == false
		comand = "cn #{samples_inner_node}"
		puts "comand | #{comand}"
		system(comand)
	end
	# init and engage
	clear_bin("droid", ["files-meta", "try-meta", "maps-meta", "secs-meta", "stat-meta", "sched-meta", "schedstat-meta"])
	puts "samples-inner-node | #{samples_inner_node}"
	#$stdin.gets
	clear_bin(samples_inner_node, ["sample-meta"])
	bc.engage_slots
	slotb16 = bc.slots[binary_name]["slot"].to_s(16)
	asm = bc.get_asm(binary_name, binary_site)
	view_one(poly_clone(asm))
	from_to = bc.ametas[binary_name]["from-tos"][asm["site"]]
	view_one(poly_clone(from_to[0]))
	if from_to[1]
		view_one(poly_clone(from_to[1]))
	end
	conditional_mod = clericall_conditional_name(asm["alu-module"])
	aux_spaces = write_aux_spaces_request(aux_spaces, samples_inner_node, asm, from_to)
	if aux_spaces
		aux_space_names = aux_spaces.split("^")
	end
	aux_name = nil
	if BinaryConstants::StayToAluModules.index(asm["mod"]) && asm["params"][0] == "*"
		aux_name = aux_space_names[0]
	end
	comand = "./sequences assemblies/sat-init.asm secs/sat-init.secs #{slotb16} #{conditional_mod}"
	puts "comand | #{comand}"
	system(comand)
	is_naof_aux, naof_aux_rack_site, naof_aux_naof_rack_site, naof_aux_per, aux_is_cast, naof_aux_space_name = naof_aux_params(from_to[0])
	comand = "./sequences assemblies/sat-drive.asm secs/sat-drive.secs 0 #{is_naof_aux} #{naof_aux_rack_site.to_s(16)} #{naof_aux_naof_rack_site.to_s(16)} #{naof_aux_per.to_s(16)} #{aux_is_cast}"
	puts "comand | #{comand}"
	system(comand)
	bc.inject("secs/sat-init.secs", binary_name, binary_site)
	bc.write(binary_name)
	comand = binary_comand
	puts "comand | #{comand}"
	system(comand)
	droid_entrees = Dir::entries("droid")
	naof_entrees = droid_entrees.length
	is_conditional = BinaryConstants::ConditionalAluModules.index(asm["mod"]) != nil
	site = 0
	naof_samples = 0
	while true
		if site == naof_entrees
			break
		end
		entree = droid_entrees[site]
		components = entree.split(".")
		if components[-1] == "secs-meta"
			log_heading(entree)
			puts "components | #{components}"
			base = "droid/#{components[0..-2].join(".")}"
			puts "base | #{base}"
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
				qm = quad_meta(register_name, number, sample, bc.metas[binary_name]["dynsym"])
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
			if is_conditional
				comand = "./sequences assemblies/micro-conditional.asm secs/micro-conditional.secs 0 #{site} #{clericall_conditional_name(asm["mod"])}"
				puts "comand | #{comand}"
				system(comand)
				bc.engage_slots
				bc.inject("secs/micro-conditional.secs", binary_name, binary_site)
				bc.write(binary_name)
				comand = binary_comand
				puts "comand | #{comand}"
				system(comand)
				if File::exists?("droid/micro.secs")
					quad = number_aof(File::open("droid/micro.secs").read.bytes.reverse)
					sample["is-conditional"] = quad == 0xaed
				else
					puts "<--> | seems micro-conditional did not run."
				end
			end
			sample_name = "#{samples_inner_node}#{components[0..-2].join(".")}.sample-meta"
			chart = File::open(sample_name, "w")
			chart.write(sample)
			chart.close
			naof_samples += 1
		end
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

def view_sample(sample, site=nil)
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
			puts
			ssite += 1
		end
	end
	puts "is-conditional | #{sample["is-conditional"]}"
end

def time_bar_from_gt(gt_name)
	file = File::open(gt_name)
	seconds_1 = number_aof(file.read(8).bytes.reverse)
	micro_bar = number_aof(file.read(8).bytes.reverse)
	time = seconds_1 + (micro_bar.to_f / 0x1000000)
	time
end
