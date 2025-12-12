#!/usr/bin/env ruby
require "./binary-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params < 3
  puts "params | 3-4"
  puts "1 | binary-name"
	puts "2 | binary-comand"
	puts "3 | et-bs (base-16)"
	puts "4 | init-bs (base-16)"
  return
end
binary_name = params[0]
binary_comand = params[1]
et_bs = params[2].to_i(16)
init_bs = nil
if params[3]
	init_bs = params[3].to_i(16)
end
bc = BinaryClerk.new(binary_name)
sloto = bc.slots_meta["slot"]
slotc = sloto + bc.slots_meta["slot-distance"]
puts "slot | #{sloto.to_s(16)} | #{slotc.to_s(16)}"
#return
stays_chart_name = "charts/i-sim/#{binary_name}-couple-stays.chart"
alerts_chart_name = "charts/i-sim/#{binary_name}-couple-alerts.chart"
#asm_bss = bc.asm_metas["asms-index"].keys
stay_chart = eval((File::open("charts/i-sim/io.so.9-stays.chart").read))
asm_bss = []
naof_elements = stay_chart.length
site = 0
while true
	if site == naof_elements
		break
	end
	record = stay_chart[site]
	asm_bss += [record["bs"]]
	site += 1
end
naof_asms = asm_bss.length
stays = []
alerts = []
site = 0
while true
	if site == naof_asms
		break
	end
	bs = asm_bss[site]
	site += 1
	if bs > et_bs
		break
	end
	if init_bs
		if bs < init_bs
			next
		end
	end
	bc.engage_slots
	asm = bc.get_asm(bs)
	if (asm["bs"] >= sloto && asm["bs"] < slotc)
		next
	end
	#view_vecter([asm])
	#if asm == nil
		#$stdin.gets
	#end
	casm = bc.get_asm(asm["completion"])
	dasm = nil
	if casm && (casm["bs"] >= sloto && casm["bs"] < slotc)
		next
	end
	if BinaryConstants::StayToAluModules.index(asm["mod"])
		dasm = bc.get_asm(asm["destination"])
		if dasm && (dasm["bs"] < sloto || dasm["bs"] >= slotc)
			next
		end
	end
	log_heading("#{bs.to_s(16)} inititial")
	bc.inject("secs/i-sim.secs", bs)
	if casm
		log_heading("#{bs.to_s(16)} completion")
		bc.inject("secs/i-sim.secs", casm["bs"])
	end
	if dasm
		log_heading("#{bs.to_s(16)} destination")
		bc.inject("secs/i-sim.secs", dasm["bs"])
	end
	bc.write()
	comand = binary_comand
	puts "comand | #{comand}"
	result = `#{comand}`
	puts "result | #{result}"
	if result == ""
		naof_i_sims = 0
	else
		naof_i_sims = sites_aof("i sim. ka tic boo tic but.", result).length
	end
	if naof_i_sims > 0
		stays += [{
			"bs" => bs,
			"naof-stays" => naof_i_sims
		}]
	elsif $?.success? == false
		alerts += [{
			"bs" => bs,
			"alert" => "#{$?}"
		}]
	end
	log_heading("#{bs.to_s(16)} com")
	puts
end
naof_stays = stays.length
if naof_stays > 0
	log_heading("stays")
	view_vecter(stays)
end
naof_alerts = alerts.length
if naof_alerts > 0
	log_heading("alerts")
	view_vecter(alerts)
end
file = File::open(stays_chart_name, "w")
file.write(stays)
file.close
file = File::open(alerts_chart_name, "w")
file.write(alerts)
file.close
