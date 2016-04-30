require 'pp'

module TSP
  class TravellingSalesmanProblem
    def initialize(customer_ids)
      customer_parser = TSP::CustomerParserService.new(File.join(Dir.pwd, 'data/rc101.csv'))
      collection = customer_parser.parse
      @customers = collection.select {|customer| customer_ids.include?(customer[:id])}
      @count = @customers.count
      @distance_matrix = TSP::GenerateDistanceMatrixService.new(@customers, @count).distance_matrix
      @size_start_matrix = @distance_matrix.size
    end

    def solve
      prepare_path_service = PreparatoryPathService.new(@customers, @distance_matrix)
      prepare_path = prepare_path_service.possible_path_array
      possible_path_hash = prepare_path_service.possible_path_hash
      brunch_cut = BrunchAndCut.new(@distance_matrix, @customers)
      return brunch_cut.count_length_of_path(possible_path_hash) if prepare_path.length == @customers.count
      prepare_matrix = prepare_path_service.find_new_matrix
      return INFINITY if prepare_matrix.empty?
      brunch_cut_with_tw = BrunchAndCut.new(prepare_matrix, @customers)
      @solution = brunch_cut_with_tw.find_solution(prepare_matrix)
    end
  end
end
