#!/usr/bin/env ruby
require "./binary-clerk.rb"

bc = BinaryClerk.new("io.so.9")
=begin
# references-places-and-moves
bc.engage_slots
bc.view_asms(0x1090, 0x109b)
asm = WideSequences::jmpq(0x1090, 0x1c469)
nops_meta = bc.add_asm(asm)
puts "nops-meta | #{nops_meta}"
bc.view_asms(0x1090, 0x109b)
bc.engage_slots
bc.view_asms(0x1090, 0x109b)
=end

=begin
bc.engage_slots
#bc.view_asms
#bc.inject("secs/i-sim.secs", 0xe90)
#bc.inject("secs/i-sim.secs", 0x447d)
#bc.inject("secs/i-sim.secs", 0x1b5dd)
#bc.inject("secs/i-sim.secs", 0x1058)
bc.inject("secs/i-sim.secs", 0x3367)
#bc.inject("secs/i-sim.secs", 0x1b5e0)
#bc.inject("secs/i-sim.secs", 0xf06)
#bc.inject("secs/i-sim.secs", 0xf82)
#bc.inject("secs/i-sim.secs", 0x1090)
#bc.view_asms(0x1090, 0x109b)
#bc.view_asms(0x1c5f8, 0x1c600)
puts "moves | #{bc.moves}"
#log_heading("second-inject")
#bc.inject("secs/i-sim.secs", 0x1093)
#bc.inject("secs/i-sim.secs", 0x10a2)
#bc.inject("secs/i-sim.secs", 0x1145)
#bc.inject("secs/i-sim.secs", 0x1711)
#bc.inject("secs/i-sim.secs", 0x18b0)
#bc.inject("secs/i-sim.secs", 0x2290)
#bc.inject("secs/i-sim.secs", 0xf82)
#bc.view_writes
puts "bc.moves | #{bc.moves}"
bc.write
comand = "./shell-do"
puts "comand | #{comand}"
system(comand)
#bc.view_asms(0x1090, 0x109b)
#bc.view_asms(0x1c5f8, 0x1c600)
=end

bc.engage_slots
bc.inject("secs/i-sim.secs", 0x2192)
#$stdin.gets
bc.inject("secs/i-sim.secs", 0x2196)
log_heading("at-third-inject")
bc.view_writes
#bc.inject("secs/i-sim.secs", 0x116a0)
bc.view_writes
bc.write
comand = "./shell-do"
puts "comand | #{comand}"
system(comand)
=begin
=end
