#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 4
  puts "params | 4-5"
  puts "1 | binary-file"
  puts "2 | binary-site (base-16)"
	puts "3 | binary-comand"
	puts "4 | samples-node"
	puts "(5) | aux-spaces (rip|+229a0b*|100^rbp|-100|100)"
  return
end
binary_name = params[0]
binary_site = params[1].to_i(16)
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
aux_spaces = params[4]
bc = BinaryClerk.new(binary_name)
sample_asm(bc, binary_name, binary_site, binary_comand, samples_node, aux_spaces)
