#!/usr/bin/env ruby
require "./binary-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 3
  puts "params | 3"
  puts "1 | binary-name"
	puts "2 | binary-site-1 (base-16)"
	puts "3 | binary-site-2 (base-16)"
  return
end
binary_name = params[0]
binary_site_1 = params[1].to_i(16)
binary_site_2 = params[2].to_i(16)
secs_name = "secs/i-sim-entree.secs"
bc = BinaryClerk.new(binary_name)
bc.engage_slots
comand = "./sequences assemblies/i-sim-entree.asm secs/i-sim-entree.secs 0 \"i-sim-1\n\" 8"
puts "comand | #{comand}"
system(comand)
bc.inject(secs_name, binary_name, binary_site_1)
comand = "./sequences assemblies/i-sim-entree.asm secs/i-sim-entree.secs 0 \"i-sim-2\n\" 8"
puts "comand | #{comand}"
system(comand)
bc.inject(secs_name, binary_name, binary_site_2)
bc.write(binary_name)
