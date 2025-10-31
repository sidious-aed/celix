#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | binary-name"
  return
end
binary_name = params[0]
stays_chart_name = "charts/i-sim/#{binary_name}-stays.chart"
asm_list_chart_name = "charts/asm-lists/#{binary_name}-full.asm-list"
if File::exists?(stays_chart_name) == false
	puts "<--> | could not find i-sim chart #{stays_chart_name}"
	return
end
chart = eval(File::open(stays_chart_name).read)
naof_elements = chart.length
asms = []
site = 0
while true
	if site == naof_elements
		break
	end
	asms += [chart[site]["bs"].to_i(16)]
	site += 1
end
file = File::open(asm_list_chart_name, "w")
file.write(asms)
file.close
