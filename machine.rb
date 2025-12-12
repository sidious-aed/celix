require "/home/tyrel/celix/core.rb"
class WideSequences
	StandardNop = {"mod" => "nop", "params" => "", "naof-secs" => 1, "destination" => nil, "source" => nil}
	StandardJmpq = {"mod" => "jmpq", "naof-secs" => 5}
	class << self
		def nop(bs)
			com = bs + 1
			secs = [0x90]
			asm = {"bs" => bs, "completion" => com, "mod" => "nop", "params" => "", "secs" => secs, "naof-secs" => 1, "destination" => nil, "source" => nil}
			asm
		end
		def jmpq(bs, destination)
			com = bs + 5
			motion = destination - com
			motion_secs = secs_aof(motion, 4).reverse
			secs = [0x9] + motion_secs
			bs = com - 5
			jmpq = {"bs" => bs, "completion" => com, "mod" => "jmpq", "secs" => secs, "naof-secs" => 5, "params" => destination.to_s(16), "destination" => destination}
			#puts "jmpq | #{jmpq}"
			jmpq
		end
	end
end
class SequencesClerk
	attr_accessor :signs, :modules
	def initialize(chart_name)
		@signs = eval(File::open(chart_name).read)
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
