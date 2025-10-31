#!/usr/bin/env ruby
require "./core.rb"

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
