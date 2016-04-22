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
        @distance_matrix[l][c] = {}
        value = (Math.sqrt((@customers[l].x - @customers[c].x)**2 + (@customers[l].y - @customers[c].y)**2))
        if l == c && value == 0 
          value = INFINITY
        end
        @distance_matrix[l][c] = {distance: value, from: @customers[c].time1, to: @customers[c].time2, middle_time: (@customers[c].time1 + @customers[c].time2)/2, service_time: @customers[c].service_time}
      end
    end
  end
end
