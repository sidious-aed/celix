#!/usr/bin/env ruby
require "./binary-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 3
  puts "params | 3"
	puts "1 | secs-name"
  puts "2 | binary-name"
	puts "3 | binary-site (base-16)"
  return
end
secs_name = params[0]
binary_name = params[1]
binary_site = params[2].to_i(16)
bc = BinaryClerk.new(binary_name)
bc.engage_slots
bc.inject(secs_name, binary_name, binary_site)
bc.write(binary_name)
