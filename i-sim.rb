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
stays_chart_name = "charts/i-sim/#{binary_name}-stays.chart"
alerts_chart_name = "charts/i-sim/#{binary_name}-alerts.chart"
asm_bss = bc.asm_metas["asms-index"].keys
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
	log_heading("#{bs.to_s(16)} init")
	puts "bs | #{bs.to_s(16)}"
	bc.engage_slots
	bc.inject("secs/i-sim.secs", bs)
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
