#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | node"
  return
end

procedure_extensions = ["rb", "c"]
node = params[0]
if node[-1] != "/"
	node += "/"
end
manafest = filter_node_nodes(Dir::entries(node))
#puts "manafest | #{manafest}"
naof_files = manafest.length
# clerk note | nice, the tamber of while compaired to each in the basis of ruby
# things like each and select are nice in the ruby basises * in prose of could we
# at focusering swifts in incoumpousments and renditions
# you might find while tasks nicer in result from the higher-symphony in unix basises
# later in incompousments we will make our shell in the cents of both; execve and cwd, and akin to ruby and python
fsite = 0
while true
	if fsite == naof_files
		break
	end
	file = manafest[fsite]
	file = "#{node}#{file}"
  #puts "file | #{file}"
  extension = file.split("/")[-1].split(".")[-1]
  if procedure_extensions.index(extension)
    chart = File::open(file).read.split("\n")
    if extension == "rb"
      et_site_distance = 0
      has_equations = false
      chart.each_with_index do |segment, segment_site|
				if segment.strip[0...3] == "def"
          site_distance = "#{segment_site + 1}".length
          if site_distance > et_site_distance
            et_site_distance = site_distance
          end
          has_equations = true
        end
      end
      if has_equations
        puts "#{file}"
        puts "#{"-" * file.length}"
        chart.each_with_index do |segment, segment_site|
					segment.strip!
					if segment[0...3] == "def"
            site_distance = "#{segment_site + 1}".length
						puts "#{segment_site + 1}#{" " * (et_site_distance - site_distance)} | #{segment.strip[4..-1]}"
          end
        end
        puts
      end
    elsif extension == "c"
      has_equations = false
      et_site_distance = 0
      chart.each_with_index do |segment, segment_site|
        is_equation_heading = segment.index("(") && segment.index(")") && segment.index("{") && (segment.index("}") == nil)
        is_equation_heading2 = (segment.index("else") == nil) && (segment.index("if") == nil) && (segment.index("while") == nil)
        if is_equation_heading && is_equation_heading2
          site_distance = "#{segment_site + 1}".length
          if site_distance > et_site_distance
            et_site_distance = site_distance
          end
          has_equations = true
        end
      end
      if has_equations
        puts "#{file}"
        puts "#{"-" * file.length}"
        chart.each_with_index do |segment, segment_site|
          is_equation_heading = segment.index("(") && segment.index(")") && segment.index("{") && (segment.index("while") == nil)
          is_equation_heading2 = (segment.index("else") == nil) && (segment.index("if") == nil) && (segment.index("}") == nil)
          if is_equation_heading && is_equation_heading2
            site_distance = "#{segment_site + 1}".length
            naof_return_category_symbols = segment[0..segment.index("(")].split(" ").length - 1
            equation_source = segment[0..segment.index(")")].split(" ")[naof_return_category_symbols..-1].join(" ")
            puts "#{segment_site + 1}#{" " * (et_site_distance - site_distance)} | #{equation_source}"
          end
        end
      end
      puts
    end
  end
	fsite += 1
end
