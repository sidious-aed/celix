#!/usr/bin/env ruby
require "./binary-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 3
  puts "params | 3"
  puts "1 | binary-name"
	puts "2 | binary-sites (vecter)"
	puts "3 | binary-comand"
  return
end
binary_name = params[0]
binary_sites = eval(params[1])
puts "binary-sites | #{binary_sites}"
naof_sites = binary_sites.length
binary_comand = params[2]
secs_name = "secs/i-sim-entree.secs"
bc = BinaryClerk.new(binary_name)
asms = []
init_entree = "i-sim-1"
com_entree = "i-sim-2"
site = 0
while true
	if site == naof_sites
		break
	end
	bs = binary_sites[site]
	asm = bc.get_asm(binary_name, bs)
	bc.engage_slots
	comand = "./sequences assemblies/i-sim-entree.asm #{secs_name} 0 #{init_entree} 7"
	puts "comand | #{comand}"
	system(comand)
	bc.inject(secs_name, binary_name, bs)
	bc.write(binary_name)
	comand = binary_comand
	puts "comand | #{comand}"
	result = `#{comand}`
	init_sites = sites_aof(init_entree, result)
	naof_ssites = init_sites.length
	puts "naof-ssites | #{naof_ssites}"
	ssite = 0
	while true
		if ssite == naof_ssites
			break
		end
		casm = poly_clone(asm)
		casm["os"] = ssite # ocurance-site
		casm["naof-inits"] = 0
		casm["site"] = 0
		asms += [casm]
		ssite += 1
	end
	site += 1
end
#view_vecter(asms)
#return
naof_asms = asms.length
et = naof_asms - 1
site = 0
while true
	if site == et
		break
	end
	puts "site | #{site}"
	asm1 = asms[site]
	#view_one(asm1)
	bs1 = asm1["bs"]
	puts "bs1 | #{bs1}"
	ssite = site + 1
	while true
		if ssite == naof_asms
			break
		end
		puts "ssite | #{ssite}"
		asm2 = asms[ssite]
		#view_one(asm2)
		bs2 = asm2["bs"]
		puts "bs2 | #{bs2}"
		log_heading("time compair between #{bs1.to_s(16)} and #{bs2.to_s(16)}")
		#if bs1 == 0x1b7dc || bs2 == 0x1b7dc
			#$stdin.gets
		#end
		if bs1 != bs2
			bc.engage_slots
			comand = "./sequences assemblies/i-sim-entree.asm #{secs_name} 0 #{init_entree} 7"
			puts "comand | #{comand}"
			system(comand)
			bc.inject(secs_name, binary_name, bs1)
			comand = "./sequences assemblies/i-sim-entree.asm #{secs_name} 0 #{com_entree} 7"
			puts "comand | #{comand}"
			system(comand)
			bc.inject(secs_name, binary_name, bs2)
			bc.write(binary_name)
			comand = binary_comand
			puts "comand | #{comand}"
			result = `#{comand}`
			puts "result | #{result}"
			init_sites = sites_aof(init_entree, result)
			puts "init-sites | #{init_sites}"
			com_sites = sites_aof(com_entree, result)
			puts "com-sites | #{com_sites}"
			if init_sites[asm1["os"]] < com_sites[asm2["os"]]
				asms[site]["naof-inits"] += 1
			else
				asms[ssite]["naof-inits"] += 1
			end
		else
			asms[site]["naof-inits"] += 1
			#$stdin.gets
		end
		#asms.sort!{|a,b| b["naof-inits"] <=> a["naof-inits"]}
		#view_vecter(poly_clone(asms))
		#$stdin.gets
		ssite += 1
	end
	site += 1
end
asms.sort!{|a,b| b["naof-inits"] <=> a["naof-inits"]}
site = 0
while true
	if site == naof_asms
		break
	end
	asms[site]["site"] = site
	site += 1
end
view_vecter(asms)
