class BrunchAndCut

  def initialize(distance_matrix)
    @distance_matrix = distance_matrix
    @infinity = -1_000_000_000 
  end

  def calc_cost_for_line_and_column(item)
    @min_limit = 0 || @min_limit
    min = item.sort[1]
    @min_limit = @min_limit + min
    @new_item = []
    item.each do |el|
      new_el = el - min
      if new_el < 0 
        new_el = @infinity
      end
      @new_item << new_el
    end
  end

  def find_solution
    #for lines
    new_line_matrix = []
    new_matrix = []
    @distance_matrix.each do |line|
      calc_cost_for_line_and_column(line)
      new_line_matrix << @new_item
      @min_limit
    end

    #for columns
    new_line_matrix.transpose.each do |column|
      calc_cost_for_line_and_column(column)
      new_matrix << @new_item
    end
    modified_matrix = new_matrix.transpose
    @min_limit

    #stage 2(main) fines count
    all_fines = []
    modified_matrix.each_with_index do |line, line_num|
      line.each_with_index do |el, column_num|
        if el == 0 
          el_with_fines = {}
          min_by_line = line.sort[2]
          min_by_column = new_matrix[column_num].sort[2]
          fines = min_by_line + min_by_column
          el_with_fines = {fines: fines, position: [line_num, column_num]}
          all_fines << el_with_fines
        end
      end
    end
    element_with_max_fines = all_fines.max_by {|fine| fine[:fines] }
  end

end
