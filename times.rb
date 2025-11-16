#!/usr/bin/env ruby
require "./core.rb"
require "./sat.rb"

# set-with-if vs set-if-non
init_time = Time.now.to_f
x = nil
1000000.times do
	if x == nil
		x = 7
	end
end
com_time = Time.now.to_f
set_with_if_elapsed = com_time - init_time
init_time = Time.now.to_f
x = nil
1000000.times do
	x ||= 7
end
com_time = Time.now.to_f
set_if_non_elapsed = com_time - init_time
log_heading("set-with-if vs set-if-non")
puts "set-with-if   | #{set_with_if_elapsed}"
puts "set-if-non    | #{set_if_non_elapsed}"

# nil? vs == nil
init_time = Time.now.to_f
1000000.times do
	x = nil.nil?
end
com_time = Time.now.to_f
nil_elapsed = com_time - init_time
init_time = Time.now.to_f
1000000.times do
	x = nil == nil
end
com_time = Time.now.to_f
equals_nil_elapsed = com_time - init_time
log_heading("nil? vs == nil")
puts "nil?   | #{nil_elapsed}"
puts "== nil | #{equals_nil_elapsed}"

# tyrany vs wade
init_time = Time.now.to_f
1000000.times do |i|
	x = i > 23678 ? i - 23678 : i
end
com_time = Time.now.to_f
tyrany_elapsed = com_time - init_time
init_time = Time.now.to_f
1000000.times do |i|
	#x = nil
	if i > 23678
		x = i - 23678
	else
		x = i
	end
end
com_time = Time.now.to_f
wade_elapsed = com_time - init_time
log_heading("tyrany vs wade")
puts "tyrany | #{tyrany_elapsed}"
puts "wade   | #{wade_elapsed}"

# inject vs while
vecter = (0...1000000).to_a
init_time = Time.now.to_f
inject_sum = vecter.inject(0){|r,v| r += v}
com_time = Time.now.to_f
inject_elapsed = com_time - init_time
init_time = Time.now.to_f
site = 0
while_sum = 0
while true
	if site == 1000000
		break
	end
	while_sum += vecter[site]
	site += 1
end
com_time = Time.now.to_f
while_elapsed = com_time - init_time
log_heading("inject vs while")
puts "inject-sum | #{inject_sum}"
puts "while-sum  | #{while_sum}"
puts "inject | #{tyrany_elapsed}"
puts "while  | #{wade_elapsed}"

# droid-select vs while
vecter = (0...1000000).to_a.map{|e| {"a" => e}}
init_time = Time.now.to_f
sites = droid_select(vecter, lambda{|e| e["a"] == 111})
com_time = Time.now.to_f
droid_select_elapsed = com_time - init_time
puts "sites | #{sites}"
init_time = Time.now.to_f
naof_elements = vecter.length
sites = []
site = 0
while true
	if site == naof_elements
		break
	end
	element = vecter[site]
	if element["a"] == 111
		sites += [site]
	end
	site += 1
end
com_time = Time.now.to_f
while_elapsed = com_time - init_time
puts "sites | #{sites}"
log_heading("droid-select vs while")
puts "droid-select | #{droid_select_elapsed}"
puts "while        | #{wade_elapsed}"

# droid-select vs select
vecter = (0...1000000).to_a.map{|e| {"a" => e}}
init_time = Time.now.to_f
sites = droid_select(vecter, lambda{|e| e["a"] == 111})
com_time = Time.now.to_f
droid_select_elapsed = com_time - init_time
puts "sites | #{sites}"
init_time = Time.now.to_f
sites = []
site = 0
vecter.select do |e|
	cmp = e["a"] == 111
	if cmp
		sites += [site]
	end
	site += 1
	cmp
end
com_time = Time.now.to_f
select_elapsed = com_time - init_time
puts "sites | #{sites}"
log_heading("select vs while")
puts "droid-select | #{droid_select_elapsed}"
puts "select       | #{select_elapsed}"

# each vs while
vecter = (0...1000000).to_a
init_time = Time.now.to_f
sum = 0
vecter.each do |element|
	sum += element
end
com_time = Time.now.to_f
each_elapsed = com_time - init_time
puts "sum | #{sum}"
init_time = Time.now.to_f
sum = 0
site = 0
while true
	if site == 1000000
		break
	end
	element = vecter[site]
	sum += element
	site += 1
end
com_time = Time.now.to_f
while_elapsed = com_time - init_time
puts "sum | #{sum}"
puts "sites | #{sites}"
log_heading("each vs while")
puts "each   | #{droid_select_elapsed}"
puts "while  | #{select_elapsed}"

# flatten vs while
vecter = (0...1000).to_a.map{|e| (0...100).to_a}
init_time = Time.now.to_f
vecter = vecter.flatten
com_time = Time.now.to_f
flatten_elapsed = com_time - init_time
#puts "vecter | #{vecter}"
site = 0
vecter = (0...1000).to_a.map{|e| (0...100).to_a}
init_time = Time.now.to_f
while true
	if site == 1000
		break
	end
	vecter += vecter[site]
	site += 1
end
vecter = vecter[1000..-1]
com_time = Time.now.to_f
while_elapsed = com_time - init_time
#puts "vecter | #{vecter}"
log_heading("flatten vs while")
puts "flatten | #{flatten_elapsed}"
puts "while   | #{while_elapsed}"

# while vs access
vecter = (0...1000).to_a.map{|e| {"name" => "#{e}", "number" => rand(1000)}}
vecter += (0...1000).to_a.map{|e| {"name" => "#{e}", "number" => rand(1000)}}
vecter += (0...1000).to_a.map{|e| {"name" => "#{e}", "number" => rand(1000)}}
hash = {}
naof_elements = vecter.length
site = 0
while true
	if site == naof_elements
		break
	end
	element = vecter[site]
	hash[element["name"]] ||= []
	hash[element["name"]] += [element["number"]]
	site += 1
end
sources = hash.keys.uniq
naof_sources = sources.length
naof_elements = vecter.length
init_time = Time.now.to_f
site = 0
while true
	if site == naof_sources
		break
	end
	name = sources[site]
	sum = 0
	esite = 0
	while true
		if esite == naof_elements
			break
		end
		element = vecter[esite]
		if element["name"] == name
			sum += element["number"]
		end
		esite += 1
	end
	site += 1
end
com_time = Time.now.to_f
while_elapsed = com_time - init_time
#puts "vecter | #{vecter}"
init_time = Time.now.to_f
site = 0
while true
	if site == naof_elements
		break
	end
	element = vecter[site]
	hash[element["name"]] ||= []
	hash[element["name"]] += [element["number"]]
	site += 1
end
sources = hash.keys.uniq
site = 0
while true
	if site == naof_sources
		break
	end
	name = sources[site]
	sum = 0
	elements = hash[name]
	#puts "elements | #{elements}"
	naof_elements = elements.length
	esite = 0
	while true
		if esite == naof_elements
			break
		end
		element = elements[esite]
		sum += element
		esite += 1
	end
	site += 1
end
vecter = vecter[1000..-1]
com_time = Time.now.to_f
access_elapsed = com_time - init_time
#puts "vecter | #{vecter}"
log_heading("flatten vs while")
puts "while    | #{while_elapsed}"
puts "access   | #{access_elapsed}"

# asign vs explicit-method
vecter = (0...1000).to_a.map{|e| (0...100).to_a.map{|e| rand(256)}}
naof_elements = vecter.length
init_time = Time.now.to_f
site = 0
while true
	if site == naof_elements
		break
	end
	vecter[site] = vecter[site].sort{|a,b| a <=> b}
	site += 1
end
com_time = Time.now.to_f
asign_elapsed = com_time - init_time
vecter = (0...1000).to_a.map{|e| (0...100).to_a.map{|e| rand(256)}}
naof_elements = vecter.length
init_time = Time.now.to_f
site = 0
while true
	if site == naof_elements
		break
	end
	vecter[site].sort!{|a,b| a <=> b}
	site += 1
end
com_time = Time.now.to_f
explicit_method_elapsed = com_time - init_time
#puts "vecter | #{vecter}"
log_heading("asign vs explicit-method")
puts "asign             | #{asign_elapsed}"
puts "explicit-method   | #{explicit_method_elapsed}"
