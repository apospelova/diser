require 'bundler'

Bundler.require(:default)
require_relative './lib/tsp.rb'
puts("solution for TPS: ", TSP::TravellingSalesmanProblem.new([15, 16]).solve)
