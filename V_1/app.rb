require 'bundler'

Bundler.require(:default)
app_files = Dir['lib/**/*.rb']
app_files.each { |f| require_relative f }
customer_parser = CustomerParserService.new(File.join(Dir.pwd, 'data/rc101.csv'))
@customers = customer_parser.parse
@count = @customers.count
INFINITY = Float::INFINITY
Distance_matrix = GenerateDistanceMatrixService.new(@customers, @count).distance_matrix
Clone_distance_matrix = Distance_matrix.clone
brunch_cut = BrunchAndCut.new()
@solution = brunch_cut.find_solution(Distance_matrix)

