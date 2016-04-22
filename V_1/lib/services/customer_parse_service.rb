require 'csv'

class CustomerParserService
  def initialize(file_name)
    @file_name = file_name
  end

  def parse
    @customers ||= begin
      result = []
      CSV.foreach(@file_name) do |(id, x, y, demand, time1, time2, service_time)|
        result << Customer.new(
          id: id, 
          x: x, 
          y: y, 
          demand: demand,
          time1: time1, 
          time2: time2, 
          service_time: service_time)
      end
      result
    end
  end
end
