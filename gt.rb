#!/usr/bin/env ruby
require "./core.rb"

zeta = ["0", "1", "^", "+", "-", "*", "/", "\\", "@", "oo", "|", "a", "b", "c", "d", "e"]
naof_zeta_secs = zeta.length
naof_rows, naof_collums = $stdin.winsize
naof_rows -= 1
center_site = (naof_rows / 2) + 1
vission_site = naof_collums / 2
#puts "naof-collumns | #{naof_collums}"
#puts "naof-rows | #{naof_rows}"
comand = "./pcgt a"
time = `#{comand}`.strip
naof_secs = time.length
#puts "center-site | #{center_site}"
naof_spaces = (naof_collums - naof_secs) / 2
et_aof_spaces = naof_secs + naof_spaces - 1
cet = naof_collums - 1
time_site = 0
edge_facter = 0.33
oo_facter = 0.27132
rsite = 0
entree = ""
while true
	#if rsite > center_site
		#break
	#end
	if rsite == naof_rows
		break
	end
	if rsite < center_site
		rvsite = rsite
	else
		rvsite = (naof_rows - 1) - rsite
	end
	row = ""
	csite = 0
	while true
		if csite == naof_collums
			break
		end
		if csite < vission_site
			cvsite = csite
		else
			cvsite = (naof_collums - 1) - csite
		end
		is_edge = (cvsite < 3) || (rvsite < 2)
		if is_edge
			is_edge = rand < edge_facter
		end
		if rsite == center_site && (csite > naof_spaces) && (csite < et_aof_spaces)
			row += time[time_site]
			time_site += 1
		#elsif csite == 0
			#row += "#{rsite}"
		else
			if is_edge
				while true
					if rand > oo_facter
						sec = zeta[rand(naof_zeta_secs)]
					else
						sec = "oo"
					end
					if sec != "oo" || csite < cet
						break
					end
				end
				if sec == "oo"
					csite += 1
				end
				row += sec
			else
				row += " "
			end
		end
		csite += 1
	end
	entree += row
	rsite += 1
end
puts entree
