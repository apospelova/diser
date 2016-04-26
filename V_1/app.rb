require 'bundler'

Bundler.require(:default)
app_files = Dir['lib/**/*.rb']
app_files.each { |f| require_relative f }
INFINITY = Float::INFINITY
TravellingSalesmanProblem.new([1,2,3,5]).solve

