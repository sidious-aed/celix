require "./charts.rb"

class ElfConstants
	CodesForDynamicTypes = [0x1, 0xe, 0x4, 0x6ffffef5, 0x5, 0x6, 0xa, 0xb, 0x3, 0x2, 0x14, 0x17, 0x7, 0x8, 0x9, 0x6ffffffc, 0x6ffffffd, 0x6ffffff0, 0x6ffffff9]
	DynamicTypes = ["needed", "soname", "hash", "gnu-hash", "strtab", "symtab", "strsz", "syment", "pltgot", "pltrelsz", "pltrel", "jmprel", "rela", "relasz", "relaent", "verdef", "verdefnum", "versym", "relacount"]
	class << self
		def name_for_code(type_name, code)
			codes_micro_oracless = eval("ElfConstants::CodesFor#{type_name}")
			names_micro_oracless = eval("ElfConstants::#{type_name}")
			site = codes_micro_oracless.index(code)
			if site
				return names_micro_oracless[site]
			end
			nil
		end
	end
end

def ware_mana(ware_source)
  ware = File::open(ware_source, "rb").read.bytes
  mana = {"source" => ware_source}

  # ware_mana
  mana["stay-origin"] = number_aof(ware[24...32].reverse)
  mana["load-manas-origin"] = number_aof(ware[32...40].reverse)
  mana["section-manas-origin"] = number_aof(ware[40...48].reverse)
  mana["ware-manas-distance"] = number_aof(ware[52...54].reverse)
  mana["load-mana-distance"] = number_aof(ware[54...56].reverse)
  mana["naof-load-manas"] = number_aof(ware[56...58].reverse)
  mana["section-mana-distance"] = number_aof(ware[58...60].reverse)
  mana["naof-section-manas"] = number_aof(ware[60...62].reverse)
  mana["section-sources-site"] = number_aof(ware[62...64].reverse)

  # loads_manas
  mana["load-manas-distance"] = mana["naof-load-manas"] * mana["load-mana-distance"]
  mana["load-manas"] = []
  site = 0
  while true
    if site == mana["naof-load-manas"]
      break
    end
    load_mana = {}
    load_mana["site"] = site
    load_mana["origin"] = mana["load-manas-origin"] + (site * mana["load-mana-distance"])
    secs = ware[load_mana["origin"]...(load_mana["origin"] + mana["load-mana-distance"])]
    load_mana["secs"] = secs
    load_mana["category-cread"] = number_aof(secs[0...4].reverse)
    if load_mana["category-cread"] == 1
      load_mana["category"] = "load"
    end
    load_mana["ware-origin"] = number_aof(secs[8...16].reverse)
    load_mana["thread-origin"] = number_aof(secs[16...24].reverse)
    load_mana["stay-origin"] = number_aof(secs[24...32].reverse)
    load_mana["ware-distance"] = number_aof(secs[32...40].reverse)
    load_mana["ware-completion"] = load_mana["ware-origin"] + load_mana["ware-distance"]
    load_mana["stay-distance"] = number_aof(secs[40...48].reverse)
    mana["load-manas"] = mana["load-manas"] + [load_mana]
    site = site + 1
  end

  shstrtab_section_mana_origin = mana["section-manas-origin"] + (mana["section-sources-site"] * mana["section-mana-distance"])
  shstrtab_section_mana_secs = ware[shstrtab_section_mana_origin...(shstrtab_section_mana_origin + mana["section-mana-distance"])]
  shstrtab_ware_origin = number_aof(shstrtab_section_mana_secs[24...32].reverse)
  shstrtab_ware_distance = number_aof(shstrtab_section_mana_secs[32...40].reverse)
	shstrtab = ware[shstrtab_ware_origin...(shstrtab_ware_origin + shstrtab_ware_distance)].pack("c*")

	dynamic_section_site = nil
	rela_dyn_section_site = nil
	rela_plt_section_site = nil
	dynsym_section_site = nil
	dynstr_section_site = nil
	symtab_section_site = nil
	strtab_section_site = nil
  mana["section-manas"] = []
  site = 0
  while true
    if site == mana["naof-section-manas"]
      break
    end
    section_mana = {}
    section_mana["site"] = site
    section_mana["record-origin"] = mana["section-manas-origin"] + (site * mana["section-mana-distance"])
    secs = ware[section_mana["record-origin"]...(section_mana["record-origin"] + mana["section-mana-distance"])]
		#puts "secs | #{secs}"
		name_entree_site = number_aof(secs[0...4].reverse)
		completion_site = shstrtab[name_entree_site..-1].index("\x00")
		section_mana["name"] = shstrtab[name_entree_site...(name_entree_site + completion_site)]
    #section_mana["secs"] = secs
    section_mana["binary-node"] = number_aof(secs[24...32].reverse)
    section_mana["stack-node"] = number_aof(secs[16...24].reverse)
    section_mana["naof-secs"] = number_aof(secs[32...40].reverse)
    section_mana["binary-completion"] = section_mana["binary-node"] + section_mana["naof-secs"]
    section_mana["stack-completion"] = section_mana["stack-node"] + section_mana["naof-secs"]
    mana["section-manas"] += [section_mana]
		if section_mana["name"] == ".dynamic"
			dynamic_section_site = site
		elsif section_mana["name"] == ".rela.dyn"
			rela_dyn_section_site = site
		elsif section_mana["name"] == ".rela.plt"
			rela_plt_section_site = site
		elsif section_mana["name"] == ".dynsym"
			dynsym_section_site = site
		elsif section_mana["name"] == ".dynstr"
			dynstr_section_site = site
		elsif section_mana["name"] == ".symtab"
			symtab_section_site = site
		elsif section_mana["name"] == ".strtab"
			strtab_section_site = site
		end
    site += 1
  end

  if dynamic_section_site
		dynamic_section = mana["section-manas"][dynamic_section_site]
    dynamic_section_origin = dynamic_section["binary-node"]
    dynamic_section_distance = dynamic_section["naof-secs"]
    # dynammic section
    mana["dynamic-section-origin"] = dynamic_section_origin
    mana["dynamic-section-distance"] = dynamic_section_distance
    mana["naof-dynamic-manas"] = mana["dynamic-section-distance"] / 16
    mana["dynamic-manas"] = []
    site = 0
    while true
      if site == mana["naof-dynamic-manas"]
        break
      end
      dynamic_mana = {}
      dynamic_mana["site"] = site
      dynamic_mana["dynamic-mana-origin"] = mana["dynamic-section-origin"] + (site * 16)
      secs = ware[dynamic_mana["dynamic-mana-origin"]...(dynamic_mana["dynamic-mana-origin"] + 16)]
			#puts "secs | #{secs}"
      #dynamic_mana["secs"] = secs
      dynamic_mana["node"] = number_aof(secs[0...8].reverse)
			dynamic_mana["name"] = ElfConstants::name_for_code("DynamicTypes", dynamic_mana["node"])
      dynamic_mana["node2"] = number_aof(secs[8...16].reverse)
      mana["dynamic-manas"] = mana["dynamic-manas"] + [dynamic_mana]
      site = site + 1
    end
  end

  if rela_dyn_section_site
		rela_dyn_section = mana["section-manas"][rela_dyn_section_site]
    rela_dyn_section_origin = rela_dyn_section["binary-node"]
    rela_dyn_section_distance = rela_dyn_section["naof-secs"]
    # rela_dyn section
    mana["rela-dyn-section-origin"] = rela_dyn_section_origin
    mana["rela-dyn-section-distance"] = rela_dyn_section_distance
    mana["naof-rela-dyn-manas"] = mana["rela-dyn-section-distance"] / 24
    mana["rela-dyn-manas"] = []
    site = 0
    while true
      if site == mana["naof-rela-dyn-manas"]
        break
      end
      rela_dyn_mana = {}
      rela_dyn_mana["site"] = site
      rela_dyn_mana["record-origin"] = mana["rela-dyn-section-origin"] + (site * 24)
      secs = ware[rela_dyn_mana["record-origin"]...(rela_dyn_mana["record-origin"] + 24)]
      #rela_dyn_mana["secs"] = secs
      rela_dyn_mana["stack-site"] = number_aof(secs[0...8].reverse)
      rela_dyn_mana["types"] = number_aof(secs[8...16].reverse)
      rela_dyn_mana["to-site"] = number_aof(secs[16...24].reverse)
      #puts "secs | #{secs}"
      #puts "node | #{rela_dyn_mana["node"]}"
      mana["rela-dyn-manas"] = mana["rela-dyn-manas"] + [rela_dyn_mana]
      site = site + 1
    end
  end

  if rela_plt_section_site
		rela_plt_section = mana["section-manas"][rela_plt_section_site]
    rela_plt_section_origin = rela_plt_section["binary-node"]
    rela_plt_section_distance = rela_plt_section["naof-secs"]
    # rela_plt section
    mana["rela-plt-section-origin"] = rela_plt_section_origin
    mana["rela-plt-section-distance"] = rela_plt_section_distance
    mana["naof-rela-plt-manas"] = mana["rela-plt-section-distance"] / 24
    mana["rela-plt-manas"] = []
    site = 0
    while true
      if site == mana["naof-rela-plt-manas"]
        break
      end
      rela_plt_mana = {}
      rela_plt_mana["site"] = site
      rela_plt_mana["rela-plt-mana-origin"] = mana["rela-plt-section-origin"] + (site * 24)
      secs = ware[rela_plt_mana["rela-plt-mana-origin"]...(rela_plt_mana["rela-plt-mana-origin"] + 24)]
			#puts "secs | #{secs}"
      #rela_plt_mana["secs"] = secs
      rela_plt_mana["stack-site"] = number_aof(secs[0...8].reverse)
      rela_plt_mana["types"] = number_aof(secs[8...16].reverse)
      rela_plt_mana["to-site"] = number_aof(secs[16...24].reverse)
      mana["rela-plt-manas"] = mana["rela-plt-manas"] + [rela_plt_mana]
      site = site + 1
    end
  end

  if dynsym_section_site
		dynsym_section = mana["section-manas"][dynsym_section_site]
		dynstr_section = mana["section-manas"][dynstr_section_site]
		dynstr = ware[dynstr_section["binary-node"]...(dynstr_section["binary-completion"])].pack("c*")
    dynsym_section_origin = dynsym_section["binary-node"]
    dynsym_section_distance = dynsym_section["naof-secs"]
    # dynsym section
    mana["dynsym-section-origin"] = dynsym_section_origin
    mana["dynsym-section-distance"] = dynsym_section_distance
    mana["naof-dynsym-manas"] = mana["dynsym-section-distance"] / 24
    mana["dynsym-manas"] = []
    site = 0
    while true
      if site == mana["naof-dynsym-manas"]
        break
      end
      dynsym_mana = {}
      dynsym_mana["site"] = site
      dynsym_mana["dynsym-mana-origin"] = mana["dynsym-section-origin"] + (site * 24)
      secs = ware[dynsym_mana["dynsym-mana-origin"]...(dynsym_mana["dynsym-mana-origin"] + 24)]
			puts "secs | #{secs}"
      #dynsym_mana["secs"] = secs
      dynsym_mana["stack-site"] = number_aof(secs[8...16].reverse)
			dynstr_site = number_aof(secs[0...4].reverse)
			#puts "dynstr-site | #{dynstr_site}"
			#puts "dynstr | #{dynstr}"
			completion_site = (dynstr_site + dynstr[(dynstr_site..-1)].index("\x00"))
			dynsym_mana["name"] = dynstr[dynstr_site...completion_site]
      mana["dynsym-manas"] = mana["dynsym-manas"] + [dynsym_mana]
      site = site + 1
    end
  end

	dynsym_sourced_sections = ["rela-plt-manas", "rela-dyn-manas"]
	naof_dynsym_sourced_sections = dynsym_sourced_sections.length
	site = 0
	while true
		if site == naof_dynsym_sourced_sections
			break
		end
		section_name = dynsym_sourced_sections[site]
		if mana[section_name]
			naof_records = mana[section_name].length
			rsite = 0
			while true
				if rsite == naof_records
					break
				end
				record = mana[section_name][rsite]
				if record["to-site"] == 0
					types = record["types"]
					#puts "types | #{types}"
					types &= 0xffffffff00000000
					types >>= 32
					mana[section_name][rsite]["name"] = mana["dynsym-manas"][types]["name"]
				end
				rsite += 1
			end
		end
		site += 1
	end

  if symtab_section_site
		symtab_section = mana["section-manas"][symtab_section_site]
		strtab_section = mana["section-manas"][strtab_section_site]
		strtab = ware[strtab_section["binary-node"]...strtab_section["binary-completion"]].pack("c*")
    symtab_section_origin = symtab_section["binary-node"]
    symtab_section_distance = symtab_section["naof-secs"]
    # symtab section
    mana["symtab-section-origin"] = symtab_section_origin
    mana["symtab-section-distance"] = symtab_section_distance
    mana["naof-symtab-manas"] = mana["symtab-section-distance"] / 24
    mana["symtab-manas"] = []
    site = 0
    while true
      if site == mana["naof-symtab-manas"]
        break
      end
      symtab_mana = {}
      symtab_mana["site"] = site
      symtab_mana["symtab-mana-origin"] = mana["symtab-section-origin"] + (site * 24)
      secs = ware[symtab_mana["symtab-mana-origin"]...(symtab_mana["symtab-mana-origin"] + 24)]
      #symtab_mana["secs"] = secs
      symtab_mana["node"] = number_aof(secs[8...16].reverse)
			name_site = number_aof(secs[0...4].reverse)
			completion_site = (name_site + strtab[name_site..-1].index("\x00"))
			symtab_mana["name"] = strtab[name_site...completion_site]
      mana["symtab-manas"] = mana["symtab-manas"] + [symtab_mana]
      site = site + 1
    end
  end
  mana
end
