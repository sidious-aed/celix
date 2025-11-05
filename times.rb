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
puts "set-if-non | #{set_if_non_elapsed}"

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
puts "while  | #{wade_elapsed}"

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
puts "select  | #{select_elapsed}"

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
puts "each | #{droid_select_elapsed}"
puts "while  | #{select_elapsed}"
