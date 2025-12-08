#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 4
  puts "params | 4-6"
  puts "1 | binary-file"
  puts "2 | binary-site (base-16)"
	puts "3 | binary-comand"
	puts "4 | samples-node"
	puts "(5) | aux-spaces (rip|+229a0b*|100^rbp|-100|100)"
	puts "(6) | ocurance-site (base-16)"
  return
end
binary_name = params[0]
binary_site = params[1].to_i(16)
binary_comand = params[2]
samples_node = params[3]
ocurance_site = nil
if params[5]
	ocurance_site = params[5].to_i(16)
end
if samples_node[-1] != "/"
	samples_node += "/"
end
if File::exists?(samples_node) == false
	comand = "cn #{samples_node}"
	puts "comand | #{comand}"
	system(comand)
end
aux_spaces = params[4]
puts "initialising binary-clerk"
bc = BinaryClerk.new(binary_name)
puts "complete"
puts "sampling"
#return
sample_asm(bc, binary_name, binary_site, binary_comand, samples_node, aux_spaces)
if ocurance_site
	sample_names = samples_for(samples_node, binary_name, binary_site)
	sample_name = sample_names[ocurance_site]
	sample = eval(File::open(sample_name).read)
	log_heading("sample | #{ocurance_site.to_s(16)}")
	view_sample(sample, ocurance_site, true)
	puts "sample-name | #{sample_name}"
end
puts "complete"
