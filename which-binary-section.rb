#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 2
  puts "params | 2"
  puts "1 | binary-path"
  puts "2 | binary-site"
  return
end

binary_path = params[0]
binary_site = params[1].to_i(16)
meta = get_binary_meta(binary_path)
naof_sections = meta["sections"].length
log_heading("sections")
site = 0
while true
  if site == naof_sections
    break
  end
  section = meta["sections"][site]
	#puts "section | #{section}"
	#print_hash_vecter([section])
  if (binary_site >= section["binary-node"]) && (binary_site < section["binary-completion"])
		in_sections = true
		puts "in section | #{section["source"]}"
  elsif (binary_site == section["binary-completion"])
		puts "at section-completion | #{section["source"]}"
  end
	next_section = meta["sections"][(site + 1)]
	if next_section
		if (binary_site >= section["binary-completion"]) && (binary_site < next_section["binary-node"])
			in_sections = true
			puts "in between sections | #{section["source"]} and #{next_section["source"]}"
		end
	end
  site += 1
end
puts

log_heading("loads")
loads = []
naof_loads = meta["loads"].length
site = 0
while true
  if site == naof_loads
    break
  end
  record = meta["loads"][site]
	#puts "load | #{load}"
	#print_hash_vecter([load])
	if binary_site >= record["binary-site"] && binary_site < record["binary-completion"]
		record["in-type"] = "binary-sites"
		loads += [record]
	elsif binary_site >= record["stack-site"] && binary_site < record["stack-completion"]
		record["in-type"] = "stack-sites"
		loads += [record]
	elsif binary_site == record["stack-completion"]
		record["in-type"] = "at-stack-completion"
		loads += [record]
	end
  site += 1
end
view_vecter(loads)

log_heading("dynsyms")
dynsyms = []
naof_dynsyms = meta["dynsym"].length
site = 0
while true
  if site == naof_dynsyms
    break
  end
  dynsym = meta["dynsym"][site]
	#puts "dynsym | #{dynsym}"
	#print_hash_vecter([dynsym])
	if binary_site >= dynsym["stay-site"] && (binary_site < dynsym["completion"])
		dynsym["in-type"] = "dynsym-sites"
		dynsyms += [dynsym]
	elsif (binary_site == dynsym["completion"])
		dynsym["in-type"] = "at-dynsym-completion"
		dynsyms += [dynsym]
	end
  site += 1
end
view_vecter(dynsyms)
