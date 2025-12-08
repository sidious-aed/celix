#!/usr/bin/env ruby
require "./core.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
	params_entree = "params | 1\n"
	params_entree += "1 | node-name\n"
	print params_entree
  return
end
node = params[0]

to_throw_extensions = ["swp", "stay", "alert", "warn", "from-her", "buz"]
clear_bin(node, to_throw_extensions)
