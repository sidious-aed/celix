require "/home/tyrel/celix/binary.rb"
require "/home/tyrel/celix/machine.rb"

class BinaryClerk
	attr_accessor :metas, :ametas, :slots, :segments, :writes
	def initialize(binary_name)
		meta_name = "charts/binary-meta/#{binary_name}.chart"
		asm_meta_name = "charts/asms-meta/#{binary_name}.chart"
		slots_meta_name = "charts/slots/#{binary_name}.chart"
		if File::exists?(meta_name) == false || File::exists?(asm_meta_name) == false
			puts "<--> | need meta and asm-meta charts generated for #{binary_name}"
			return false
		end
		@metas = {}
		@back_ametas = {}
		@back_slots = {}
		meta = eval(File::open(meta_name).read)
		@metas[binary_name] = meta
		ameta = eval(File::open(asm_meta_name).read)
		@ametas = {}
		@ametas[binary_name] = ameta
		smeta = eval(File::open(slots_meta_name).read)
		@back_slots[binary_name] = smeta
		@slots = {}
		@segments = []
		@sq = SequencesClerk.new
		naof_dls = meta["dls"].length
		dl_site = 0
		while true
			break
			if dl_site == naof_dls
				break
			end
			#puts "dsite | #{dl_site}"
			dl = meta["dls"][dl_site]
			#view_one(dl)
			dl_site += 1
			if dl["category"] == "mmap-synced"
				#view_one(dl)
				dl_name = dl["name"]
				meta_name = "charts/binary-meta/#{dl_name}.chart"
				asm_meta_name = "charts/asms-meta/#{dl_name}.chart"
				slots_meta_name = "charts/slots/#{dl_name}.chart"
				if File::exists?(meta_name) == false || File::exists?(asm_meta_name) == false || File::exists?(slots_meta_name) == false
					puts "<--> | need meta and asm-meta charts generated for #{dl_name}"
					return false
					#next
				end
				bmeta = eval(File::open(meta_name).read)
				ameta = eval(File::open(asm_meta_name).read)
				cmeta = eval(File::open(slots_meta_name).read)
				@metas[dl_name] = bmeta
				@ametas[dl_name] = ameta
				@back_slots[dl_name] = smeta
			end
		end
		#self.engage_slots
	end
	def engage_slots
		#@ametas = @back_ametas
		@slots = poly_clone(@back_slots)
		@writes = []
	end
	def segment_sites(bs)
		puts "segment-site | #{bs.to_s(16)}"
		naof_segments = @segments.length
		site = 0
		while true
			if site == naof_segments
				site = nil
				break
			end
			segment = @segments[site]
			naof_asms = segment.length
			asite = 0
			while true
				if asite == naof_asms
					asite = nil
					break
				end
				asm = segment[asite]
				puts "sasm | #{asm["bs"].to_s(16)}"
				if asm["bs"] == bs
					break
				end
				asite += 1
			end
			if asite
				break
			end
			site += 1
		end
		[site, asite]
	end
	def gather_for_segment_stay_to(binary_name, bs)
		obs = bs
		oslot = @slot
		naof_segments = @segments.length
		asms = []
		ameta = @ametas[binary_name]
		naof_secs_gathered = 0
		naof_segment_secs = 0
		while true
			puts "bs | #{bs.to_s(16)}"
			asm = ameta["asms"][ameta["asms-index"][bs]]
			if asm == nil
				return false
			end
			view_one(poly_clone(asm))
			casm = poly_clone(asm)
			casm["odest"] = casm["destination"]
			already_virtual = @segment_ports.index(bs)
			if already_virtual
				naof_asm_secs = 5
				casm["is-fvirt"] = true
				casm["naof-slot-secs"] = 5
			else
				nasm = ameta["asms"][(asm["site"] + 1)]
				#view_one(nasm.clone)
				if nasm
					naof_asm_secs = nasm["bs"] - asm["bs"]
				else
					naof_asm_secs = asm["naof-secs"]
				end
				if asm["destination"] && naof_asm_secs < 5
					if BinaryConstants::StayToAluModules.index(asm["mod"]) == nil
						view_one(asm)
						puts "<--> | we need to cover the case of the asm above in regards to asm-move-secs-expansion"
						return false
					end
					mod_name = clericall_conditional_name(asm["mod"])
					sequence = @sq.sequences("st 0 0 #{mod_name}")
					casm["naof-slot-secs"] = sequence.length
					casm["expansion"] = mod_name
				end
			end
			naof_secs_gathered += naof_asm_secs
			casm["splice-port"] = obs
			casm["segment-site"] = naof_segments
			casm["naof-slot-secs"] ||= casm["naof-secs"]
			casm["sbs"] = @slot
			view_one(poly_clone(casm))
			@osbs ||= @slot
			asms += [casm]
			@slot += casm["naof-slot-secs"]
			bs = asm["bs"] + naof_asm_secs
			if naof_secs_gathered >= 5
				break
			end
		end
		@segments += [asms]
		@segment_ports += [obs]
		#sequence = @sq.sequences("st #{(obs + 5).to_s(16)} #{@slot.to_s(16)}")
		#ameta["asms"][ameta["asms-index"][obs]]["alu-module"] = "jmpq"
		#ameta["asms"][ameta["asms-index"][obs]]["virtual-mode"] = "splice-port"
		#ameta["asms"][ameta["asms-index"][obs]]["slot-destination"] = oslot
		@slot += 5
		puts
	end
	def inject(secs_name, binary_name, bs)
		obs = bs
		@osbs = nil
		slot_init = self.slots[binary_name]["slot"]
		slot_com = slot_init + self.slots[binary_name]["slot-distance"]
		naof_proc_secs = File::size(secs_name)
		@slot = @slots[binary_name]["slot"]
		islot = @slot
		@writes += [{
			"sbs" => @slot,
			"secs" => File::open(secs_name).read.bytes
		}]
		@slot += naof_proc_secs
		oslot = @slot
		motions = []
		@segments = []
		@segment_ports = []
		ameta = @ametas[binary_name]
		cque = [bs]
		que = [bs]
		see_site = 0
		while true
			bs = que[0]
			if bs == nil
				break
			end
			#if see_site == 4
				#break
			#end
			que = que[1..-1]
			puts "que | #{que}"
			self.gather_for_segment_stay_to(binary_name, bs)
			asms = @segments[-1]
			naof_asms = asms.length
			asite = 0
			while true
				if asite == naof_asms
					break
				end
				asm = asms[asite]
				#view_one(asm)
				regards = ameta["regards"][asm["bs"]]
				if regards
					naof_regards = regards.length
					rsite = 0
					while true
						if rsite == naof_regards
							break
						end
						rasm = poly_clone(self.get_asm(binary_name, regards[rsite]))
						rsite += 1
						if rasm["bs"] >= slot_init && rasm["bs"] < slot_com
							next
						end
						if cque.index(rasm["bs"]) == nil
							if rasm["naof-secs"] < 5
								que += [rasm["bs"]]
								cque += [rasm["bs"]]
							else
								motions += [poly_clone(rasm)]
							end
						end
					end
				end
				asite += 1
			end
			see_site += 1
		end
		naof_segments = @segments.length
		site = 0
		while true
			if site == naof_segments
				break
			end
			segment = @segments[site]
			segment_secs = []
			naof_asms = segment.length
			asite = 0
			while true
				if asite == naof_asms
					break
				end
				asm = segment[asite]
				if asm["destination"]
					s1, s2 = self.segment_sites(asm["destination"])
					if s1
						port_bs =  @segments[s1][s2]["sbs"]
						if port_bs == @osbs
							port_bs = islot
						end
						@segments[site][asite]["destination"] = port_bs
					end
				end
				asite += 1
			end
			site += 1
		end
		naof_motions = motions.length
		# <--> | rubys dup and clone are not quite to their discription.
			# <-->\^ | thats we we will make poly_clone
		log_heading("segments")
		view_vecters(poly_clone(@segments))
		if naof_motions > 0
			log_heading("motions")
			view_vecter(poly_clone(motions))
		end
		log_heading("com")
		#@slot = oslot
		@slots[binary_name]["slot"] = @slot
		#log_heading("writing")
		site = 0
		while true
			if site == naof_segments
				break
			end
			segment = @segments[site]
			segment_secs = []
			naof_asms = segment.length
			asite = 0
			while true
				if asite == naof_asms
					break
				end
				asm = segment[asite]
				#view_one(asm.clone)
				if asm["is-fvirt"]
					s1, s2 = self.segment_sites(asm["bs"])
					tasm = @segments[s1][s2]
					#log_heading("double-splice-port")
					#view_one(tasm.clone)
					port_bs = tasm["sbs"]
					if tasm["bs"] == obs
						port_bs = islot
					end
					sequence = @sq.sequences("st #{(asm["sbs"] + asm["naof-slot-secs"]).to_s(16)} #{port_bs.to_s(16)} always")
					segment_secs += sequence
				elsif asm["expansion"]
					sequence = @sq.sequences("st #{(asm["sbs"] + asm["naof-slot-secs"]).to_s(16)} #{asm["destination"].to_s(16)} #{asm["expansion"]}")
					segment_secs += sequence
				elsif asm["destination"]
					view_one(poly_clone(asm))
					motion = asm["odest"] - asm["completion"]
					puts "motion | #{motion.to_s(16)}"
					motion_secs = secs_aof(motion, 4).reverse
					motion_site = sites_aof(motion_secs, asm["secs"])[0]
					puts "motion-site | #{motion_site}"
					motion = asm["destination"] - (asm["sbs"] + asm["naof-slot-secs"])
					motion_secs = secs_aof(motion, 4).reverse
					place(motion_secs, asm["secs"], motion_site)
					segment_secs += asm["secs"]
				else
					segment_secs += asm["secs"]
				end
				asite += 1
			end
			puts "segment[0] | #{segment[0]}"
			if site == 0
				port_bs = islot
			else
				port_bs = segment[0]["sbs"]
			end
			sequence = @sq.sequences("st #{(segment[0]["splice-port"] + 5).to_s(16)} #{port_bs.to_s(16)} always")
			@writes += [{
				"sbs" => segment[0]["splice-port"],
				"secs" => sequence
			}]
			port_bs = segment[-1]["sbs"] + segment[-1]["naof-slot-secs"]
			sequence = @sq.sequences("st #{(port_bs + 5).to_s(16)} #{(segment[0]["splice-port"] + 5).to_s(16)} always")
			@writes += [{
				"sbs" => port_bs,
				"secs" => sequence
			}]
			@writes += [{
				"sbs" => segment[0]["sbs"],
				"secs" => segment_secs
			}]
			site += 1
		end
		msite = 0
		while true
			if msite == naof_motions
				break
			end
			asm = motions[msite]
			view_one(asm.clone)
			puts "asm | #{asm}"
			s1, s2 = self.segment_sites(asm["destination"])
			sasm = @segments[s1][s2]
			view_one(sasm.clone)
			puts "sasm | #{sasm}"
			motion = asm["destination"] - asm["completion"]
			motion_secs = secs_aof(motion, 4).reverse
			motion_site = sites_aof(motion_secs, asm["secs"])[0]
			if sasm["bs"] == obs
				motion = islot - asm["completion"]
			else
				motion = sasm["sbs"] - asm["completion"]
			end
			motion_secs = secs_aof(motion, 4).reverse
			@writes += [{
				"sbs" => (asm["bs"] + motion_site),
				"secs" => motion_secs
			}]
			msite += 1
		end
		site = 0
		while true
			if site == naof_segments
				break
			end
			nopso = nil
			naof_nops = 0
			naof_port_secs = 0
			segment = @segments[site]
			log_heading("nops segment-#{site}")
			naof_segment_secs = 0
			naof_asms = segment.length
			asite = 0
			while true
				if asite == naof_asms
					break
				end
				asm = segment[asite]
				if asm["is-fvirt"]
					naof_segment_secs += 5
				else
					naof_segment_secs += asm["naof-secs"]
				end
				asite += 1
			end
			puts "naof-segment-secs | #{naof_segment_secs}"
			naof_nops = naof_segment_secs - 5
			if naof_nops > 0
				@writes += [{
					"sbs" => (segment[0]["bs"] + 5),
					"secs" => ([0x90] * naof_nops)
				}]
			end
			site += 1
		end
	end
	def write(binary_name)
		placed_name = binary_name.gsub(".so.", ".do.")
		placed_name = placed_name.gsub("-do", "-steel")
		comand = "./sf #{binary_name} #{placed_name}"
		puts "comand | #{comand}"
		system(comand)
		naof_writes = @writes.length
		site = 0
		while true
			if site == naof_writes
				break
			end
			write = @writes[site]
			buz_place(write["secs"], placed_name, write["sbs"])
			site += 1
		end
	end
	def get_asm(binary_name, bs, vecter_name="asms")
		asite = @ametas[binary_name]["asms-index"][bs]
		if asite
			@ametas[binary_name][vecter_name][asite]
		else
			nil
		end
	end
end
