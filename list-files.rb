#!/usr/bin/env ruby
require "./charts.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
	params_entree = "params | 1\n"
	params_entree += "1 | node-name\n"
	print params_entree
  return
end
node = params[0]
list = {}
sources = filter_node_nodes(Dir::entries(node))
naof_sources = sources.length
nsite = 0
while true
	if nsite == naof_sources
		break
	end
	name = sources[nsite]
	components = name.split(".")
	naof_components = components.length
	if (naof_components == 1)
		extension = "binary"
	elsif (components.index("so")) || (components.index("do"))
		extension = "library"
	else
		extension = components[-1]
	end
	list[extension] ||= []
	list[extension] += [{
		"name" => name,
		"extension" => extension
	}]
	nsite += 1
end
extensions = list.keys
naof_extensions = extensions.length
esite = 0
while true
	if esite == naof_extensions
		break
	end
	extension = extensions[esite]
	extension_list = list[extension]
	naof_in_extension = extension_list.length
	log_heading("#{extension} | #{naof_in_extension}")
	view_vecter(extension_list)
	esite += 1
end
