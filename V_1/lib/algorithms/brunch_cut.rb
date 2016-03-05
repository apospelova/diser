class BrunchAndCut
  INFINITY = 1_000_000_000

  def calc_cost_for_line_and_column(item)
    @min_limit = @min_limit || 0
    min = item.sort[0]
    @min_limit = @min_limit + min
    @new_item = []
    item.each do |el|
      new_el = el - min
      if new_el < 0 
        new_el = INFINITY
      end
      @new_item << new_el
    end
  end

  def stage_2(matrix)
    new_line_matrix = []
    @new_matrix = []
    matrix.each do |line|
      calc_cost_for_line_and_column(line)
      new_line_matrix << @new_item
    end

    #for columns
    new_line_matrix.transpose.each do |column|
      calc_cost_for_line_and_column(column)
      @new_matrix << @new_item
    end
    @modified_matrix = @new_matrix.transpose
  end

  def find_solution(current_distance_matrix)
    @in_solution = @in_solution || []
    @no_solution = @no_solution || []
    stage_2(current_distance_matrix)
    #stage 2(main) fines count
    all_fines = []
    @modified_matrix.each_with_index do |line, line_num|
      line.each_with_index do |el, column_num|
        if el == 0 
          el_with_fines = {}
          min_by_line = line.sort[1]
          min_by_column = @new_matrix[column_num].sort[1]
          fines = min_by_line + min_by_column
          el_with_fines = {fines: fines, position: [line_num, column_num]}
          all_fines << el_with_fines
        end
      end
    end
    element_with_max_fines = all_fines.max_by {|fine| fine[:fines] }
    #without top
    cost_of_path_without = element_with_max_fines[:fines] + @min_limit
    #with top
    old_modified_matrix = @modified_matrix
    pos_line = element_with_max_fines[:position][0]
    pos_column = element_with_max_fines[:position][1]
    @modified_matrix[pos_column][pos_line] = INFINITY
    @modified_matrix.delete(@modified_matrix[pos_line])
    tranpose_matrix_without_line = @modified_matrix.transpose
    tranpose_matrix_without_line.delete(tranpose_matrix_without_line[pos_column])
    new_matrix_without_elements = tranpose_matrix_without_line.transpose
    common_limit = @min_limit
    @min_limit = 0
    stage_2(new_matrix_without_elements)
    cost_of_path_with = common_limit + @min_limit
    if cost_of_path_with > cost_of_path_without
      @modified_matrix = old_modified_matrix
      @min_limit = cost_of_path_without
      @no_solution << element_with_max_fines[:position]
    else 
      @min_limit = common_limit
      @in_solution << element_with_max_fines[:position]
    end
    if @modified_matrix.count > 2
      find_solution(@modified_matrix)
    end
    @in_solution
  end

end
