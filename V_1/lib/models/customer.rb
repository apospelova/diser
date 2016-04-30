module TSP
  class Customer
    include Virtus.model

    attribute :id, Integer
    attribute :x, Float
    attribute :y, Float
    attribute :demand, Integer
    attribute :time1, Integer
    attribute :time2, Integer
    attribute :service_time, Integer

    def position
      @position ||= [x, y].freeze
    end

    def middle_time
      (time1 + time2) / 2
    end
  end
end
