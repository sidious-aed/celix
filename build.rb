#!/usr/bin/env ruby
require "./core.rb"
naof_params, params, env, iat, symbols = init()

build_extensions = ["c", "h", "lib"]
source_extensions = ["c", "h"]
chart = nil
if File::exists?("build.signatures")
  signatures_file = File::open("build.signatures")
  chart = eval(signatures_file.read)
  signatures_file.close
else
  chart = {}
end
#puts "chart | #{chart}"
comands = [
  "gcc -c standard.c -o standard.lib",
  "gcc standard.lib standard-main.c -o standard-main",
  "gcc -c standard.lib machine.c -o machine.lib",
  "gcc standard.lib machine.lib machine-main.c -o machine-main",
  "gcc standard.lib quad-reader.c -o quad-reader",
  "gcc standard.lib write-quad.c -o write-quad",
  "gcc standard.lib place.c -o place",
  "gcc standard.lib change-entree.c -o change-entree",
  "gcc standard.lib place-sites.c -o place-sites",
  "gcc standard.lib file-secs.c -o file-secs",
  "gcc standard.lib base16-secs.c -o base16-secs",
  "gcc standard.lib machine.lib sequences.c -o sequences",
  "gcc standard.lib machine.lib sequences-full.c -o sequences-full",
  "gcc standard.lib rn.c -o rn",
  "gcc standard.lib stay.c -o stay"
]
naof_comands = comands.length
sources = []
comand_site = 0
while true
  if comand_site == naof_comands
    break
  end
  comand = comands[comand_site]
  components = comand.split(" ")
  naof_components = components.length
  site = 0
  while true
    if site == naof_components
      break
    end
    component = components[site]
    extension = component.split("/")[-1].split(".")[-1]
    if build_extensions.index(extension)
      sources += [component]
      if source_extensions.index(extension)
        headers = filtered_segments(component, /^#include/)
        naof_headers = headers.length
        header_site = 0
        while true
          if header_site == naof_headers
            break
          end
          header = headers[header_site][10..-2]
          if header[0...2] == "./"
            sources += [header[2..-1]]
          end
          header_site += 1
        end
      end
    end
    site += 1
  end
  comand_site += 1
end
sources = sources.uniq
naof_sources = sources.length
puts "sources | #{sources}"
is_modifides = []
site = 0
while true
  if site == naof_sources
    break
  end
  source = sources[site]
	puts "source | #{source}"
  sig = signature(File::open(source).read)
  #puts "#{source} | #{sig}"
  is_modifides += [(sig != chart[source])]
  chart[source] = sig
  site += 1
end
#puts "is-modifides | #{is_modifides}"
file = File::open("build.signatures", "w")
file.write(chart)
file.close
comand_site = 0
while true
  if comand_site == naof_comands
    break
  end
  comand = comands[comand_site]
  components = comand.split(" ")
  naof_components = components.length
  is_modified = false
  site = 0
  while true
    if site == naof_components
      break
    end
    component = components[site]
    extension = component.split("/")[-1].split(".")[-1]
    if build_extensions.index(extension)
      source_site = sources.index(component)
      #puts "source-site #{component} | #{source_site}"
      if is_modifides[source_site]
        is_modified = true
        break
      end
    end
    if source_extensions.index(extension)
      headers = filtered_segments(component, /^#include/)
      naof_headers = headers.length
      header_site = 0
      while true
        if header_site == naof_headers
          break
        end
        header = headers[header_site][10..-2]
        if header[0...2] == "./"
          header = header[2..-1]
          source_site = sources.index(header)
          #puts "source-site #{header} | #{source_site}"
          if is_modifides[source_site]
            is_modified = true
            break
          end
        end
        header_site += 1
      end
    end
    site += 1
  end
  if is_modified
    puts "comand | #{comand}"
    system(comand)
  end
  comand_site += 1
end
