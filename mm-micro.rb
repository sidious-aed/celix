#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 5
  puts "params | 5"
  puts "1 | binary-file"
  puts "2 | binary-site (base-16)"
	puts "3 | ocurance-site (base-16)"
	puts "4 | mm-site (base-16)"
	puts "5 | binary-comand"
  return
end
binary_name = params[0]
binary_site = params[1].to_i(16)
ocurance_site = params[2].to_i(16)
mm_site = params[3].to_i(16)
binary_comand = params[4]

bc = BinaryClerk.new(binary_name)
bc.engage_slots
slotb16 = bc.slots[binary_name]["slot"].to_s(16)
comand = "./write-quad ocurance.meta 0"
puts "comand | #{comand}"
system(comand)
comand = "./sequences assemblies/mm-micro.asm secs/mm-micro.secs #{slotb16} #{ocurance_site.to_s(16)} #{mm_site.to_s(16)}"
puts "comand | #{comand}"
system(comand)
#$stdin.gets
bc.inject("secs/mm-micro.secs", binary_name, binary_site)
bc.write(binary_name)
comand = binary_comand
puts "comand | #{comand}"
system(comand)
mm_file_name = "droid/micro.secs"
asm = bc.get_asm(binary_name, binary_site)
from_to = asm.delete("from-to")
puts
view_vecter([asm])
if File::exists?(mm_file_name)
	mm_secs_file = File::open(mm_file_name)
	zero_stay = number_aof(mm_secs_file.read(8).bytes.reverse)
	mm_secs = mm_secs_file.read(0x20).bytes
	log_heading("ymm#{mm_site.to_s}-secs")
	puts "zero-stay | #{zero_stay.to_s(16)}"
	puts "mm-secs | #{mm_secs}"
	puts "mm-entree | #{mm_secs.pack("c*")}"
	quads = []
	site = 0
	while true
		if site == 4
			break
		end
		qsite = site * 8
		quad = number_aof(mm_secs[qsite...(qsite + 8)].reverse)
		fz_site = quad - zero_stay
		quads += [{
			"quad" => quad,
			"fz-site" => fz_site
		}]
		site += 1
	end
	view_vecter(quads)
else
	log_heading("did not stay injected asm the system results instead | #{$?}")
end
