#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 2
  puts "params | 2"
	puts "1 | secs-name"
  puts "2 | binary-name"
  return
end
secs_name = params[0]
binary_name = params[1]
comand = "sf libc.so.6 #{binary_name}"
puts "comand | #{comand}"
system(comand)
comand = "./place #{secs_name} #{binary_name} 21360"
puts "comand | #{comand}"
system(comand)
