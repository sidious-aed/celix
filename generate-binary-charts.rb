#!/usr/bin/env ruby
require "./binary.rb"
naof_params, params, env, iat, symbols = init()

if naof_params != 1
  puts "params | 1"
  puts "1 | binary-name"
  return
end
binary_name = params[0]
log_heading("parsing binary-meta")
meta = get_binary_meta(binary_name)
binary_meta_chart_name = "charts/binary-meta/#{binary_name}.chart"
puts "saving #{binary_meta_chart_name} ..."
save_chart(meta, binary_meta_chart_name)
puts "complete"
log_heading("parsing asms-meta")
asms = get_asm_meta(binary_name)
asms_meta_chart_name = "charts/asms-meta/#{binary_name}.chart"
puts "saving #{asms_meta_chart_name} ..."
save_chart(asms, asms_meta_chart_name)
puts "complete"
