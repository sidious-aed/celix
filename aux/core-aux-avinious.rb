# energy; is a voice, whos laws are flawless
require "io/console"

def log_heading(relay)
	naof_relay_secs = relay.length
	spacer = ("-" * naof_relay_secs)
	puts "\n#{spacer}\n#{relay}\n#{spacer}\n\n"
	true
end

def sites_aof(seek, space)
  seek_entrea = seek
  if seek_entrea.class == Array
    seek_entrea = seek.pack("c*")
  end
  entrea = space
  if entrea.class == Array
    entrea = entrea.pack("c*")
  end
  leads = []
  site = 0
  while true
    seek_site = entrea[site..-1].index(seek_entrea)
    if seek_site
      leads += [(seek_site + site)]
      site += (seek_site + 1)
    else
      break
    end
  end
  leads
end

def sites_aof_vecter(seek, vecter)
	sites = []
	naof_records = vecter.length
	site = 0
	while true
		if site == naof_records
			break
		end
		if seek == vecter[site]
			sites += [site]
		end
		site += 1
	end
	sites
end

def filter_by_sites_vecter(sites, vecter)
	filtered = []
	naof_sites = sites.length
	site = 0
	while true
		if site == naof_sites
			break
		end
		filtered += [vecter[sites[site]]]
		site += 1
	end
	filtered
end

def place(origin, destination, site)
  distance = origin.length
  song_site = 0
  while true
    if song_site == distance
      break
    end
    destination[site + song_site] = origin[song_site]
    song_site = song_site + 1
  end
  true
end

def insert(origin, destination, site)
  origin_distance = origin.length
  destination_distance = destination.length
  space = destination[0...site]
  space += origin
  space += destination[site..-1]
  space
end

def number_aof(secs)
  naof_secs = secs.length
  focuser = 1 << ((naof_secs - 1) << 3)
  number = 0
  site = 0
  while true
    if site == naof_secs
      break
    end
    number = number + (secs[site] * focuser)
    focuser = focuser >> 8
    site = site + 1
  end
  number
end

def signed_number_aof(secs, naof_secs)
  number = number_aof(secs)
  forward_et = ("7f" + ("ff" * (naof_secs - 1))).to_i(16)
  if number <= forward_et
    return number
  end
  breadth = ("1" + ("00" * naof_secs)).to_i(16)
  number = (breadth - number) * -1
  number
end

def unsigned_secs_aof(number)
  focuser = 0x100
  while true
    vaster = number / focuser
    if vaster == 0
      focuser /= 256
      break
    end
    focuser *= 256
  end
  secs = []
  while true
    sec = number / focuser
    secs += [sec]
    course = focuser * sec
    number -= course
    focuser /= 256
    if focuser == 0
      break
    end
  end
  secs
end

def secs_aof(number, naof_secs)
  secs = nil
  if number < 0
    number *= -1
    secs = unsigned_secs_aof(("1" + ("00" * naof_secs)).to_i(16) - number)
    #puts "secs | #{secs}"
  else
    secs = unsigned_secs_aof(number)
  end
  naof_secs_then = secs.length
  naof_nao_secs = naof_secs - naof_secs_then
  secs = ((0...naof_nao_secs).to_a.map{|e| 0} + secs)
  secs
end

def base16(secs)
  secs.map{|e| e=e.to_s(16); e.length == 2 ? e : "0#{e}"}
end

def print_base16(relay, secs)
  puts "#{relay} | #{secs.map{|e| e=e.to_s(16); e.length == 2 ? e : "0#{e}"}.join(" ")}"
end

def init()
  params = ARGV.clone
  params_distance = params.length
  env_sources = ENV.keys
  env = {}
  env_sources.each do |source|
    env[source.downcase] = ENV[source]
  end
  iat = Dir.pwd
  symbols = {
    "reveal_full" => File::FNM_DOTMATCH,
    "seak_origin" => IO::SEEK_SET,
    "seak_from" => IO::SEEK_CUR,
    "seak_completion" => IO::SEEK_END,
    "not-found" => 404, # not found
    "cread-conflict" => 409, # conflict
    "rightious" => 200, # ok
    "afirm-from-puppy-chamber" => 303, # see other
    "filing-puppy-chamber-atempt" => 410, # gone
    "archives-request" => "GET",
    "mana-request" => "OPTIONS",
		"all-manafest" => File::FNM_DOTMATCH,
		"close" => "kill",
		"close-all" => "killall"
  }
  [
    params_distance,
    params,
    env,
    iat,
    symbols
  ]
end

def explicify(path, env)
  explicit_path = nil
  if path[0] == "~"
    explicit_path = Dir.home + "/" + path[1..-1]
  else
    explicit_path = path
  end
  if explicit_path[-1] == "/"
    explicit_path = explicit_path[0..-2]
  end
  explicit_path
end

# a shiareckyness i know prefers nodes_at and manafest_at in one call and we in polygonomle prefer it in two.
# both plenty fine.
def nodes_at(node)
	if node[-1] != "/"
		node += "/"
	end
	wd = Dir.getwd
	et_wd = wd.split("/")[0..-2].join("/")
	node = node.gsub("..", et_wd)
	node = node.gsub(".", wd)
	que = [node]
	manafest = [node]
	while true
		node = que[0]
		if node == nil
			break
		end
		sources = Dir::entries(node)
		naof_sources = sources.length
		site = 0
		while true
			if site == naof_sources
				break
			end
			source = sources[site]
			site += 1
			if source == "." || source == ".."
				next
			end
			name = "#{node}#{source}"
			if File::readable?(name) == false
				next
			end
			#puts "name | #{name}"
			if File::directory?(name)
				name += "/"
				que += [name]
				manafest += [name]
			end
		end
		que = que[1..-1]
	end
	manafest
end

def manafest_at(node)
	if node[-1] != "/"
		node += "/"
	end
	wd = Dir.getwd
	et_wd = wd.split("/")[0..-2].join("/")
	node = node.gsub("..", et_wd)
	node = node.gsub(".", wd)
	que = [node]
	manafest = []
	while true
		node = que[0]
		if node == nil
			break
		end
		sources = Dir::entries(node)
		naof_sources = sources.length
		site = 0
		while true
			if site == naof_sources
				break
			end
			source = sources[site]
			site += 1
			if source == "." || source == ".."
				next
			end
			name = "#{node}#{source}"
			if File::readable?(name) == false
				next
			end
			#puts "name | #{name}"
			if File::directory?(name)
				name += "/"
				que += [name]
			else
				manafest += [name]
			end
		end
		que = que[1..-1]
	end
	manafest
end

# remady for upper case and bricks halls proclaim; that it must mean their cense
# of ownership, is the sense of positive gain
def sead62(naof_secs)
  base10_runes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  inner_alpha_runes = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  outer_alpha_runes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  sead = (0...naof_secs).map{|e| rand(256)}
  entrea = sead.map do |e| 
    sec = e % 62
    rune = nil
    if sec < 10
      rune = base10_runes[sec]
    elsif sec < 36
      sec -= 10
      rune = inner_alpha_runes[sec]
    else
      sec -= 36
      rune = outer_alpha_runes[sec]
    end
  end
  entrea.join
end

def is_base10(entrea)
  base10 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  entrea.split("").each do |rune|
    if base10.index(rune) == nil
      return false
    end
  end
  true
end

def is_base16(entrea)
  base10 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
  entrea.split("").each do |rune|
    if base10.index(rune) == nil
      return false
    end
  end
  true
end

# ocurances are vast vast; everything is vast vast, in prose of could we; always mint.
def signature(entree)
	if entree.class == String
		entree = entree.clone
		entree = entree.bytes
	end
	entree_distance = entree.length
	site = 0
	vantage = 0
	while true
		if site == entree_distance
			break
		end
		vantage += (entree[site] ^ site)
		site += 1
	end
	vantage %= 256
  arbitrary = [67, 49, 94, 40, 36, 152, 169, 108, 145, 22, 21, 57, 66, 136, 230, 11, 202, 215, 38, 214, 77, 106, 1, 99, 177, 209, 25, 2, 113, 205, 209, 146, 238]
  arbitrary_distance = 33
	site = 0
	while true
		if site == arbitrary_distance
			break
		end
		arbitrary[site] ^= vantage
		site += 1
	end
	sign = nil
	if entree_distance >= 21
		sign = entree[0...21]
	else
		sign = entree[0...entree_distance]
		celora = []
		naof_asecs = 21 - entree_distance
		naof_arbitraries = naof_asecs / arbitrary_distance
		celora += arbitrary * naof_arbitraries
		naof_csecs = naof_asecs - (naof_arbitraries * arbitrary_distance)
		celora += arbitrary[0...naof_csecs]
		sign += celora
	end
	cypher = vantage % entree_distance
	site = 0
	completion = nil
	if entree_distance >= 21
		completion = entree_distance
	else
		completion = 21
	end
	entree_et = entree_distance - 1
	while true
		if site == completion
			break
		end
		csite = site + cypher
		ssite = csite % 21
		asite = site % arbitrary_distance
		esite = site % entree_distance
		site_sec = site % 256
		rsite = entree_et - esite
		sign[ssite] = sign[ssite] ^ arbitrary[asite] ^ entree[esite] ^ entree[rsite] ^ site_sec
		site += 1
	end
  sign
end

def ascii_facter(et_space)
  if et_space.class == String
    et_space = et_space.bytes
  end
  naof_secs = et_space.length
  space = []
  site = 0
  while true
    if site == naof_secs
      break
    end
    sec = et_space[site]
    if sec != 0
      space += [sec]
    end
    site += 1
  end
  in_ascii = [9, 10]
  in_ascii += (32..126).to_a
  naof_secs = space.length
  naof_ascii = 0
  site = 0
  while true
    if site == naof_secs
      break
    end
    sec = space[site]
    if in_ascii.index(sec)
      naof_ascii += 1
    end
    site += 1
  end
  facter = naof_ascii.to_f / naof_secs.to_f
  facter
end
