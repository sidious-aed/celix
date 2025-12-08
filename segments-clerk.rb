# segments-clerk | go through sampleage and with diff analasys generate segment data-views
# begin squarly elsewhere ... does not mean vacint, nesissarily at least.
require "./sat.rb"

class SegmentsClerk
	attr_accessor :binary_name, :binary_site, :asm, :ocurance_site
	def initialize(asms_node, binary_name, binary_site, ocurance_site, segments_node, et_binary_site)
		@asms_node = asms_node
		@see_site = 0
		@in_segments = {}
		if @asms_node[-1] != "/"
			@asms_node += "/"
		end
		@binary_name = binary_name
		@bc = BinaryClerk.new(@binary_name)
		self.set_binary_site(binary_site)
		@ocurance_site = ocurance_site
		@bsb16 = @binary_site.to_s(16)
		@segments_node = segments_node
		@return_que = []
		if @segments_node[-1] != "/"
			@segments_node += "/"
		end
		if File::exists?(@segments_node) == false
			comand = "cn #{@segments_node}"
			puts "comand | #{comand}"
			system(comand)
		end
		@et_binary_site = et_binary_site
		self.engage_ats
	end
	# auxillery idea | manafolds might not be seen correct
	def engage_ats
		@ats = {
			@binary_site => @ocurance_site
		}
	end
	def set_binary_site(binary_site)
		@binary_site = binary_site
		@bsb16 = @binary_site.to_s(16)
		@asm = @bc.get_asm(@binary_name, @binary_site)
		@from_to = @bc.ametas[@binary_name]["from-tos"][@asm["site"]]
		@in_segments[@binary_site] ||= []
		if @in_segments[@binary_site].index(@ocurance_site)
			#@ocurance_site += 1
			#self.clerical_needed("<--> | seems we need to create a far-out for this case")
			#$stdin.gets
		end
		@in_segments[@binary_site] += [@ocurance_site]
	end
	def samples_at(at_bs=nil)
		if at_bs
			samples_node = "#{@asms_node}#{@binary_name}-#{at_bs.to_s(16)}/"
		else
			samples_node = "#{@asms_node}#{@binary_name}-#{@bsb16}/"
		end
		sources = filter_node_nodes(Dir::entries(samples_node))
		naof_sources = sources.length
		samples = []
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
		puts
		puts "samples | #{samples}"
		samples = sort_samples(samples)
		puts "samples | #{samples}"
		puts
		naof_samples = samples.length
		site = 0
		while true
			if site == naof_samples
				break
			end
			name = samples[site]
			name = "#{samples_node}#{name}"
			samples[site] = name
			site += 1
		end
		samples
	end
	def sample_at()
		samples_node = "#{@asms_node}#{@binary_name}-#{@bsb16}/"
		sources = filter_node_nodes(Dir::entries(samples_node))
		naof_sources = sources.length
		#puts "naof-sources | #{naof_sources}"
		samples = []
		site = 0
		while true
			if site == naof_sources
				break
			end
			name = sources[site]
			components = name.split(".")
			if components[-1] == "sample-meta"
				#puts "name | #{name}"
				samples += [name]
			end
			site += 1
		end
		samples = sort_samples(samples)
		name = samples[@ocurance_site]
		name = "#{samples_node}#{name}"
		name
	end
	def clerical_needed(extra_relay=nil)
		puts "<--> | clerical needed for ambiguity"
		if extra_relay
			puts "\t<--> #{extra_relay}"
		end
		puts "ocurance-site | #{@ocurance_site.to_s(16)}"
		print "ocurance-site (base-16) | "
		os = $stdin.gets.strip.to_i(16)
		@ocurance_site = os
	end
	def next
		continue = true
		obs = @binary_site
		if @see_site != 0 && @binary_site == @et_binary_site
			#$stdin.gets
			continue = false
		end
		view_one(poly_clone(@asm))
		at_samples = samples_at
		naof_at_samples = at_samples.length
		puts "at-sample | #{at_samples[@ocurance_site]}"
		puts "naof-at-samples | #{naof_at_samples}"
		#$stdin.gets
		at_sample = eval(File::open(at_samples[@ocurance_site]).read)
		at_sample["asm"] = poly_clone(@asm)
		from_to = @bc.ametas[@binary_name]["from-tos"][@asm["site"]]
		at_sample["from-to"] = poly_clone(from_to)
		at_sample = self.far_out(at_sample)
		next_bs = @asm["completion"]
		if BinaryConstants::CallModules.index(@asm["mod"])
			@return_que += [@asm["completion"]]
		end
		if BinaryConstants::ConditionalAluModules.index(@asm["mod"])
			puts "conditional | #{at_sample["is-conditional"]}"
			if at_sample["is-conditional"]
				puts "destination | #{asm["destination"]}"
				next_bs = @asm["destination"]
			end
			at_conditional = at_sample["is-conditional"]
			naof_at_samples_ancient = naof_at_samples
			naof_at_samples = 0
			site = 0
			while true
				if site == naof_at_samples_ancient
					break
				end
				sample = eval(File::open(at_samples[site]).read)
				puts "sample[\"is-conditional\"] | #{sample["is-conditional"]}"
				puts "at-conditional | #{at_conditional}"
				if sample["is-conditional"] == at_conditional
					naof_at_samples += 1
				end
				site += 1
			end
			puts "naof-at-samples | #{naof_at_samples}"
			puts "next-bs | #{next_bs.to_s(16)}"
		elsif BinaryConstants::StayToAluModules.index(asm["mod"])
			if asm["params"][0] == "*"
				space_name = aux_space_name_for_dynamic(@asm, @from_to)
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
				else
					self.clerical_needed("could not find dynamic-stay-to")
				end
			else
				next_bs = asm["destination"]
			end
		elsif BinaryConstants::ReturnAluModules.index(asm["mod"])
			naof_returns = @return_que.length
			next_bs = @return_que[-1]
			#puts "naof-returns | #{naof_returns}"
			#$stdin.gets
			if naof_returns == 0 && @et_binary_site == nil
				continue = false
			else
				@return_que = @return_que[0..-2]
			end
			if next_bs == nil
				rsp_space_site = droid_select(at_sample["spaces"], lambda{|e| e["name"] == "rsp"})[0]
				if rsp_space_site
					rsp_space = at_sample["spaces"][rsp_space_site]
					stack_site = number_aof(rsp_space["secs"][0...8].reverse)
					qm = quad_meta("rack-init", stack_site, at_sample, @bc.metas[@binary_name]["dynsym"])
					bn = qm["fz-segment"].split(" - ")[0].split("/")[-1].gsub(".do.", ".so.").gsub("-do", "-steel")
					if bn == @binary_name
						next_bs = qm["fz-site"]
					else
						puts "<--> | need to create change in binary"
						puts "binary-name | #{@binary_name}"
						puts "bn | #{bn}"
						view_one(qm)
						$stdin.gets
					end
				else
					puts "<--> | could not determine return"
					print "next-binary-site (base-16) | "
					next_bs = $stdin.gets.strip.to_i(16)
				end
			end
		end
		puts "next-bs | #{next_bs.to_s(16)}"
		next_samples = samples_at(next_bs)
		naof_samples = next_samples.length
		next_samples.each do |e|
			puts "#{e}"
			sample = eval(File::open(e).read)
			meta = {
				"naof-seconds" => sample["meta"]["time-seconds"],
				"naof-micro-seconds" => sample["meta"]["time-micro-seconds"]
			}
			view_hash(meta)
		end
		if naof_samples == 1
			puts "<--> | found-by-only-(lesser-might-to-a-prose)"
			@ocurance_site = 0
		else
			facters = SegmentsClerk::compair_sample_facters(at_sample, next_samples)
			facters.sort!{|a,b| b["registers"] <=> a["registers"]}
			puts "facters | #{facters}"
			et_facter = facters[0]["registers"]
			naof_facters = facters.length
			et_facters = []
			fsite = 0
			while true
				if fsite == naof_facters
					break
				end
				facter = facters[fsite]
				if facter["registers"] == et_facter
					et_facters += [facter]
				end
				fsite += 1
			end
			et_facters.sort!{|a,b| b["spaces"] <=> a["spaces"]}
			puts "et-facters | #{et_facters}"
			if obs == 0x1aaa7 && @ocurance_site == 0x23
				$stdin.gets
			end
			#$stdin.gets
			if et_facters[1] && et_facters[0]["spaces"] == et_facters[1]["spaces"]
				#if naof_samples != naof_at_samples
					#self.clerical_needed("<--> | ambiguity from too similar. maybe a new far-out will shift ambiguity.")
					puts "in-segments[next_bs] | #{@in_segments[next_bs]}"
					next_ocurance_for_next = @in_segments[next_bs]
					if next_ocurance_for_next
						next_ocurance_for_next = next_ocurance_for_next[-1]
						puts "<--> | seeking next-ocurance-for-next"
						puts "next-ocurance-for-next | #{next_ocurance_for_next.to_s(16)}"
						naof_et_facters = et_facters.length
						fsite = 0
						while true
							if fsite == naof_et_facters
								fsite = nil
								break
							end
							facter = et_facters[fsite]
							puts "facter | #{facter}"
							if facter["os"] > next_ocurance_for_next
								break
							end
							fsite += 1
						end
						facter = et_facters[(fsite)]
						puts "et-facter | #{facter}"
						next_ocurance_for_next = facter["os"]
						puts "next-ocurance-for-next | #{next_ocurance_for_next.to_s(16)}"
						#$stdin.gets
					else
						next_ocurance = et_facters[0]["os"]
						next_ocurance_for_next = next_ocurance
					end
					@ocurance_site = next_ocurance_for_next
				#end
			else
				#puts "<--> | found-by-standard-facters"
				#@ocurance_site = facters[0]["os"]
				#$stdin.gets
			end
		end
		rax_site = droid_select(at_sample["registers"], lambda{|e| e["name"] == "rax"})[0]
		view_one(poly_clone(at_sample["registers"])[rax_site])
		puts "next-bs | #{next_bs.to_s(16)}"
		puts "see-site | #{@see_site}"
		puts "naof-samples | #{naof_samples}"
		puts "naof-at-samples | #{naof_at_samples}"
		#puts "ocurance-site | #{@ocurance_site}"
		puts "ocurance-site | #{@ocurance_site.to_s(16)}"
		#if (@binary_site >= 0xc370) && (@binary_site <= 0xc37a)
		#if @ocurance_site == 1
			#$stdin.gets
		#end
		#$stdin.gets
		self.set_binary_site(next_bs)
		puts "binary-site | #{@bsb16}"
		puts "ocurance-site | #{@ocurance_site}"
		puts
		@see_site += 1
		#if obs == 0x1d544
			#puts "continue | #{continue}"
			#$stdin.gets
		#end
		!continue
	end
	def far_out(sample)
		fo = poly_clone(sample)
		from = sample["from-to"][0]
		puts "from | #{from}"
		to = sample["from-to"][1]
		puts "to | #{to}"
		if to && to["register"] && to["stead"] == "stead"
			from_number = from["constant"]
			from_number ||= 0
			if from["register"] && (from["register"] != "rip")
				rsite = droid_select(sample["registers"], lambda{|e| e["name"] == from["register"]})[0]
				if rsite
					register = sample["registers"][rsite]
					from_number += register["number"]
				end
			end
			if from["naof-register"] && from["naof-secs"]
				rsite = droid_select(sample["registers"], lambda{|e| e["name"] == to["naof-register"]})[0]
				if rsite
					register = sample["registers"][rsite]
					from_number += register["number"] * from["naof-secs"]
				end
			end
			is_faroutable = false
			to_number = to["constant"]
			to_number ||= 0
			torsite = nil
			if to["register"]
				torsite = droid_select(sample["registers"], lambda{|e| e["name"] == to["register"]})[0]
				if torsite
					to_register = sample["registers"][torsite]
					to_number += to_register["number"]
					is_faroutable = true
				end
			end
			if to["naof-register"] && to["naof-secs"]
				rsite = droid_select(sample["registers"], lambda{|e| e["name"] == to["naof-register"]})[0]
				if rsite
					register = sample["registers"][rsite]
					to_number += register["number"] * to["naof-secs"]
				else
					is_faroutable = false
				end
			end
			puts "is-faroutable | #{is_faroutable}"
			if is_faroutable
				asm = sample["asm"]
				is_motioned = false
				if asm["mod"] == "add"
					#puts "torsite | #{torsite}"
					#puts "from-number | #{from_number}"
					#puts "to-number | #{to_number}"
					#puts "ancient | #{fo["registers"][torsite]["number"]}"
					fo["registers"][torsite]["number"] = from_number + to_number
					#puts "now | #{fo["registers"][torsite]["number"]}"
					#$stdin.gets
					is_motioned = true
				elsif asm["mod"] == "sub"
					fo["registers"][torsite]["number"] = from_number - to_number
					is_motioned = true
				elsif asm["mod"] == "lea"
					fo["registers"][torsite]["number"] = from_number
					is_motioned = true
				elsif asm["mod"] == "mov"
					if to["stead"] == "stead"
						fo["registers"][torsite]["number"] = from_number
						is_motioned = true
					end
				end
				if is_motioned
					qm = quad_meta("quad-meta", fo["registers"][torsite]["number"], fo, @bc.metas[@binary_name]["dynsym"])
					fo["registers"][torsite]["segment"] = qm["segment"]
					fo["registers"][torsite]["segment-site"] = qm["segment-site"]
					fo["registers"][torsite]["fz-segment"] = qm["fz-segment"]
					fo["registers"][torsite]["fz-site"] = qm["fz-site"]
				end
			end
		end
		fo
	end
	class << self
		def facters_for_samples_compair(sample1, sample2)
			naof_same = 0
			naof_compairs = 0
			rsite = 0
			while true
				if rsite == BinaryConstants::NaofRegisters
					break
				end
				register_name = BinaryConstants::Register64Names[rsite]
				register1 = sample1["registers"][rsite]
				register2 = sample2["registers"][rsite]
				rsite += 1
				#puts "register-1 | #{register1}"
				if register1["segment"] == "[rack] - dynamic"
					next
				end
				if register1["segment"] == nil
					if register1["number"] == register2["number"]
						naof_same += 1
					end
				else
					if register1["segment"] == register2["segment"] && register1["segment-site"] == register2["segment-site"]
						naof_same += 1
					end
				end
				naof_compairs += 1
			end
			#puts "naof-compairs | #{naof_compairs}"
			#puts "naof-same | #{naof_same}"
			registers_facter = naof_same.to_f / naof_compairs
			naof_spaces = sample1["spaces"].length
			naof_spaces2 = sample2["spaces"].length
			naof_same = 0
			naof_compairs = 0
			site = 0
			while true
				if site == naof_spaces
					break
				end
				space1 = sample1["spaces"][site]
				space1_name = space1["name"]
				space2 = nil
				ssite = 0
				while true
					if ssite == naof_spaces2
						space2 = nil
						break
					end
					space2 = sample2["spaces"][ssite]
					if space2["name"] == space1_name
						break
					end
					ssite += 1
				end
				if space2
					naof_secs1 = space1["secs"].length
					naof_secs2 = space2["secs"].length
					naof_secs = (naof_secs1 <= naof_secs2) ? naof_secs1 : naof_secs2
					naof_quads = naof_secs / 8
					ssite = 0
					while true
						if ssite == naof_quads
							break
						end
						qsite = ssite * 8
						qsite_com = qsite + 8
						quad1 = number_aof(space1["secs"][qsite...qsite_com].reverse)
						quad2 = number_aof(space2["secs"][qsite...qsite_com].reverse)
						map1 = which_maps(sample1["maps"], quad1)[0]
						map2 = which_maps(sample1["maps"], quad1)[0]
						if map1
							if map2
								if map1["segment"] != "[rack] - dynamic"
									if map1["segment"] == map2["segment"] && map1["segment-site"] == map2["segment-site"]
										naof_same += 1
									end
								end
								naof_compairs += 1
							end
						else
							if quad1 == quad2
								naof_same += 1
							end
							naof_compairs += 1
						end
						ssite += 1
					end
				end
				site += 1
			end
			#puts "naof-compairs | #{naof_compairs}"
			#puts "naof-same | #{naof_same}"
			spaces_facter = naof_same.to_f / naof_compairs
			facters = {
				"registers" => registers_facter,
				"spaces" => spaces_facter
			}
			facters
		end
		def compair_sample_facters(sample1, sample_names)
			facters_vecter = []
			naof_samples = sample_names.length
			site = 0
			while true
				if site == naof_samples
					break
				end
				sample2 = eval(File::open(sample_names[site]).read)
				facters = SegmentsClerk::facters_for_samples_compair(sample1, sample2)
				facters["os"] = site
				facters_vecter += [facters]
				site += 1
			end
			facters_vecter
		end
	end
end
