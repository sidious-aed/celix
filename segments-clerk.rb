# segments-clerk | go through sampleage and with diff analasys generate segment data-views
# begin squarly elsewhere ... does not mean vacint, nesissarily at least.
require "./sat.rb"

class SegmentsClerk
	attr_accessor :binary_name, :binary_site, :asm
	def initialize(asms_node, binary_name, binary_site, ocurance_site, segments_node)
		@asms_node = asms_node
		if @asms_node[-1] != "/"
			@asms_node += "/"
		end
		@binary_name = binary_name
		@bc = BinaryClerk.new(@binary_name)
		self.set_binary_site(binary_site)
		@ocurance_site = ocurance_site
		@bsb16 = @binary_site.to_s(16)
		@segments_node = segments_node
		if @segments_node[-1] != "/"
			@segments_node += "/"
		end
		if File::exists?(@segments_node) == false
			comand = "cn #{@segments_node}"
			puts "comand | #{comand}"
			system(comand)
		end
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
				name = "#{samples_node}#{name}"
				samples += [name]
			end
			site += 1
		end
		samples.sort! do |a,b|
			components1 = a.split("/")[-1].split(".")
			time1 = "#{components1[1].to_i(16)}.#{components1[2].to_i(16)}".to_f
			components2 = b.split("/")[-1].split(".")
			time2 = "#{components2[1].to_i(16)}.#{components2[2].to_i(16)}".to_f
			time1 <=> time2
		end
		samples
	end
	def next
		at_samples = samples_at
		naof_at_samples = at_samples.length
		at_sample = eval(File::open(at_samples[@ocurance_site]).read)
		next_bs = @asm["completion"]
		if BinaryConstants::SequencesDslStayToAluModules.index(asm["mod"])
			puts "conditional | #{at_sample["is-conditional"]}"
			if at_sample["is-conditional"]
				puts "destination | #{asm["destination"]}"
				next_bs = asm["destination"]
			end
			at_conditional = at_sample["is-condtional"]
			naof_at_samples = 0
			site = 0
			while true
				if site == naof_at_samples
					break
				end
				sample = eval(File::open(at_samples[site]).read)
				if sample["is-conditional"] == at_conditional
					naof_at_samples += 1
				end
				site += 1
			end
		end
		puts "next-bs | #{next_bs.to_s(16)}"
		next_samples = samples_at(next_bs)
		naof_samples = next_samples.length
		if naof_samples != naof_at_samples
			if naof_samples == 1
				@ocurance_site = 0
			else
				facters = SegmentsClerk::compair_sample_facters(at_sample, next_samples)
				facters.sort!{|a,b| b["registers"] <=> a["registers"]}
				puts "facters | #{facters}"
				if facters[0] == facters[1]
					facters.sort!{|a,b| b["spaces"] <=> a["spaces"]}
					puts "space-facters | #{facters}"
					if facters[0] == facters[1]
						puts "<--> | clerical needed for ambiguity"
						print "ocurance-site (base-16) | "
						os = $stdin.gets.strip.to_i(16)
						@ocurance_site = os
					else
						@ocurance_site = facters[0]["os"]
					end
				else
					@ocurance_site = facters[0]["os"]
				end
			end
		end
		self.set_binary_site(next_bs)
		puts "binary-site | #{@bsb16}"
		puts "ocurance-site | #{@ocurance_site}"
		puts
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
			if from["register"]
				rsite = droid_select(sample["sample"]["registers"], lambda{|e| e["name"] == from["register"]})[0]
				if rsite
					register = sample["sample"]["registers"][rsite]
					from_number += register["number"]
				end
			end
			if from["naof-register"] && from["naof-secs"]
				rsite = droid_select(sample["sample"]["registers"], lambda{|e| e["name"] == to["naof-register"]})[0]
				if rsite
					register = sample["sample"]["registers"][rsite]
					from_number += register["number"] * from["naof-secs"]
				end
			end
			is_faroutable = false
			to_number = to["constant"]
			to_number ||= 0
			torsite = nil
			if to["register"]
				torsite = droid_select(sample["sample"]["registers"], lambda{|e| e["name"] == to["register"]})[0]
				if torsite
					register = sample["sample"]["registers"][torsite]
					to_number += register["number"]
					is_faroutable = true
				end
			end
			if to["naof-register"] && to["naof-secs"]
				rsite = droid_select(sample["sample"]["registers"], lambda{|e| e["name"] == to["naof-register"]})[0]
				if rsite
					register = sample["sample"]["registers"][rsite]
					to_number += register["number"] * to["naof-secs"]
				else
					is_faroutable = false
				end
			end
			if is_faroutable
				asm = sample["asm"]
				if asm["mod"] == "add"
					puts "from-number | #{from_number}"
					puts "to-number | #{to_number}"
					fo["sample"]["registers"][torsite] = from_number + to_number
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
