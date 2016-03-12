require 'bundler'

Bundler.require(:default)
app_files = Dir['lib/**/*.rb']
app_files.each { |f| require_relative f }
customer_parser = CustomerParserService.new(File.join(Dir.pwd, 'data/rc101.csv'))
@customers = customer_parser.parse
@count = @customers.count
@distance_matrix = GenerateDistanceMatrixService.new(@customers, @count).distance_matrix
$start_matrix_dimension = @distance_matrix.count
brunch_cut = BrunchAndCut.new
@solution = brunch_cut.find_solution(@distance_matrix)

