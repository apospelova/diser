class GenerateDistanceMatrixService
  attr_reader :distance_matrix

  def initialize(customers, count)
    @customers = customers
    @count = count
    @distance_matrix = {} 
    lines = @count
    columns = @count
    (0...lines).each do |line|
      @distance_matrix[l] = {}
      (0...columns).each do |column|
        from_customer = @customers[line]
        to_customer = @customers[column]
        store = @distance_matrix[from_customer.id][to_customer.id] = {}
        value = (Math.sqrt((from_customer.x - to_customer.x)**2 + (from_customer.y - to_customer.y)**2))
        if from_customer.id == to_customer.id 
          value = INFINITY
        end
        store.merge(
          distance: value,
          from_customer: from_customer,
          to_customer: to_customer)
      end
    end
  end
end
