require "/home/tyrel/celix/charts.rb"

class BinaryConstants
	StayToAluModules = ["bnd callq", "bnd jmpq", "bnd jns", "callq", "ja", "jae", "jb", "jbe", "je", "jg", "jge", "jl", "jle", "jmp", "jmpq", "jne", "jns", "jo", "jp", "jrcxz", "js"]
	ConditionalAluModules = ["bnd jns", "ja", "jae", "jb", "jbe", "je", "jg", "jge", "jl", "jle", "jne", "jns", "jo", "jp", "jrcxz", "js"]
	SequencesDslStayToAluModules = ["je", "jne", "jbe", "ja", "js", "jmpq", "jb", "jle", "jge", "jg", "jns", "jo", "jae", "jl", "jp", "jmp"]
	Register64Names = ["r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "rax", "rbx", "rcx", "rdx", "rdi", "rsi", "rsp", "rbp"]
	Register32Names = ["r8d", "r9d", "r10d", "r11d", "r12d", "r13d", "r14d", "r15d", "eax", "ebx", "ecx", "edx", "edi", "esi", "esp", "ebp"]
	Register16Names = ["r8w", "r9w", "r10w", "r11w", "r12w", "r13w", "r14w", "r15w", "ax", "bx", "cx", "dx", "di", "si", "sp", "bp"]
	Register8Names = ["r8b", "r9b", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b", "al", "bl", "cl", "dl", "dil", "sil", "spl", "bpl"]
	NaofRegisters = BinaryConstants::Register64Names.length
	SegmentHeadings = ["ELF Header", "Section Headers", "Program Headers", "Dynamic section at", "Relocation section '.rela.dyn'", "Relocation section '.rela.plt'", "Symbol table '.dynsym'", "Symbol table '.symtab'", "Version symbols section", "Version needs section", "Version definition section"]
  SegmentSources = ["binary", "sections", "loads", "dynamic", "rela-dyn", "rela-plt", "dynsym", "symtab", "version-symbols", "version-needs", "version-definitions"]
	FromInit = ["vdso.so.1", "linux-vdso.so.1"]
	SampleageFileExtensionsFilter = ["files-meta"]
	class << self
		def register64_name(register_name)
			r64_site = Register64Names.index(register_name)
			if r64_site
				return register_name
			end
			r32_site = Register32Names.index(register_name)
			if r32_site
				return Register64Names[r32_site]
			end
			r16_site = Register16Names.index(register_name)
			if r16_site
				return Register64Names[r16_site]
			end
			r8_site = Register8Names.index(register_name)
			if r8_site
				return Register64Names[r8_site]
			end
			return nil
		end
	end
end

def clericall_conditional_name(gnu_module)
  clerical_mods = ["equal", "not-equal", "equal-less", "above", "signed", "always", "below", "signed-equal-below", "signed-equal-above", "signed-above", "not-signed", "overflow", "equal-above", "signed-less", "parity", "always"]
  gnu_site = BinaryConstants::SequencesDslStayToAluModules.index(gnu_module)
  if gnu_site == nil
    "always"
  else
    clerical_mods[gnu_site]
  end
end

def binary_dls(path)
  if (path[0] != ".") && (path[0] != "/")
    path = "./#{path}"
  end
	dls = []
	from_her = `LD_TRACE_LOADED_OBJECTS=1 ./io.so.9 #{path}`.split("\n")
	naof_segments = from_her.length
	if naof_segments == 1
		dls += [{"name" => "io.so.9", "category" => "mmap-synced"}]
	end
	site = 0
	while true
		if site == naof_segments
			break
		end
		sections = from_her[site].split(" ")
		site += 1
		if sections[0] == "statically"
			next
		end
		naof_sections = sections.length
		if naof_sections == 2
			dl = {"name" => sections[0]}
		else
			dl = {"name" => sections[2]}
		end
		dl["name"] = dl["name"].split("/")[-1]
		if BinaryConstants::FromInit.index(dl["name"])
			dl["category"] = "from-init"
		else
			dl["category"] = "mmap-synced"
		end
		dls += [dl]
	end
  dls
end

def get_binary_meta(name)
  if (name[0] != ".") && (name[0] != "/")
    name = "./#{name}"
  end
  meta = {}
	meta["dls"] = binary_dls(name)
  from_her = `readelf -a #{name}`
	segments = from_her.split("\n")
	naof_segments = segments.length
  mode = nil
  source = nil
	naof_elements_for_sources = {}
  naof_source_sections = nil
  aux_source = nil
  record = nil
  ssite = 0
  while true
		if ssite == naof_segments
			break
		end
		section = segments[ssite] # many things depend upawn vantage. * in prose of could we.
    if section[-1] == ":"
      heading = section[0..-2].split(" ")[0...3].join(" ")
      mode = BinaryConstants::SegmentHeadings.index(heading)
      if mode != nil
        source = BinaryConstants::SegmentSources[mode]
				naof_elements_for_sources[source] = 0
        naof_source_sections = 0
        record = {}
        if (mode == 0) || (source == "version-needs") || (source == "version-definitions")
          meta[source] = {}
        else
          meta[source] = []
        end
      else
        source = nil
      end
    else
      if source == "binary"
        section_source_completion = section.index(":")
        if section_source_completion
          section_source = section[0...section_source_completion].downcase.split(" ").join("-")
          components = section[section_source_completion..-1].split(" ")[1..-1]
          if is_base10(components[0])
            meta[source][section_source] = components[0].to_i
          elsif components[0][0...2] == "0x"
            meta[source][section_source] = components[0][2..-1].to_i(16)
          else
            meta[source][section_source] = components.join(" ").downcase
          end
        end
      elsif source == "sections"
        square_site = section.index("[")
        if square_site
          square_site = section.index("]")
          components = section[(square_site + 1)..-1].split
          if components[0] == "NULL"
            components = [""] + components
          end
          ["source", "category", "stack-node", "binary-node"].each_with_index do |record_source, site|
            if site < 2
              record[record_source] = components[site].downcase
            else
              record[record_source] = components[site].to_i(16)
            end
          end
        else
          components = section.split(" ")
          #puts "components | #{components}"
          if components.length == 5
            components = components[0...2] + [""] + components[2..-1]
          end
          ["naof-secs", "record-distance", "utalisation", "link", "aux-link", "align-advise"].each_with_index do |record_source, site|
            if site < 2
              record[record_source] = components[site].to_i(16)
            elsif (site == 2) || (site == 3)
              record[record_source] = components[site].downcase
            else
              record[record_source] = components[site].to_i(10)
            end
          end
          if naof_source_sections > 0
            meta[source] += [record]
            record = {}
          end
          naof_source_sections += 1
        end
      elsif source == "loads"
        components = section.split(" ")
        not_interpreter_source = true
        slant_site = section.index("/")
        if slant_site
          not_interpreter_source = false
          meta["interpreter"] = section[slant_site..-2]
        elsif (components.length > 0) && (components[0] != "Type") && (components[0] != "FileSiz")
          if naof_source_sections >= 1
            if (naof_source_sections & 1) == 0
              ["category", "binary-site", "staging-site", "stack-site"].each_with_index do |record_source, site|
                if site == 0
                  record[record_source] = components[site].downcase
                else
                  record[record_source] = components[site].to_i(16)
                end
              end
            else
              et_site = components.length - 1
              components = components[0..1] + components[2..-2] + [components[-1]]
              components.each_with_index do |component, site|
                if site < 2
                  if site == 0
                    record["naof-secs"] = components[site].to_i(16)
                  else
                    record["naof-stack-secs"] = components[site].to_i(16)
                  end
                elsif site != et_site
                  record["access"] ||= []
									record["access"] += components[site].downcase.split("")
                else
                  record["align-advise"] = components[site]
                end
              end
              if naof_source_sections > 1
								record["access"] = record["access"].join(", ")
                meta[source] += [record]
                if (record["staging-site"] > record["binary-site"]) && (meta["expansion"] == nil)
                  meta["expansion"] = record["staging-site"] - record["binary-site"]
                end
                record = {}
              end
            end
          end
        end
        if not_interpreter_source
          naof_source_sections += 1
        end
      elsif source == "dynamic"
        if section.length > 0
          components = section.split(" ")
          if components[0] != "Tag"
            square_site = components[-1].index("[")
            if square_site
              components[1] = "lib-name"
              components[-1] = components[-1][(square_site + 1)..-2]
              components = components[0..1] + [components[-1]]
            end
            if components[1].index("(")
              components[1] = components[1][1..-2].downcase
            end
            is_number = false
            if components[2][0...2] == "0x"
              components[2] = components[2].to_i(16)
              is_number = true
            elsif components[2][0] && is_base10(components[2][0])
              components[2] = components[2].to_i
              is_number = true
            end
            record = {
              "category" => components[1],
              "category-code" => components[0][2..-1].to_i(16),
            }
            if is_number
              record["data"] = components[2]
            else
              record["data"] = components[2..-1]
            end
            if record["category-code"] != 0
              meta[source] += [record]
            end
          end
        end
      elsif (source == "rela-dyn") || (source == "rela-plt")
				naof_elements_for_sources[source] += 0
        components = section.split(" ")
        #puts "components | #{components}"
        naof_components = components.length
        if (naof_source_sections > 0) && (naof_components == 0)
          source = nil
        end
        if (naof_source_sections > 0) && (naof_components > 0)
          record = {
						"record-site" => naof_elements_for_sources[source]
					}
          record_sources = ["expansion-site", "category-meta", "category"]
          component_site = 0
          components[0..2].each do |component|
            record[record_sources[component_site]] = components[component_site];
            if component_site == 0
              record[record_sources[component_site]] = record[record_sources[component_site]].to_i(16)
            else
              record[record_sources[component_site]] = record[record_sources[component_site]].downcase
            end
            component_site += 1
          end
          if naof_components > 3
            if (components[component_site].length == 16) && (is_base16(components[component_site]))
              record["aux-source"] = components[component_site].to_i(16)
              component_site += 1
            end
            if naof_components <= naof_components
              et_component = components[component_site..-1].join(" ")
              record["source"] = et_component
            end
          end
          meta[source] += [record]
					naof_elements_for_sources[source] += 1
        end
        naof_source_sections += 1
      elsif (source == "dynsym") || (source == "symtab")
        components = section.split(" ")
        #puts "components | #{components}"
        naof_components = components.length
        if (naof_source_sections > 0) && (naof_components > 0)
          record = {}
          record_sources = ["", "stay-site", "naof-secs", "category", "location-category", "vissual", "dynamic-category"]
          component_site = 1
          components[1..6].each do |component|
            record[record_sources[component_site]] = components[component_site];
            if component_site == 1
              record[record_sources[component_site]] = record[record_sources[component_site]].to_i(16)
            else
              record[record_sources[component_site]] = record[record_sources[component_site]].downcase
            end
            component_site += 1
          end
          if naof_components > 6
            et_component = components[component_site..-1].join(" ")
            record["source"] = et_component
          end
					record["completion"] = record["stay-site"] + record["naof-secs"].to_i
          #puts "record | #{record}"
          meta[source] += [record]
        end
        naof_source_sections += 1
      elsif (source == "version-symbols")
        #puts "section | #{section}"
        components = section.split("(")
        #puts "components | #{components}"
        naof_components = components.length
        if (naof_source_sections > 0) && (naof_components > 0)
          section_site = (section.index(":") + 1)
          while true
            next_nao = section[section_site..-1].index("(")
            #puts "next-nao | #{next_nao}"
            if next_nao == nil
              break
            end
            record = {}
            nao_origin = (section_site + next_nao + 1)
            record["version-code"] = (section[section_site...nao_origin].strip).to_i(16)
            #puts "nao-origin | #{nao_origin}"
            nao_completion = section[(nao_origin)..-1].index(")")
            #puts "nao-completion | #{nao_completion}"
            record["version-source"] = section[nao_origin...(nao_origin + nao_completion)].downcase
            #puts "record | #{record}"
            #puts "section | #{section[section_site..-1]}"
            meta[source] += [record]
            section_site = (nao_origin + nao_completion + 1)
          end
        end
        naof_source_sections += 1
      elsif (source == "version-needs")
        components = section.split(" ")
        naof_components = components.length
        if (naof_source_sections > 0) && (naof_components > 0)
          if components[1] == "Version:"
            aux_source = components[4].downcase
            meta[source][aux_source] = []
          else
            meta[source][aux_source] += [{components[2].downcase => components[6].to_i(16)}]
          end
        elsif (naof_components == 0)
          source = nil
        end
        naof_source_sections += 1
      elsif (source == "version-definitions")
        components = section.split(" ")
        naof_components = components.length
        if (naof_source_sections > 0) && (naof_components > 0)
          if components[1] == "Parent"
          elsif components[4] == "BASE"
            aux_source = components[10].downcase
            meta[source][aux_source] = []
          elsif components[4] == "none"
            meta[source][aux_source] += [{components[10].downcase => components[6].to_i(16)}]
          end
        elsif (naof_components == 0)
          source = nil
        end
        naof_source_sections += 1
      end
    end
		ssite += 1
  end
  naof_sections = meta["sections"].length
  site = 0
  while true
    if site == naof_sections
      break
    end
    section = meta["sections"][site]
    section["binary-completion"] = (section["binary-node"] + section["naof-secs"])
    site += 1
  end
	meta["dynsym"] = meta["dynsym"].sort{|a,b| a["stay-site"] <=> b["stay-site"]}
  meta
end

def stage_libs(dls)
	naof_dls = dls.length
	#puts "dls | #{dls}"
	#puts "naof-dls | #{naof_dls}"
	site = 0
	while true
		if site == naof_dls
			break
		end
		dl = dls[site]
		if dl["category"] == "mmap-synced"
			do_name = dl["name"].gsub(".so.", ".do.")
			comand = "sf #{dl["name"]} #{do_name}"
			puts "comand | #{comand}"
			system(comand)
		end
		site += 1
	end
end

def unix_system_source(rax)
  unix_manafest = File::open("unix.h").read
  code_site = unix_manafest.index("#{rax}")
  if code_site == nil
    return "non-standard"
  end
  site = code_site - 2
  while true
    if unix_manafest[site] == ' '
      site += 1
      break
    end
    site -= 1
  end
  system_source = unix_manafest[site...code_site][5..-1].strip
  system_source
end

def get_asm_meta(binary_name)
	meta = {
		"binary-name" => binary_name,
		"segments" => [],
		"sections" => [],
		"asms" => [],
		"asms-index" => {},
		"regards" => {},
		"motions" => [],
		"from-tos" => []
	}
	from_her = `objdump -d #{binary_name}`
	segments = from_her.split("\n")
	segment_name = nil
	section_name = nil
	bs = nil # bs | binary-site
	first_section_sited = false
	next_is_aux = false
	asite = 0
	site = 0
	while true
		#log_heading("segment-site | #{site}")
		if next_is_aux
			next_is_aux = false
			site += 1
			next
		else
			is_aux_secs = false
		end
		nsegment = segments[site + 1]
		#puts "nsegment | #{nsegment}"
		if nsegment && nsegment.index(":")
			components = nsegment.split(" ")
			naof_components = components.length
			#puts "components | #{components}"

			bs = components[0].to_i(16)
			aux_secs = []
			csite = 1
			is_aux_secs = false
			while true
				comp = components[csite]
				if comp == nil
					is_aux_secs = true
					break
				end
				if comp.length != 2 || comp[0] == "j" || is_base16(comp) == false
					break
				end
				csite += 1
				aux_secs += [comp.to_i(16)]
			end
			#puts "aux-secs | #{aux_secs}"
			#puts "is-aux-secs | #{is_aux_secs}"
			next_is_aux = is_aux_secs
		end

		segment = segments[site]
		site += 1
		if segment == nil
			break
		end
		if segment == ""
			next
		end
		#if segment.index("15709b:") == nil
			#next
		#end
		#puts "segment-name | #{segment_name}"
		#puts "section-name | #{section_name}"
		#puts "segment | #{segment}"
		components = segment.split(" ")
		naof_components = components.length
		#puts "components | #{components}"
		if segment[0...22] == "Disassembly of section"
			segment_name = components[-1][0..-2]
			meta["segments"] += [{"name" => segment_name, "bs" => bs}]
			#puts "meta[\"segments\"][-1] | #{meta["segments"][-1]}"
			next
		elsif components[-1][0] == "<" && components[-1][-2..-1] == ">:"
			bs = components[0].to_i(16)
			section_name = components[-1][1..-3]
			meta["sections"] += [{"name" => section_name, "bs" => bs}]
			if first_section_sited == false
				meta["segments"][0]["bs"] = bs
			end
			#puts "meta[\"sections\"][-1] | #{meta["sections"][-1]}"
			next
		end
		if segment_name == nil || section_name == nil
			next
		end
		#break

		bs = components[0][0..-2].to_i(16)
		secs = []
		csite = 1
		while true
			comp = components[csite]
			if comp.length != 2 || comp[0] == "j" || is_base16(comp) == false
				break
			end
			csite += 1
			secs += [comp.to_i(16)]
		end
		#puts "secs | #{secs}"
		#puts "is-aux-secs | #{is_aux_secs}"
		if is_aux_secs
			secs += aux_secs
		end

		naof_secs = secs.length
		asm = {
			"bs" => bs,
			"completion" => (bs + naof_secs),
			"secs" => secs,
			"naof-secs" => naof_secs,
			"mod" => nil,
			"params" => nil,
			"destination" => nil,
			"source" => nil,
			"site" => asite
		}

		if components[-1][0] == "<"
			source = components[-1][1..-2]
			asm["source"] = source
			naof_components -= 1
		end

		#puts "components | #{components}"
		if components[naof_components - 2]  == "#"
			asm["destination"] = components[naof_components - 1].to_i(16)
			naof_components -= 2
		end

		asm["params"] = components[naof_components - 1]
		asm["mod"] = components[csite..(naof_components - 2)].join(" ")
		if asm["mod"] == ""
			asm["mod"] = asm["params"]
			asm["params"] = ""
		end
		if asm["params"] == "retq"
			asm["mod"] += " #{asm["params"]}"
			asm["params"] = ""
		end
		#puts "params | #{asm["params"]}"
		#puts "destination | #{asm["destination"]}"
		if asm["params"][0] != "*" && BinaryConstants::StayToAluModules.index(asm["mod"])
			asm["destination"] = asm["params"].to_i(16)
		end
		if asm["destination"]
			meta["regards"][asm["destination"]] ||= []
			meta["regards"][asm["destination"]] += [asm["bs"]]
			meta["motions"] += [asm["bs"]]
		end
		ft = from_to(asm)
		meta["from-tos"] += [ft]

		#view_one(asm)
		#if segment.index("2107b:")
			#break
		#end
		meta["asms"] += [asm]
		meta["asms-index"][asm["bs"]] = asite
		asite += 1
	end
	#view_vecter(meta["asms"])
	meta
end

def from_to(asm)
	#view_one(asm)
	params = asm["params"]
	if params == ""
		return [{}]
	end
	is_stay_to = false
	if BinaryConstants::StayToAluModules.index(asm["mod"])
		if asm["params"][0] != "*"
			return [{"constant" => asm["destination"]}]
		else
			is_stay_to = true
		end
	end
	section_sites = sites_aof(",", params)
	naof_section_sites = section_sites.length
	noom_open_sites = sites_aof("(", params)
	naof_noom_open_sites = noom_open_sites.length
	noom_close_sites = sites_aof(")", params)
	naof_noom_close_sites = noom_close_sites.length
	params_site = nil
	site = 0
	while true
		section_site = section_sites[site]
		site += 1
		if section_site == nil
			break
		end
		is_param_segmentiser = true
		nsite = 0
		while true
			noom_open_site = noom_open_sites[nsite]
			if noom_open_site == nil
				break
			end
			noom_close_site = noom_close_sites[nsite]
			nsite += 1
			if (section_site > noom_open_site) && (section_site < noom_close_site)
				is_param_segmentiser = false
				break
			end
		end
		if is_param_segmentiser
			params_site = section_site
			break
		end
	end
	#puts "section-site | #{section_site}"
	psecs = []
	if section_site
		from = params[0...section_site]
		to = params[(section_site + 1)..-1]
		psecs = [from, to]
	else
		from = params
		psecs = [from]
	end
	naof_psecs = psecs.length
	psec_names = ["from", "to"]
	from_to = []
	site = 0
	while true
		psec = psecs[site]
		if psec == nil
			break
		end
		pname = psec_names[site]
		site += 1
		record = {
			"name" => pname,
			"register" => nil,
			"constant" => nil,
			"naof-register" => nil,
			"naof-secs" => nil, # naof-secs-per-naof-register
			"aux-register" => nil,
			"is-dst" => false, # dst | dynamic-stay-to
			"stead" => "stead"
		}
		aux_register_site = psec.index(":")
		if aux_register_site
			record["aux-register"] = psec[0...aux_register_site][1..-1]
			psec = psec[(aux_register_site + 1)..-1]
		end
		if psec[0] == "*"
			psec = psec[1..-1]
			record["is-dst"] = true
		end
		#puts "psec | #{psec}"
		if psec[0] == "$"
			psec = psec[1..-1]
		end
		#puts "psec | #{psec}"
		is_positive = true
		if psec[0] == "-"
			is_positive = false
			psec = psec[1..-1]
		end
		if psec[0...2] == "0x"
			#puts "psec | #{psec}"
			psec = psec[2..-1]
			#puts "psec | #{psec}"
			constant_site = psec.index("(")
			if constant_site
				record["constant"] = psec[0...constant_site].to_i(16)
				psec = psec[constant_site..-1]
			else
				record["constant"] = psec[0..-1].to_i(16)
			end
			if is_positive == false
				record["constant"] = record["constant"] * -1
			end
			#puts "psec | #{psec}"
		end
		naof_secs = psec.length
		is_noom = false
		if naof_secs > 0
			if psec[0] == "("
				is_noom = true
				ssite = 0
				noom_names = ["register", "naof-register", "naof-secs"]
				#puts
				while true
					segment_site = psec.index(",")
					if segment_site
						segment = psec[0...segment_site]
						psec = psec[(segment_site + 1)..-1]
					else
						segment = psec
					end
					#puts "segment | #{segment}"
					register_sign_site = segment.index("%")
					if register_sign_site
						segment = segment[(register_sign_site + 1)..-1]
					else
						segment = segment.to_i
					end
					noom_name = noom_names[ssite]
					record[noom_name] = segment
					if record[noom_name][-1] == ")"
						record[noom_name] = record[noom_name][0..-2]
					end
					if ssite < 2
						rname = record[noom_name]
						#puts "rname | #{rname}"
						r64_name = BinaryConstants::register64_name(rname)
						if r64_name
							record[noom_name] = r64_name
						else
							record[noom_name] = rname
						end
					end
					if segment_site == nil
						break
					end
					ssite += 1
				end
			else
				#puts "psec | #{psec}"
				is_register_init = psec[0] == "%"
				rname = psec[1..-1]
				r64_name = BinaryConstants::register64_name(rname)
				if r64_name
					record["register"] = r64_name
				elsif is_register_init
					record["register"] = rname
				end
			end
		end
		#puts "psec | #{psec}"
		if is_stay_to
			if is_noom
				record["stead"] = "cast"
			end
		else
			if asm["mod"].index("lea") == nil
				if is_noom
					record["stead"] = "cast"
				end
			end
		end
		if record["aux-register"]
			record["stead"] = "cast"
		end
		#view_one(record)
		from_to += [record]
	end
	#puts
	from_to
end

def get_asm(asms_meta, bs)
	asite = asms_meta["asms-index"][bs]
	asms_meta["asms"][asite]
end
