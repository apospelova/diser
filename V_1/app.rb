require 'bundler'

Bundler.require(:default)
require_relative './lib/tsp.rb'
puts("solution for TPS: ", TSP::TravellingSalesmanProblem.new([3,17,14]).solve)
