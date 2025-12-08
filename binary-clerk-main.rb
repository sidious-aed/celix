#!/usr/bin/env ruby
require "./binary-clerk.rb"

bc = BinaryClerk.new("io.so.9")
# place-asm
=begin
bc.engage_slots
bc.view_asms(0x1090, 0x109b)
asm = clerk_clone(bc.get_asm(0x10c5))
asm["bs"] = 0x1090
asm["completion"] = 0x1090 + asm["naof-secs"]
bc.place_asm(asm)
bc.view_asms(0x1090, 0x109b)
=end

bc.engage_slots
#bc.view_asms
bc.inject("secs/i-sim.secs", 0xe90)
#bc.inject("secs/i-sim.secs", 0xf06)
#bc.inject("secs/i-sim.secs", 0xf82)
#bc.inject("secs/i-sim.secs", 0x1090)
#bc.inject("secs/i-sim.secs", 0x10a2)
#bc.inject("secs/i-sim.secs", 0x1145)
#bc.inject("secs/i-sim.secs", 0x1711)
#bc.inject("secs/i-sim.secs", 0x18b0)
puts "bc.moves | #{bc.moves}"
bc.write
comand = "./shell-do"
puts "comand | #{comand}"
system(comand)
#bc.view_asms
