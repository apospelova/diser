class TravellingSalesmanProblem
  require 'pp'

  def initialize(customer_ids)
    customer_parser = CustomerParserService.new(File.join(Dir.pwd, 'data/rc101.csv'))
    collection = customer_parser.parse
    @customers = collection.select {|customer| customer_ids.include?(customer[:id])}
    @count = @customers.count
    @distance_matrix = GenerateDistanceMatrixService.new(@customers, @count).distance_matrix
    @size_start_matrix = @distance_matrix.size
end

  def solve
    prapare_path = PreparatoryPathService.new(@customers, @distance_matrix)
    prepare_matrix = prapare_path.find_new_matrix(@customers, @distance_matrix)
    exit if prepare_matrix.empty?
    
    brunch_cut = BrunchAndCut.new(prepare_matrix, @customers)
    @solution = brunch_cut.find_solution(prepare_matrix)
  end

end