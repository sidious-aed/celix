def result_to_chart(result)
	chart = []
	segments = result.split("\n")
	naof_segments = segments.length
	names = []
	site = 0
	while true
		puts "site | #{site}"
		segment = segments[site]
		puts "segment | #{segment}"
		if segment == nil
			#$stdin.gets
			break
		end
		components = segment.strip.split("|").map{|e| e.strip}
		naof_components = components.length
		puts "site | #{site}"
		puts "components | #{components}"
		puts "naof-components | #{naof_components}"
		if naof_components == 1
			puts "next-for-one"
			site += 1
			next
		end
		if site == 0
			names = components
			puts "names | #{names}"
		else
			record = {}
			csite = 0
			while true
				if csite == naof_components
					break
				end
				puts "csite | #{csite}"
				name = names[csite]
				puts "name | #{name}"
				value = components[csite]
				record[name] = value
				csite += 1
			end
			chart += [record]
		end
		site += 1
	end
	chart
end

def get_droid(name)
	result = `PGPASSWORD='celixaed' && psql -U droid-com -d celix -c "select * from droids where name = 'bb8'"`
	#puts "result | #{result}"
	result_to_chart(result)[0]
end

def create_table()
end
