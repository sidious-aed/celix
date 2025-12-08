#!/usr/bin/env ruby
require "./segments-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 6
  puts "params | 6"
  puts "1 | samples-node"
  puts "2 | binary-name"
  puts "3 | binary-site (base-16)"
  puts "4 | ocurance-site (base-16)"
  puts "5 | segment-node"
	puts "6 | et-binary-site (base-16)"
  return
end
samples_node = params[0]
binary_name = params[1]
binary_site = params[2].to_i(16)
ocurance_site = params[3].to_i(16)
segment_node = params[4]
if segment_node[-1] != "/"
	segment_node += "/"
end
#puts "segment-node | #{segment_node}"
if File::exists?(segment_node) == false
	comand = "cn #{segment_node}"
	puts "comand | #{comand}"
	system(comand)
else
	clear_bin(segment_node, ["sample-meta"])
end
et_binary_site = nil
if params[5]
	et_binary_site = params[5].to_i(16)
end
bc = BinaryClerk.new(binary_name)
sc = SegmentsClerk.new(samples_node, binary_name, binary_site, ocurance_site, segment_node, et_binary_site)
see_site = 0
while true
	#if see_site != 0 && sc.binary_site == et_binary_site
		#break
	#end
	log_heading("binary-site | #{sc.binary_site.to_s(16)}")
	sample_name = sc.sample_at
	puts "sample-name | #{sample_name}"
	sample = eval(File::open(sample_name).read)
	asm = bc.get_asm(binary_name, sc.binary_site)
	asm["os"] = sc.ocurance_site
	sample["asm"] = asm
	from_to = bc.ametas[binary_name]["from-tos"][asm["site"]]
	sample["from-to"] = from_to
	sample_name = sample_name.split("/")[-1]
	sample_name = "#{segment_node}#{see_site.to_s(16)}-#{sample_name}"
	puts "sample-name | #{sample_name}"
	chart = File::open(sample_name, "w")
	chart.write(sample)
	chart.close
	if sc.next
		break
	end
	#break
	see_site += 1
end
