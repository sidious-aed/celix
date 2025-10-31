#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | binary-name"
  return
end
binary_name = params[0]
meta = get_binary_meta(binary_name)
stage_libs(meta["dls"])
