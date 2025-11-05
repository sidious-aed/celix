#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 4
  puts "params | 4"
  puts "1 | binary-name"
	puts "2 | binary-site-1 (base-16)"
	puts "3 | binary-site-2 (base-16)"
	puts "4 | binary-comand"
  return
end
binary_name = params[0]
binary_site_1 = params[1].to_i(16)
binary_site_2 = params[2].to_i(16)
binary_comand = params[3]
time_1_name = "droid/time-1.quads"
bc = BinaryClerk.new(binary_name)
bc.engage_slots
comand = "./sequences assemblies/gt.asm secs/gt.secs 0 #{time_1_name}"
puts "comand | #{comand}"
system(comand)
bc.inject("secs/gt.secs", binary_name, binary_site_1)
time_2_name = "droid/time-2.quads"
comand = "./sequences assemblies/gt.asm secs/gt.secs 0 #{time_2_name}"
puts "comand | #{comand}"
system(comand)
bc.inject("secs/gt.secs", binary_name, binary_site_1)
bc.write(binary_name)
comand = binary_comand
puts "comand | #{comand}"
system(comand)
bar1 = time_bar_from_gt(time_1_name)
bar2 = time_bar_from_gt(time_2_name)
if bar1 >= bar2
	puts "order | #{binary_site_1.to_s(16)} <--> #{binary_site_2.to_s(16)}"
	diff = bar1 - bar2
	puts "elapsed | #{diff}"
else
	puts "order | #{binary_site_2.to_s(16)} <--> #{binary_site_1.to_s(16)}"
	diff = bar2 - bar1
	puts "elapsed | #{diff}"
end
