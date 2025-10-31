#!/usr/bin/env ruby
require "./binary-clerk.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 3
  puts "params | 3"
  puts "1 | binary-name"
	puts "2 | binary-comand"
	puts "3 | et-bs (base-16)"
  return
end
binary_name = params[0]
binary_comand = params[1]
et_bs = params[2].to_i(16)
bc = BinaryClerk.new(binary_name)
stays_chart_name = "charts/i-sim/#{binary_name}-stays.chart"
alerts_chart_name = "charts/i-sim/#{binary_name}-alerts.chart"
asm_bss = bc.ametas[binary_name]["asms-index"].keys
naof_asms = asm_bss.length
stays = []
alerts = []
site = 0
while true
	if site == naof_asms
		break
	end
	bs = asm_bss[site]
	if bs > et_bs
		break
	end
	log_heading("#{bs.to_s(16)} init")
	puts "bs | #{bs.to_s(16)}"
	bc.engage_slots
	bc.inject("secs/i-sim.secs", binary_name, bs)
	bc.write(binary_name)
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
	site += 1
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
