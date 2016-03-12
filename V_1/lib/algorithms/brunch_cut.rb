class BrunchAndCut
  INFINITY = 1_000_000_000

  def initialize()
    @min_limit = 0
    @in_solution = []
    @no_solution = []
  end

  def calc_cost_for_line_and_column(item)
    min = item.min_by(&:value).value
    @min_limit = @min_limit + min
    new_item = []
    item.each do |el|
      new_value = el.value - min
      el.value = new_value
      new_item << el
    end
    new_item
  end

  def check_nonhamilron(collection, limit)
    debugger
    set of vertices = []
    collection.each do |edge|
      edge.each do |vertex|
        debugger
        set of vertices << vertex
      end
    end
  end

  def stage_2(matrix)
    new_line_matrix = []
    @new_matrix = []
    matrix.each do |line|
      new_line_matrix << calc_cost_for_line_and_column(line)
    end

    #for columns
    new_line_matrix.transpose.each do |column|
      @new_matrix << calc_cost_for_line_and_column(column)
    end
    @new_matrix.transpose
  end

  def find_solution(current_distance_matrix)
    @modified_matrix = stage_2(current_distance_matrix)
    #stage 2(main) fines count
    all_fines = []
    @modified_matrix.each_with_index do |line, line_num|
      line.each_with_index do |el, column_num|
        if el.value == 0 
          el_with_fines = {}
          min_by_line = line.sort_by(&:value)[1]
          if min_by_line.value > 900000000
            min_by_line.value = 0
          end
          min_by_column = @new_matrix[column_num].sort_by(&:value)[1]
          if min_by_column.value > 900000000
            min_by_column.value = 0
          end
          fines = min_by_line.value + min_by_column.value
          el_with_fines = {fines: fines, position: [line_num, column_num], default_position: [el.line_num, el.column_num]}
          all_fines << el_with_fines
        end
      end
    end
    element_with_max_fines = all_fines.max_by {|fine| fine[:fines] }
    pos_line = element_with_max_fines[:position][0]
    pos_column = element_with_max_fines[:position][1]
    #without top
    cost_of_path_without = element_with_max_fines[:fines] + @min_limit
    modified_matrix_without = @modified_matrix
    modified_matrix_without[pos_line][pos_column].value = INFINITY
    #with top
    @modified_matrix[pos_column][pos_line].value = INFINITY
    @modified_matrix.delete(@modified_matrix[pos_line])
    tranpose_matrix_without_line = @modified_matrix.transpose
    tranpose_matrix_without_line.delete(tranpose_matrix_without_line[pos_column])
    new_matrix_without_elements = tranpose_matrix_without_line.transpose
    common_limit = @min_limit
    @min_limit = 0
    stage_2(new_matrix_without_elements)
    cost_of_path_with = common_limit + @min_limit
    if cost_of_path_with > cost_of_path_without
      @modified_matrix = modified_matrix_without
      @min_limit = cost_of_path_without
      @no_solution << element_with_max_fines[:default_position]
    else 
      @min_limit = common_limit
      @in_solution << element_with_max_fines[:default_position]
      check_nonhamilron(@in_solution, $start_matrix_dimension)
      @modified_matrix = new_matrix_without_elements
    end
    if @modified_matrix.count > 1
      find_solution(@modified_matrix)
    end
    @in_solution
  end

end
