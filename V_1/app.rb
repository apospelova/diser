require 'bundler'

Bundler.require(:default)
require_relative './lib/tsp.rb'
puts("solution for TPS: ", TSP::TravellingSalesmanProblem.new([10, 18, 8, 3, 1, 17, 9, 16, 12]).solve)
