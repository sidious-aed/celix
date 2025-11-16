#!/usr/bin/env ruby
require "./sat.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 2
  puts "params | 2"
  puts "1 | node"
	puts "2 | filter"
  return
end
node = params[0]
filter = params[1]
manafest = filter_node_nodes(Dir::entries(node))
#puts "manafest | #{manafest}"
naof_files = manafest.length
files = []
site = 0
while true
	if site == naof_files
		break
	end
	file = manafest[site]
	site += 1
	if File::directory?(file) == true
		next
	end
	#puts "file | #{file}"
	if File::size(file) > 0
		header = File::open(file).read(7).bytes
		if header == [127, 69, 76, 70, 2, 1, 1]
			puts "clerical note | skipping past #{file} categorised elf-binary."
			next
		end
	end
	comand = "grep \"#{filter}\" #{file}"
	result = `#{comand}`
	if result != ""
		files += [{"name" => file}]
		puts
		puts "#{file}"
		naof_secs = file.length
		header = "-" * naof_secs
		puts header
		puts result
		puts
	else
		#puts "\"#{result}\""
		#return
	end
end
puts "complete"
view_vecter(files)
