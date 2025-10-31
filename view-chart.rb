#!/usr/bin/env ruby
require "./charts.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | chart-name"
  return
end
chart_name = params[0]
if File::exists?(chart_name) == false
	puts "<--> | could not find chart #{chart_name}"
	return
end
chart = eval(File::open(chart_name).read)
cv = Chart.new
cv.engage_pause
cv.add_vecter(chart)
cv.view
