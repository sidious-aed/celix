#!/usr/bin/env ruby
require "./charts.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 2
  puts "params | 2"
  puts "1 | node"
  puts "2 | seek (/ld-linux/i)"
  return
end
node = params[0]
finds = Chart.new()
reg = /#{params[1]}/i
manafest = manafest_at(node)
naof_names = manafest.length
site = 0
while true
	if site == naof_names
		break
	end
	name = manafest[site]
	if name =~ reg
		directory = name.split("/")[0..-2].join("/")
		finds.add({
			"node" => directory,
			"name" => name,
			"naof-secs" => File::size(name)
		})
	end
	site += 1
end
if finds.naof_records > 0
	log_heading("finds")
	finds.view
end
