# a simple charts ruby object to build our clerk tools with. to ironically seek for duel-stay-object-init in the linux binaries, a different cents of object.
	# <--> you could of course vasterise at good ombwie this fine charts object for other things.
require "/home/tyrel/celix/core.rb"

# <--> at inner shell in ideaology, it feels right to establish all lower for not being ownavating. later up case for gain feels quite right.
NaofSegmentSecs = 50
	# <--> secs is short for section which is the tactical at a vantage diaposed to the strategical segment.
class Chart
	#attr_accessor :attributes, :view_attributes, :records, :naof_records
	attr_accessor :records, :naof_records
	def initialize(base=16)
		# records are meant to be standard ruby hashes.
		@records = []
		@naof_records = 0
		@attributes = {}
		@is_pause = false
		@base = base
	end
	def add(record)
		@records += [record]
		@naof_records += 1
		@naof_segments = @naof_records / NaofSegmentSecs
		if (@naof_records % NaofSegmentSecs) > 0
			@naof_segments += 1
		end
		attributes = record.keys
		#puts "attributes | #{attributes}"
		naof_attributes = attributes.length
		site = 0
		while true
			if site == naof_attributes
				break
			end
			attribute = attributes[site]
			entree = record[attribute]
			if entree.class == Integer
				entree = entree.to_s(@base)
			end
			record[attribute] = entree
			naof_secs = "#{entree}".length
			if @attributes[attribute] == nil
				# seems wade if faster which in rubys virtual speed leans. so we are refining to length calls at one utalise instead of always naof-secs-thens for a linked reason.
				# though this was a two utalise but thinking of it after our times.rb expeiraments.
				naof_attribute_secs = attribute.length
				if naof_attribute_secs > naof_secs
					naof_secs = naof_attribute_secs
				end
				@attributes[attribute] = naof_secs
			elsif @attributes[attribute] < naof_secs
				@attributes[attribute] = naof_secs
			end
			site += 1
		end
	end
	def add_vecter(vecter)
		naof_elements = vecter.length
		site = 0
		while true
			if site == naof_elements
				break
			end
			#puts "site | #{site}"
			self.add(vecter[site])
			site += 1
		end
	end
	def set_view_attributes(view_attributes)
		@view_attributes = view_attributes
		#puts "view-attributes | #{@view_attributes}"
		@naof_view_attributes = @view_attributes.length
		@attr_et = @naof_view_attributes - 1
		@naof_header_secs = 4 + ((@naof_view_attributes - 1) * 3)
		@attr_header = "| "
		asite = 0
		while true
			if asite == @naof_view_attributes
				break
			end
			attribute = @view_attributes[asite]
			#puts "attribute | #{@attributes[attribute]}"
			naof_secs = @attributes[attribute]
			@naof_header_secs += naof_secs
			@attr_header += "#{attribute}"
			naof_spaces = naof_secs - attribute.length
			@attr_header += " " * naof_spaces
			if asite != @attr_et
				@attr_header += " | "
			end
			asite += 1
		end
		@attr_header += " |"
		@header = "-" * @naof_header_secs
		@full_header = "#{@header}\n#{@attr_header}\n#{@header}\n"
	end
	def engage_pause
		@is_pause = true
	end
	def disengage_pause
		@is_pause = false
	end
	def view(init=nil, com=nil)
		if @view_attributes == nil
			self.set_view_attributes(@attributes.keys)
		else
			self.set_view_attributes(@view_attributes)
		end
		init_com = init && com
		if @is_pause == false
			print @full_header
		end
		# we are moving to less confound and gaining space.
		ssite = 0
		while true
			if ssite == @naof_segments
				break
			end
			rsite = ssite * NaofSegmentSecs
			rsite_com = rsite + NaofSegmentSecs
			segment = ""
			while true
				if rsite == rsite_com
					break
				end
				record = @records[rsite]
				arsite = rsite
				rsite += 1
				if record == nil
					break
				end
				if init_com
					if arsite < init || arsite > com
						next
					end
				end
				segment += "| "
				asite = 0
				while true
					if asite == @naof_view_attributes
						break
					end
					attribute = @view_attributes[asite]
					naof_secs = @attributes[attribute]
					attribute = "#{record[attribute]}"
					segment += "#{attribute}"
					naof_spaces = naof_secs - attribute.length
					segment += " " * naof_spaces
					if asite != @attr_et
						segment += " | "
					end
					asite += 1
				end
				segment += " |\n"
			end
			if @is_pause
				print @full_header
			end
			print segment
			if @is_pause
				puts "#{@header}"
				$stdin.gets
			end
			ssite += 1
		end
		puts "#{@header}"
	end
	def view_sites(sites)
		if @view_attributes == nil
			self.set_view_attributes(@attributes.keys)
		else
			self.set_view_attributes(@view_attributes)
		end
		# we are moving to less confound and gaining space.
		naof_sites = sites.length
		segment = ""
		rsite = 0
		while true
			if rsite == naof_sites
				break
			end
			#puts "rsite | #{rsite}"
			record_site = sites[rsite]
			record = @records[record_site]
			segment += "| "
			asite = 0
			while true
				if asite == @naof_view_attributes
					break
				end
				attribute = @view_attributes[asite]
				naof_secs = @attributes[attribute]
				attribute = "#{record[attribute]}"
				segment += "#{attribute}"
				naof_spaces = naof_secs - attribute.length
				segment += " " * naof_spaces
				if asite != @attr_et
					segment += " | "
				end
				asite += 1
			end
			segment += " |\n"
			rsite += 1
		end
		print @full_header
		print segment
		puts "#{@header}"
	end
end

def load_chart(name)
	file = File::open(name)
	chart = eval(file.read)
	file.close
	chart
end

def save_chart(chart, name)
	file = File::open(name, "w")
	file.write(chart)
	file.close
end

def view_vecters(vecters)
	naof_vecters = vecters.length
	vsite = 0
	while true
		if vsite == naof_vecters
			break
		end
		view_vecter(vecters[vsite])
		vsite += 1
	end
end

def poly_clone(obj)
	at = lambda do |obj, access|
		element = obj
		naof_accesses = access.length
		site = 0
		while true
			if site == naof_accesses
				break
			end
			key = access[site]
			element = element[key]
			site += 1
		end
		element
	end
	set_at = lambda do |obj, access, value|
		element = obj
		naof_accesses = access.length - 1
		site = 0
		while true
			if site == naof_accesses
				break
			end
			key = access[site]
			element = element[key]
			site += 1
		end
		last_key = access[-1]
		#puts "last-key | #{last_key}"
		element[last_key] = value
	end
	poly = obj.clone
	obj_class = obj.class
	if obj_class == Hash
		accesses = obj.keys
	elsif obj_class == Array
		accesses = (0...obj.length).to_a
	else
		return obj.clone
	end
	naof_accesses = accesses.length
	site = 0
	while true
		if site == naof_accesses
			break
		end
		accesses[site] = [accesses[site]]
		site += 1
	end
	while true
		#puts "accesses | #{accesses}"
		access = accesses[0]
		if access == nil
			break
		end
		accesses = accesses[1..-1]
		#puts "access | #{access}"
		element = at.call(obj, access)
		#puts "element | #{element}"
		element_class = element.class
		#puts "element-class | #{element_class}"
		taccesses = []
		set_polly = false
		if element_class == Hash
			taccesses = element.keys
			set_polly = true
		elsif element_class == Array
			naof_elements = element.length
			taccesses = (0...naof_elements).to_a
			set_polly = true
		end
		if set_polly
			set_at.call(poly, access, element.clone)
		end
		naof_accesses = taccesses.length
		#puts "taccesses | #{taccesses}"
		if naof_accesses > 0
			site = 0
			while true
				if site == naof_accesses
					break
				end
				taccesses[site] = access + [taccesses[site]]
				site += 1
			end
			#puts "taccesses | #{taccesses}"
			accesses += taccesses
		end
		#puts "poly | #{poly}"
		#puts
	end
	poly # <--> | plenty did we clerk (from a wide 1d perspective(prose of a)) write this for where rubys clone isnt that back support you might hope at higher clerk sophistication.
		# <--> | was just enough to get the features we wanted at the front entries lesser of back support for speed.
end

# clerical note on non | bricks calls what we mean n\a. we do not mean non in
# the sense of non-completly.
def view_vecter(hash_vecter, list=nil)
  naof_hashes = hash_vecter.length
  sources = []
  site = 0
  while true
    if site == naof_hashes
      break
    end
    sources += hash_vecter[site].keys
    site += 1
  end
  base = 16
  if list && list["base"]
    base = list["base"]
  end
  sources = sources.uniq
  naof_sources = sources.length
  list_mode = (list == nil) == false
  list_mode = list_mode && (list["type"] != nil)
  if list_mode
    list_type = list["type"]
    list = list["list"]
    hash_vecter = hash_vecter.clone
    list_sources = []
    site = 0
    while true
      if site == naof_sources
        break
      end
      source = sources[site]
      if list_type == "select"
        if list.index(source)
          list_sources += [source]
        end
      elsif list_type == "non"
        if (list.index(source) == nil)
          list_sources += [source]
        end
      end
      site += 1
    end
    sources = list_sources
    naof_sources = sources.length
  end
  breadths = []
  site = 0
  while true
    if site == naof_sources
      break
    end
    source = "#{sources[site]}"
    hash_site = 0
    source_breadth = source.length
    while true
      if hash_site == naof_hashes
        break
      end
      if hash_vecter[hash_site][source].class == Integer
        distance = ("#{hash_vecter[hash_site][source].to_s(base)}").length
      else
        distance = ("#{hash_vecter[hash_site][source]}").length
      end
      if distance > source_breadth
        source_breadth = distance
      end
      hash_site += 1
    end
    breadths += [source_breadth]
    site += 1
  end
  et = naof_sources - 1
  site = 0
  header_distance = 0
  while true
    if site == naof_sources
      break
    end
    source = "#{sources[site]}"
    source_distance = source.length
    breadth = breadths[site]
    header_distance += breadth
    print "#{source}#{" " * (breadth - source_distance)}"
    if site != et
      print " | "
      header_distance += 3
    else
      print "\n"
    end
    site += 1
  end
  puts "#{"-" * header_distance}"
  site = 0
  while true
    if site == naof_hashes
      break
    end
    hash = hash_vecter[site]
    source_site = 0
    while true
      if source_site == naof_sources
        break
      end
      source = sources[source_site]
      entrea = hash[source]
      if entrea.class == Integer
        entrea = entrea.to_s(base)
      end
      source_distance = ("#{entrea}").length
      breadth = breadths[source_site]
      print "#{entrea}#{" " * (breadth - source_distance)}"
      if source_site != et
        print " | "
      else
        print "\n"
      end
      source_site += 1
    end
    site += 1
  end
  puts "#{"-" * header_distance}"
  header_distance
end
