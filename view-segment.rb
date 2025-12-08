#!/usr/bin/env ruby
require "./segments-clerk.rb"
naof_params, params, env, iat, symbols = init()

class SegmentViewer
	attr_accessor :asms_chart, :samples, :naof_samples, :view_sites
	def initialize(segment_node)
		if segment_node[-1] != "/"
			segment_node += "/"
		end
		@segment_node = segment_node
		#puts "segment-node | #{segment_node}"
		self.load_segment
	end
	def load_segment
		@asms_chart = Chart.new
		@samples = []
		@view_sites = []
		@view_sites_all = []
		@samples = []
		sources = Dir::entries(@segment_node)
		naof_sources = sources.length
		@naof_samples = 0
		site = 0
		while true
			if site == naof_sources
				break
			end
			name = sources[site]
			components = name.split(".")
			if components[-1] == "sample-meta"
				name = "#{@segment_node}#{name}"
				@samples += [name]
				@naof_samples += 1
			end
			site += 1
		end
		#puts "samples | #{@samples}"
		@samples.sort! do |a,b|
			components_a = a.split("/")[-1].split("-")
			#puts "components-a | #{components_a}"
			components_b = b.split("/")[-1].split("-")
			#puts "components-b | #{components_b}"
			components_a[0].to_i(16) <=> components_b[0].to_i(16)
		end
		#puts "samples | #{@samples}"
		site = 0
		while true
			if site == @naof_samples
				break
			end
			#puts "sample-name | #{@samples[site]}"
			sample = eval(File::open(@samples[site]).read)
			sample["site"] = site
			@samples[site] = sample
			asm = poly_clone(sample["asm"])
			asm["asite"] = site
			@asms_chart.add(asm)
			@view_sites_all += [site]
			site += 1
		end
		self.engage_view_sites
	end
	def engage_view_sites(view_sites=nil)
		view_sites ||= @view_sites_all
		@view_sites = view_sites
	end
end

if naof_params != 2
  puts "params | 2"
  puts "1 | segment-node"
	puts "2 | binary-name"
  return
end
segment_node = params[0]
binary_name = params[1].gsub(".so.", ".do.")
sv = SegmentViewer.new(segment_node)
while true
	sv.asms_chart.view_sites(sv.view_sites)
	print "comand | "
	comand = $stdin.gets.strip
	components = comand.split(" ")
	naof_components = components.length
	puts "components | #{components}"
	is_pause = true
	if components[0] == "v"
		site = components[1].to_i(16)
		sample = sv.samples[site]
		puts "sample | #{sample}"
		puts
		sv.asms_chart.view(site, site)
		view_sample(sample)
		sv.asms_chart.view(site, site)
		puts
	elsif components[0] == "vrs"
		register_name = components[1]
		site = components[1].to_i(16)
		site = 0
		asms = []
		while true
			if site == sv.naof_samples
				break
			end
			sample = sv.samples[site]
			asm = poly_clone(sample["asm"])
			register_site = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
			#puts "register-site | #{register_site}"
			if register_site
				register = sample["registers"][register_site]
				#view_one(register)
				asm["register"] = register["number"]
				asm["fz-segment"] = register["fz-segment"]
				asm["fz-site"] = register["fz-site"]
				asms += [asm]
			end
			site += 1
		end
		view_vecter(asms)
		puts
	elsif components[0] == "vws"
		segment_name = components[1]
		segment_reg = nil
		if segment_name
			segment_reg = /#{segment_name}/i
		end
		site = 0
		naof_writes = 0
		asms = []
		while true
			if site == sv.naof_samples
				break
			end
			#puts "site | #{site}"
			sample = sv.samples[site]
			asm = poly_clone(sample["asm"])
			if asm["mod"].index("cmp")
				site += 1
				next
			end
			asm.delete("secs")
			destination = asm.delete("destination")
			asm.delete("source")
			asm["from"] = nil
			asm["from-site"] = nil
			asm["to"] = nil
			asm["to-site"] = nil
			from_to = sample["from-to"]
			from = from_to[0]
			if from
				register_name = BinaryConstants::register64_name(from["register"])
				if register_name
					register_site = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
					register = sample["registers"][register_site]
					stack_site = register["number"]
					if stack_site == 0
						site += 1
						next
					end
					qm = quad_meta("quad-meta", stack_site, sample)
					if qm["segment"]
						asm["from"] = qm["segment"]
						asm["from-site"] = qm["segment-site"]
					else
						asm["from-site"] = register["number"]
					end
				else
					stack_site = from["constant"]
					if stack_site == 0
						site += 1
						next
					end
					asm["from-site"] = stack_site
				end
			end
			to = from_to[1]
			if to && to["stead"] == "cast"
				is_metafyied = false
				if to["register"] == "rip"
					naof_maps = sample["maps"].length
					msite = 0
					while true
						if msite == naof_maps
							msite = nil
							break
						end
						#puts "binary-name | #{binary_name}"
						map = sample["maps"][msite]
						#view_one(poly_clone(map))
						if map["category"] == "binary" && map["name"].index(binary_name) != nil
							#puts "found-binary-map"
							break
						end
						msite += 1
					end
					if msite
						map = sample["maps"][msite]
						stack_site = map["origin"] + destination
						is_metafyied = true
					end
					#view_one(poly_clone(to))
					#puts "stack-site | #{stack_site}"
					#puts "is-metafyed | #{is_metafyied}"
					#$stdin.gets
				else
					register_name = BinaryConstants::register64_name(to["register"])
					if register_name
						register_site = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
						register = sample["registers"][register_site]
						stack_site = register["number"]
						if to["constant"]
							stack_site += to["constant"]
						end
						if to["naof-register"]
							register_name = BinaryConstants::register64_name(to["naof-register"])
							register_site = droid_select(sample["registers"], lambda{|e| e["name"] == register_name})[0]
							register = sample["registers"][register_site]
							dynamic_motion = register["number"] * to["naof-secs"]
							stack_site += dynamic_motion
						end
						is_metafyied = true
					end
				end
				if is_metafyied
					qm = quad_meta("quad-meta", stack_site, sample)
					if segment_name && ((qm["segment"] =~ segment_reg) == nil)
						site += 1
						next
					end
					#puts "qm | #{qm}"
					asm["to"] = qm["segment"]
					asm["to-site"] = qm["segment-site"]
					asm["asite"] = site
					asms += [asm]
					naof_writes += 1
				end
			end
			site += 1
		end
		log_heading("casts")
		view_vecter(asms)
		puts "naof-writes | #{naof_writes.to_s(16)}"
		puts
	elsif components[0] == "vft"
		site = components[1].to_i(16)
		sample = sv.samples[site]
		from_to = sample["from-to"]
		#puts "from-to | #{from_to}"
		log_heading("from")
		view_one(poly_clone(from_to[0]))
		log_heading("to")
		view_one(poly_clone(from_to[1]))
	elsif components[0] == "f"
		naof_filters = (naof_components - 1) / 2
		view_sites = []
		site = 0
		while true
			if site == sv.naof_samples
				break
			end
			sample = sv.samples[site]
			asm = sample["asm"]
			is_match = true
			fsite = 0
			while true
				if fsite == naof_filters
					break
				end
				filter_site = (fsite * 2) + 1
				access = components[filter_site]
				#puts "access | #{access}"
				filter = components[(filter_site + 1)]
				#puts "filter | #{filter}"
				value = asm[access]
				#puts "value | #{value}"
				if value.class == Integer
					filter = filter.to_i(16)
					if value != filter
						is_match = false
						break
					end
				else
					filter = /#{filter}/i
					if (value =~ filter) == nil # <--> | we'd feel from you in the sharps that your nao is fine.
						is_match = false
						break
					end
				end
				fsite += 1
			end
			if is_match
				view_sites += [site]
			end
			site += 1
		end
		#puts "view-sites | #{view_sites}"
		sv.engage_view_sites(view_sites)
		is_pause = false
	elsif components[0] == "cf"
		sv.engage_view_sites()
		is_pause = false
	elsif components[0] == "ls"
		sv.load_segment
		is_pause = false
	elsif components[0] == "c"
		break
	end
	if is_pause
		$stdin.gets
	end
end
