#!/usr/bin/env ruby
require "./core.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 3
  puts "params | 3"
  puts "1 | from-node"
  puts "2 | to-node"
  puts "3 | sources (vecter)"
  return
end
from_node = params[0]
if from_node[-1] != "/"
	from_node += "/"
end
to_node = params[1]
if to_node[-1] != "/"
	to_node += "/"
end
sources = params[2].gsub(" ", "")[1..-1].split(",")
naof_sources = sources.length
site = 0
while true
	if site == naof_sources
		break
	end
	source = sources[site]
	comand = "sf #{from_node}#{source} #{to_node}#{source}"
	puts "comand | #{comand}"
	system(comand)
	site += 1
end
