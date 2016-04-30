require 'bundler'

Bundler.require(:default)
app_files = Dir['lib/**/*.rb']
app_files.each { |f| require_relative f }
puts("solution for TPS: ", TravellingSalesmanProblem.new([3,17,14]).solve)

