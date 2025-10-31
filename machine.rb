require "./core.rb"
class SequencesClerk
	attr_accessor :signs, :modules
	def initialize
		@signs = eval(File::open("charts/machine.chart").read)
	end

	def sequences(dsl_entree)
		secs = []
		seqs = dsl_entree.split("\n")
		naof_seqs = seqs.length
		site = 0
		while true
			if site == naof_seqs
				break
			end
			components = seqs[site].split(" ")
			#puts "components | #{components}"
			mod_name = components[0]
			#puts "mod-name | #{mod_name}"
			mod_type = @signs[mod_name]["mod-type"]
			#puts "mod-type | #{mod_type}"
			if mod_type == "sign"
				secs += @signs[mod_name]["sign"]
			elsif mod_type == "rsign"
				register = components[1]
				secs += @signs[mod_name]["signs"][register]
			elsif mod_type == "rproc"
				quad = components[1].to_i(16)
				#puts "quad | #{quad.to_s(16)}"
				register = components[2]
				#puts "register | #{register}"
				secs += (@signs[mod_name]["signs"][register] + @signs[mod_name]["proc"].call(quad))
			elsif mod_type == "mproc"
				stay_site = components[1].to_i(16)
				destination = components[2].to_i(16)
				conditional_code = components[3]
				csite = @signs[mod_name]["conditional-codes"].index(conditional_code)
				#puts "csite | #{csite}"
				sign = @signs[mod_name]["conditional-signs"][csite]
				#puts "sign | #{sign}"
				secs += (sign + @signs[mod_name]["proc"].call(stay_site, destination))
				#puts "secs | #{secs}"
			end
			site += 1
		end
		secs
	end
end
