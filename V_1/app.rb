require 'bundler'

Bundler.require(:default)
require_relative './lib/tsp.rb'

TSP::TravellingSalesmanProblem.new((1..100).to_a).solve
