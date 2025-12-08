require "./sat.rb"

def clerical_needed(relay)
	puts "<--> | clerical needed."
	puts "\t<--> | #{relay}"
	$stdin.gets
end

def derive_asms_from_asm(bc, binary_name, binary_site, binary_comand, samples_node)
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
	clear_bin("droid", ["poly-time", "poly-quads"])
	asm = bc.get_asm(binary_name, binary_site)
	from_to = bc.ametas[binary_name]["from-tos"][asm["site"]]
	view_one(poly_clone(asm))
	nasms = []
	if BinaryConstants::StayToAluModules.index(asm["mod"])
		if BinaryConstants::CallModules.index(asm["mod"])
			if asm["params"][0] == "*"
				space_name = aux_space_name_for_dynamic(asm, from_to)
				components = space_name.split("|")
				naof_components = components.length
				if naof_components == 2
					space_name = components[0]
				end
				space_site = droid_select(at_sample["spaces"], lambda{|e| e["name"] == space_name})[0]
				puts "space-site | #{space_site}"
				if space_site
					space = at_sample["spaces"][space_site]
					puts "space | #{space}"
					stack_site = space["stack-site"]
					if stack_site == nil
						register_site = droid_select(at_sample["registers"], lambda{|e| e["name"] == space_name})[0]
						if register_site == nil
							self.clerical_needed("could not find register as auxillery for dynamic-stay-to")
						end
						register = at_sample["registers"][register_site]
						stack_site = quad_meta("stack-site", register["number"], at_sample, @bc.metas[@binary_name]["dynsym"])
						#$stdin.gets
					end
					puts "stack-site | #{stack_site}"
					next_bs = stack_site["fz-site"]
					nasm = poly_clone(bc.get_asm(binary_name, next_bs))
					nasms += [nasm]
				else
					self.clerical_needed("could not find dynamic-stay-to")
				end
			else
				next_bs = asm["destination"]
				nasm = poly_clone(bc.get_asm(binary_name, next_bs))
				nasms += [nasm]
			end
		elsif BinaryConstants::ConditionalAluModules.index(asm["mod"])
			nasm = poly_clone(bc.get_asm(binary_name, asm["destination"]))
			nasms += [nasm]
			nasm = poly_clone(bc.get_asm(binary_name, asm["completion"]))
			nasms += [nasm]
		end
	else
		nasm = poly_clone(bc.get_asm(binary_name, asm["completion"]))
		nasms += [nasm]
	end
	bc.engage_slots
	slotb16 = bc.slots[binary_name]["slot"].to_s(16)
	naof_next_asms = nasms.length
	com_site = naof_next_asms + 1
	poly_site = 0
	while true
		if poly_site == 0
			dasm = asm # dasm | dat-asm
		else
			if poly_site == com_site
				break
			end
			dasm_site = poly_site - 1
			dasm = nasms[dasm_site]
		end
		poly_site_b16 = poly_site.to_s(16)
		naof_poly_secs_b16 = poly_site_b16.length.to_s(16)
		poly_drive_name = "secs/droid-poly-times-#{poly_site_b16}.secs"
		comand = "./sequences assemblies/droid-poly-times.asm #{poly_drive_name} 0 #{poly_site_b16} #{naof_poly_secs_b16}"
		puts "comand | #{comand}"
		system(comand)
		comand = "./sequences assemblies/droid-init.asm secs/droid-init.secs 0 #{poly_drive_name}"
		puts "comand | #{comand}"
		system(comand)
		binary_site = dasm["bs"]
		puts "binary-site | #{binary_site.to_s(16)}"
		#puts "bs.moves | #{bc.moves}"
		view_hash(bc.moves)
		#$stdin.gets
		if bc.moves[binary_site]
			binary_site = bc.moves[binary_site]
		end
		bc.inject("secs/droid-init.secs", binary_name, binary_site)
		if poly_site == 0
			bc.write(binary_name)
			slot = bc.slots[binary_name]["slot"]
			binary_name = binary_name.gsub(".so.", ".do.")
			comand = "./generate-binary-charts.rb #{binary_name}"
			puts "comand | #{comand}"
			system(comand)
			moves = poly_clone(bc.moves)
			puts "binary-name | #{binary_name}"
			bc = BinaryClerk.new(binary_name)
			bc.engage_slots
			bc.moves = moves
			bc.slots[binary_name]["slot"] = slot
			puts "bc.slots | #{bc.slots}"
			#$stdin.gets
		end
		poly_site += 1
		#break
	end
	bc.write(binary_name)
	comand = binary_comand
	puts "comand | #{comand}"
	system(comand)
end
