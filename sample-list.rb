#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 4
  puts "params | 4-5"
  puts "1 | binary-file"
  puts "2 | asm-list (charts/asm-lists/io.so.9-full.asm-list)"
	puts "3 | binary-comand"
	puts "4 | samples-node"
  return
end
binary_name = params[0]
asm_list = params[1]
if File::exists?(asm_list) == false
	puts "<--> | could not find #{asm_list}"
	return
end
asm_list = eval(File::open(asm_list).read)
naof_asms = asm_list.length
binary_comand = params[2]
samples_node = params[3]
if samples_node[-1] != "/"
	samples_node += "/"
end
if File::exists?(samples_node) == false
	comand = "cn #{samples_node}"
	puts "comand | #{comand}"
	system(comand)
end
bc = BinaryClerk.new(binary_name)
site = 0
while true
	if site == naof_asms
		break
	end
	binary_site = asm_list[site]
	sample_asm(bc, binary_name, binary_site, binary_comand, samples_node)
	site += 1
end
