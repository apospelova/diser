require_relative 'algorithms/brunch_cut'
require_relative 'models/customer'
require_relative 'services/customer_parse_service'
require_relative 'services/generate_distance_matrix'
require_relative 'services/preparatory_path_service'
require_relative 'services/travelling_salesman_problem'
require 'logger'


module TSP
  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::WARN
  INFINITY = Float::INFINITY

  class NotPossibleWay < Exception;end
end
