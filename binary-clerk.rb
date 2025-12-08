require "/home/tyrel/celix/binary.rb"
require "/home/tyrel/celix/machine.rb"

class BinaryClerk
	attr_accessor :meta, :asm_metas, :slot, :asms, :asms_index, :regards, :moves
	def initialize(binary_name)
		@meta_name = "charts/binary-meta/#{binary_name}.chart"
		@asm_meta_name = "charts/asms-meta/#{binary_name}.chart"
		@slots_meta_name = "charts/slots/#{binary_name}.chart"
		meta_names = [@meta_name, @asm_meta_name, @slots_meta_name]
		naof_meta_names = meta_names.length
		msite = 0
		while true
			if msite == naof_meta_names
				break
			end
			meta_name = meta_names[msite]
			puts "meta-name | #{meta_name}"
			if File::exists?(meta_name) == false
				puts "<--> | need meta and asm-meta charts generated for #{binary_name}"
				return false
			end
			msite += 1
		end
		@binary_name = binary_name
		@meta = eval(File::open(@meta_name).read)
		@asm_metas = eval(File::open(@asm_meta_name).read)
		@back_slot = eval(File::open(@slots_meta_name).read)["slot"]
		@sc = SequencesClerk.new("charts/machine.chart")
		@charts_zap = 0
		#puts "slots | #{@back_slot_meta}"
	end
	def engage_slots
		#@ametas = @back_ametas
		@slot = @back_slot
		#@asms = clone_vecter(@asm_metas["asms"])
		#@regards = clone_vecter(@asm_metas["regards"])
		#@asms = clerk_clone(@asm_metas["asms"])
		#@regards = clerk_clone(@asm_metas["regards"])
		@do_clerk_nine = false
		if @charts_zap == 0
			@asms = @asm_metas["asms"]
			@regards = @asm_metas["regards"]
			@charts_zap += 1
		elsif @charts_zap == 1
			@asm_metas = eval(File::open(@asm_meta_name).read)
			@back_slot = eval(File::open(@slots_meta_name).read)["slot"]
			@do_clerk_nine = true
		else
			@do_clerk_nine = true
		end
		if @do_clerk_nine
			@asms = clerk_clone(@asm_metas["asms"])
			@regards = @asm_metas["regards"]
		end
		#@asms_index = clerk_clone(@asm_metas["asms-index"])
		@writes = []
		@nops = []
		@moves = {}
		self.index_asms
	end
	def asm_category(asm)
		if (asm["mod"] == "jmp" || asm["mod"] == "jmpq" || BinaryConstants::ConditionalAluModules.index(asm["mod"])) && asm["params"][0] != "*"
			if asm["naof-secs"] == 2 
				"expansion"
			else
				"motion"
			end
		elsif asm["destination"]
			"motion"
		else
			"just"
		end
	end
	def get_motion_site(asm)
		motion = asm["destination"] - asm["completion"]
		motion_secs = secs_aof(motion, 4).reverse
		puts "motion-secs | #{motion_secs}"
		if asm["bs"] == 0xe836
			view_vecter([asm])
			puts "<--> | motion | #{motion.to_s(16)}"
			#$stdin.gets
		end
		motion_site = sites_aof(motion_secs, asm["secs"])[0]
		puts "motion-site | #{motion_site}"
		if motion_site == nil
			motion_secs = secs_aof(motion, 1).reverse
			puts "motion-secs | #{motion_secs}"
			motion_site = sites_aof(motion_secs, asm["secs"])[0]
		end
		motion_site
	end
	def expand_asm(asm)
		asm["secs"]
	end
	def inject(secs_name, bs)
		if @moves[bs]
			bs = @moves[bs]
		end
		#puts "bs | #{bs.to_s(16)}"
		oslot = @slot
		naof_secs = File::size(secs_name)
		secs_file = File::open(secs_name)
		@writes += [{
			"bs" => @slot,
			"secs" => secs_file.read.bytes
		}]
		@slot += naof_secs
		section_ports = [bs]
		regard_motions = []
		sections = []
		section_pbs = [] # pbs | port-backs
		section_pts = [] # pbs | port-tos
		asms_to_place = []
		moves_que = []
		section_site = 0
		while true
			#puts "section-ports | #{section_ports}"
			pobs = section_ports[0]
			section = []
			if pobs == nil
				break
			end
			#puts "pobs | #{pobs.to_s(16)}"
			pbs = nil
			bpbs = nil # bpbs | back-port-binary-site
			pt = nil
			combs = nil
			naof_secs = 0
			asite = 0
			while true
				if naof_secs >= 5
					break
				end
				asm = get_asm(bs)
				if asm == nil
					bs += 1
					naof_secs -= 1
					next
				end
				view_vecter([asm])
				aobs = asm["bs"]
				bpbs = asm["completion"]
				combs = asm["completion"]
				#puts "section-site | #{section_site}"
				if pt == nil && section_site == 0
					pt = [(asm["bs"]), oslot]
				elsif pt == nil
					pt = [(asm["bs"]), @slot]
				end
				#puts "pt | #{pt.map{|e| e.to_s(16)}}"
				if asm == nil
					bs += 1
					naof_secs += 1
				end
				bs = asm["completion"]
				pbs = bs
				naof_secs += asm["naof-secs"]
				regards = @regards[asm["bs"]]
				#if regards
					#puts "<--> | regards | #{regards}"
					#$stdin.gets
				#end
				type = asm_category(asm)
				#puts "type | #{type}"
				if type == "motion"
					asm["motion-site"] = get_motion_site(asm)
				end
				if type == "expansion"
					asm["motion-site"] = 1
					conditional_code = clericall_conditional_name(asm["mod"])
					asm["secs"] = @sc.sequences("st 0 0 #{conditional_code}")
					asm["naof-secs"] = asm["secs"].length
				end
				asm["obs"] = asm["bs"]
				asm["bs"] = @slot
				asm["completion"] = @slot + asm["naof-secs"]
				@slot += asm["naof-secs"]
				section += [asm]
				if regards
					naof_regards = regards.length
					puts "naof-regards | #{naof_regards}"
					puts "regards | #{regards.map{|e| e.to_s(16)}}"
					rsite = 0
					while true
						if rsite == naof_regards
							break
						end
						puts "rsite | #{rsite}"
						regard = regards[rsite]
						puts "regard | #{regard.to_s(16)}"
						rasm = self.get_asm(regard)
						puts "<--> | rasm | #{rasm}"
						type = self.asm_category(rasm)
						puts "type | #{type}"
						if type == "motion"
							rasm["motion-site"] = get_motion_site(rasm)
						end
						if rasm["destination"]
							puts "rasm[\"destination\"] | #{rasm["destination"].to_s(16)}"
							if asite == 0 && section_site == 0
									rasm["destination"] = oslot
							else
								rasm["destination"] = asm["bs"]
							end
							puts "rasm[\"destination\"] | #{rasm["destination"].to_s(16)}"
						end
						if type == "expansion"
							section_ports += [rasm["bs"]]
						else
							regard_motions += [rasm]
						end
						rsite += 1
					end
				end
				asite += 1
			end
			naof_nops = naof_secs - 5
			#puts "naof-nops | #{naof_nops}"
			if naof_nops > 0
				nops = [0x90] * naof_nops
				bs = (combs - naof_nops);
				write = {
					"bs" => (bs),
					"secs" => nops
				}
				#puts "write | #{write}"
				@writes += [write]
				nsite = 0
				while true
					if nsite == naof_nops
						break
					end
					asm = ::WideSequences::nop(bs)
					#puts "<--> | #{bs.to_s(16)}"
					#puts "<--> | #{asm}"
					#view_vecter([asm])
					#$stdin.gets
					bs += 1
					nsite += 1
				end
			end
			section_pts += [pt]
			com = @slot + 5
			asm = {"bs" => @slot, "completion" => (com), "mod" => "jmpq", "params" => bpbs.to_s(16), "destination" => bpbs, "motion-site" => 1}
			asm["secs"] = @sc.sequences("st #{com.to_s(16)} #{bpbs.to_s(16)} always")
			asm["naof-secs"] = asm["secs"].length
			puts "<--> | #{asm}"
			#if asm["naof-secs"].class == Vecter
				#$stdin.gets
			#end
			@slot += 5
			section += [asm]
			sections += [section]
			section_pbs += [pbs]
			section_ports = section_ports[1..-1]
			section_site += 1
		end
		naof_moves = moves_que.length
		msite = 0
		while true
			if msite == naof_moves
				break
			end
			@moves[moves_que[0]] = moves_que[1]
			msite += 1
		end
		naof_sections = sections.length
		site = 0
		while true
			if site == naof_sections
				break
			end
			section = sections[site]
			naof_asms = section.length
			log_heading("section | #{site}")
			view_vecter(section)
			#puts "naof-asms | #{naof_asms}"
			#puts
			naof_asms = section.length
			pb_bs = section_pbs[site] # pb-bs | port-back-binary-site
			pt_bs = section_pts[site] # pt-bs | port-to-binary-site
			#puts "port-to | #{pt_bs.map{|e| e.to_s(16)}}"
			write = {
				"bs" => nil,
				"secs" => []
			}
			asite = 0
			while true
				if asite == naof_asms
					break
				end
				asm = section[asite]
				#view_vecter([asm])
				if asite == 0
					write["bs"] = asm["bs"]
				end
				type = asm_category(asm)
				#puts "<--> | #{type}"
				#puts "<--> | #{asm}"
				#$stdin.gets
				if type == "expansion"
					asm["secs"] = @sc.sequences("st #{asm["completion"].to_s(16)} #{asm["destination"].to_s(16)} #{conditional_code}")
				elsif type == "motion"
					motion = asm["destination"] - asm["completion"]
					motion_secs = secs_aof(motion, 4).reverse
					#puts "motion-secs | #{motion_secs}"
					place(motion_secs, asm["secs"], asm["motion-site"])
				else
				end
				write["secs"] += asm["secs"]
				asite += 1
			end
			#puts "write | #{write}"
			@writes += [write]
			asms_to_place += [asm]
			com = (pt_bs[0] + 5)
			destination = pt_bs[1]
			pb = @sc.sequences("st #{(com).to_s(16)} #{destination.to_s(16)} always")
			write = {
				"bs" => pt_bs[0],
				"secs" => pb
			}
			#puts "write | #{write}"
			@writes += [write]
			asm = ::WideSequences::jmpq(com, destination)
			#puts "<--> | asm | #{asm}"
			#self.place_asm(asm)
			asms_to_place += [asm]
			site += 1
		end
		naof_asms_to_place = asms_to_place.length
		log_heading("regard-motions")
		#view_vecter(regard_motions)
		#$stdin.gets
		naof_regards = regard_motions.length
		rsite = 0
		while true
			if rsite == naof_regards
				break
			end
			asm = regard_motions[rsite]
			motion = asm["destination"] - asm["completion"]
			motion_secs = secs_aof(motion, 4).reverse
			#puts "<--> | asm | #{asm}"
			type = asm_category(asm)
			#puts "type | #{type}"
			place(motion_secs, asm["secs"], asm["motion-site"])
			write = {
				"bs" => asm["bs"],
				"secs" => asm["secs"]
			}
			#puts "write | #{write}"
			@writes += [write]
			#view_vecter([rasm])
			#puts "rasm | <--> | #{rasm}"
			#$stdin.gets
			#self.place_asm(rasm)
			asms_to_place += [rasm]
			rsite += 1
		end
		site = 0
		while true
			if site == naof_asms_to_place
				break
			end
			#self.place_asm(asm)
			site += 1
		end
	end
	def write()
		place_name = @binary_name.gsub(".so.", ".do.").gsub("-do", "-steel")
		comand = "./sf #{@binary_name} #{place_name}"
		#puts "comand | #{comand}"
		system(comand)
		write_sites = []
		naof_writes = @writes.length
		write_secs = []
		write_site = 0
		wsite = 0
		while true
			if wsite == naof_writes
				break
			end
			write = @writes[wsite]
			write_secs += write["secs"]
			naof_secs = write["secs"].length
			write_sites += [[write_site, naof_secs, write["bs"]]]
			write_site += naof_secs
			wsite += 1
		end
		#puts "write-secs | #{write_secs}"
		#puts "write-sites | #{write_sites}"
		writes_name = "#{seed62(7)}.writes"
		#puts "writes-name | #{writes_name}"
		writes_file = File::open(writes_name, "w")
		writes_file.write(write_secs.pack("c*"))
		writes_file.close
		wsite = 0
		while true
			if wsite == naof_writes
				break
			end
			sites = write_sites[wsite]
			comand = "./place-sites #{writes_name} #{sites[0].to_s(16)} #{sites[1].to_s(16)} #{place_name} #{sites[2].to_s(16)}"
			#puts "comand | #{comand}"
			system(comand)
			wsite += 1
		end
		#unlink_file(writes_name)
	end
	def get_asm(bs)
		asm = nil
		asite = @asms_index[bs]
		if asite
			asm = @asms[asite].clone
		else
			nil
		end
	end
	def next_bs(asm_bs)
		asite = @asms_index[asm_bs]
		asm = @asms[asite + 1]
		if asm
			asm["bs"]
		else
			nil
		end
	end
	def asm_site_for_bs(bs)
		while true
			asm_index = @asms_index[bs]
			if asm_index
				break
			else
				bs -= 1
				if bs == 0
					asm_index = nil
					break
				end
			end
		end
		asm_index
	end
	def index_asms
		@asms.sort!{|a,b| a["bs"] <=> b["bs"]}
		@asms_index = {}
		naof_asms = @asms.length
		asite = 0
		while true
			if asite == naof_asms
				break
			end
			asm = @asms[asite]
			asm["site"] = asite
			bs = asm["bs"]
			@asms_index[bs] = asite
			asite += 1
		end
	end
	def place_asm(asm)
		#view_vecter([asm])
		#if asm["bs"] == 0x2ac9
			#view_vecter([asm])
			#$stdin.gets
		#end
		que = []
		#self.view_asms(0x1090, 0x109b)
		bs = asm["bs"]
		rack_nops = []
		naof_secs = asm["naof-secs"]
		unlink_sites = []
		while true
			#puts "<--> | bs | #{bs.to_s(16)}"
			aasm = self.get_asm(bs)
			if aasm == nil
				break
			end
			bs = aasm["completion"]
			naof_special_nao = 0
			while true
				next_asm = self.get_asm(bs)
				if next_asm
					break
				end
				bs += 1
				naof_special_nao += 1
			end
			naof_secs -= aasm["naof-secs"] + naof_special_nao
			unlink_sites += [aasm["bs"]]
			#puts "<--> | #{aasm}"
			#puts "unlink-sites | #{unlink_sites.map{|e| e.to_s(16)}}"
			#$stdin.gets
			if naof_secs <= 0
				break
			end
		end
		#puts "naof-secs | #{naof_secs}"
		#puts "bs | #{bs.to_s(16)}"
		unlink_sites.sort!{|a,b| b <=> a}
		#puts "unlink-sites | #{unlink_sites.map{|e| e.to_s(16)}}"
		#$stdin.gets
		naof_unlinks = unlink_sites.length
		ulsite = 0
		while true
			if ulsite == naof_unlinks
				break
			end
			bs = unlink_sites[ulsite]
			ulsite += 1
			aasm = self.get_asm(bs)
			if aasm == nil
				next
			end
			#asite = asm_site_for_bs(bs)
			#puts "asite | #{asite.to_s(16)}"
			#puts "bs | #{bs.to_s(16)}"
			#puts "<--> | #{asm}"
			#if aasm["bs"] == 0x1090
				#view_vecter([asm])
				#$stdin.gets
			#end
			@asms = unlink(@asms, aasm["site"])
		end
		@asms += [asm]
		puts "place-asm | <--> | #{asm}"
		#if asm["bs"] == 0x1090
			#view_vecter([asm])
			#$stdin.gets
		#end
		puts
		self.index_asms
	end
	def view_asms(origin=nil, completion=nil)
		if origin && completion
			asms = []
			naof_asms = @asms.length
			site = 0
			while true
				if site == naof_asms
					break
				end
				asm = @asms[site]
				bs = asm["bs"]
				if (bs >= origin) && (bs <= completion)
					asms += [asm]
				end
				site += 1
			end
		else
			asms = @asms
		end
		asms.sort!{|a,b| a["bs"] <=> b["bs"]}
		view_vecter(asms)
	end
end
