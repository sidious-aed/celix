# segments-clerk | go through sampleage and with diff analasys generate segment data-views
# begin squarly elsewhere ... does not mean vacint, nesissarily at least.
require "./sat.rb"

class SegmentClerk
	attr_accessor :samples, :samples_chart
	def initialize(samples_node)
		@samples_node =  samples_node
		if @samples_node[-1] != "/"
			@samples_node += "/"
		end
		@manafest = Dir::entries(@samples_node)[2..-1]
		@samples = {}
		@samples_chart = Chart.new
		naof_sources = @manafest.length
		site = 0
		while true
			if site == naof_sources
				break
			end
			#puts "site | #{site}" # see-site always meant
			name = @manafest[site]
			name = "#{@samples_node}#{name}/"
			#puts "name | #{name}"
			if File::directory?(name)
				asm_name = "#{name}asm.meta"
				from_to_name = "#{name}from-to.meta"
				asm = eval(File::open(asm_name).read)
				from_to = eval(File::open(from_to_name).read)
				binary_name, bsb16 = name.split("-")
				samples = []
				items = Dir::entries(name)
				naof_items = items.length
				isite = 0
				while true
					if isite == naof_items
						break
					end
					iname = items[isite]
					#puts "iname | #{iname}"
					components = iname.split(".")
					type_com = components[-1]
					if type_com == "sample-meta"
						iname = "#{name}#{iname}"
						puts "iname | #{iname}"
						item = eval(File::open(iname).read)
						time = "#{item["meta"]["time-seconds"]}.#{item["meta"]["time-micro-seconds"]}".to_f
						sample = {
							"name" => iname,
							"time" => time
						}
						@samples_chart.add(poly_clone(sample))
						sample["asm"] = asm
						sample["from-to"] = from_to
						sample["sample"] = item
						fo = far_out(sample)
						samples += [sample]
					end
					isite += 1
				end
				samples.sort!{|a,b| a["time"] <=> b["time"]}
				@samples[bsb16] = samples
			end
			site += 1
		end
		#@samples_chart.view
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
end
