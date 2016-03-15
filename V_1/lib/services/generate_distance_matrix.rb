class GenerateDistanceMatrixService
  attr_reader :distance_matrix

  def initialize(customers, count)
    @customers = customers
    @count = count
    @distance_matrix = {} 
    lines = @count
    columns = @count
    (0...lines).each do |l|
      @distance_matrix[l] = {}
      (0...columns).each do |c|
        value = (Math.sqrt((@customers[l].x - @customers[c].x)**2 + (@customers[l].y - @customers[c].y)**2))
        if l == c && value == 0 
          value = INFINITY
        end
        @distance_matrix[l][c] = value
      end
    end
  end
end
