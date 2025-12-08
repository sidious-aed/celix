#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | file-name"
  return
end
file_name = params[0]
naof_quads = File::size(file_name) / 8
file = File::open(file_name)
quads = []
qsite = 0
while true
	if qsite == naof_quads
		break
	end
	quad = number_aof(file.read(8).bytes.reverse)
	if quad != 0
		quad = {
			"number" => quad,
			"site" => qsite,
			"in-file-site" => (qsite * 8)
		}
		quads += [quad]
	end
	qsite += 1
end
view_vecter(quads)
