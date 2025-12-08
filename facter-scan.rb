#!/usr/bin/env ruby
require "./segments-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 4
  puts "params | 4"
  puts "1 | samples-node"
  puts "2 | binary-name"
  puts "3 | binary-site (base-16)"
  puts "4 | ocurance-site (base-16)"
  return
end
samples_node = params[0]
if samples_node[-1] != "/"
	samples_node += "/"
end
scan_facters = []
binary_name = params[1]
binary_site = params[2].to_i(16)
bsb16 = binary_site.to_s(16)
ocurance_site = params[3].to_i(16)
at_node = "#{samples_node}#{binary_name}-#{bsb16}/"
sources = filter_node_nodes(Dir::entries(at_node))
naof_sources = sources.length
at_samples = []
site = 0
while true
	if site == naof_sources
		break
	end
	name = sources[site]
	components = name.split(".")
	if components[-1] == "sample-meta"
		at_samples += [name]
	end
	site += 1
end
at_samples.sort! do |a,b|
	puts "a | #{a}"
	acomponents = a.split(".")
	atime = "#{acomponents[1].to_i(16)}.#{acomponents[2].to_i(16)}".to_f
	puts "b | #{b}"
	bcomponents = b.split(".")
	btime = "#{bcomponents[1].to_i(16)}.#{bcomponents[2].to_i(16)}".to_f
	atime <=> btime
end
naof_samples = at_samples.length
site = 0
while true
	if site == naof_samples
		break
	end
	name = at_samples[site]
	name = "#{at_node}#{name}"
	at_samples[site] = name
	site += 1
end
at_sample_name = at_samples[ocurance_site]
puts "at-sample-name | #{at_sample_name}"
at_sample = eval(File::open(at_sample_name).read)
#puts "at-sample | #{at_sample}"
#$stdin.gets
sources = filter_node_nodes(Dir::entries(samples_node))
naof_sources = sources.length
site = 0
while true
	if site == naof_sources
		break
	end
	node_name = "#{samples_node}#{sources[site]}/"
	node_sources = filter_node_nodes(Dir::entries(node_name))
	naof_node_sources = node_sources.length
	samples = []
	ssite = 0
	while true
		if ssite == naof_node_sources
			break
		end
		name = node_sources[ssite]
		components = name.split(".")
		if components[-1] == "sample-meta"
			samples += [name]
		end
		ssite += 1
	end
	samples.sort! do |a,b|
		acomponents = a.split(".")
		atime = "#{acomponents[1].to_i(16)}.#{acomponents[2].to_i(16)}".to_f
		bcomponents = b.split(".")
		btime = "#{bcomponents[1].to_i(16)}.#{bcomponents[2].to_i(16)}".to_f
		atime <=> btime
	end
	naof_samples = samples.length
	if naof_samples > 0
		asm_name = "#{node_name}asm.meta"
		asm = eval(File::open(asm_name).read)
	end
	ssite = 0
	while true
		if ssite == naof_samples
			break
		end
		name = "#{node_name}#{samples[ssite]}"
		puts "name | #{name}"
		sample = eval(File::open(name).read)
		facters = SegmentsClerk::facters_for_samples_compair(at_sample, sample)
		facters["bs"] = asm["bs"]
		facters["os"] = ssite
		scan_facters += [facters]
		ssite += 1
	end
	#puts "scan-facters | #{scan_facters}"
	#$stdin.gets
	site += 1
end
scan_facters.sort!{|a,b| b["registers"] <=> a["registers"]}
scan_facters = scan_facters[0...200]
view_vecter(scan_facters)
