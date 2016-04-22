require 'bundler'

Bundler.require(:default)
app_files = Dir['lib/**/*.rb']
app_files.each { |f| require_relative f }
customer_parser = CustomerParserService.new(File.join(Dir.pwd, 'data/rc101.csv'))
@customers = customer_parser.parse
@count = @customers.count
INFINITY = Float::INFINITY
Distance_matrix = GenerateDistanceMatrixService.new(@customers, @count).distance_matrix
debugger
test_matrix = { 0=>{0=>INFINITY, 1=>83, 2=>77, 3=>14, 4=>26},
                1=>{0=>46, 1=>INFINITY, 2=>8, 3=>36, 4=>63}, 
                2=>{0=>74, 1=>4, 2=>INFINITY, 3=>4, 4=>40}, 
                3=>{0=>81, 1=>61, 2=>32, 3=>INFINITY, 4=>17}, 
                4=>{0=>63, 1=>71, 2=>88, 3=>79, 4=>INFINITY}}
Size_start_matrix = Distance_matrix.size
prepare_path = PreparatoryPathService.new(@customers, Distance_matrix)
brunch_cut = BrunchAndCut.new()
@solution = brunch_cut.find_solution(Distance_matrix)

@res = [@solution.first.first]
loop do
  @res << @solution[@res.last]
  if @res.last == @res.first 
    if @res.length == Size_start_matrix
      puts "Done! No cycles"
    else
      puts "Has cycles"
    end
    break
  end
end
