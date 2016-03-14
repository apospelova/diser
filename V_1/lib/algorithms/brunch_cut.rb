class BrunchAndCut

  def initialize()
    @min_limit = 0
    @in_solution = {}
    @no_solution = {}
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

  def check_nonhamilron(collection, matrix)
    #sort collection
    @copy_collection = collection
    collection.each do |start_ver, finish_ver|
      @copy_collection.each do |copy_start, copy_finish|
        if finish_ver == copy_start
          matrix.find do |line|
            line.each do |el| 
              if el.line_num == copy_finish && el.column_num == start_ver 
                el.value = INFINITY
              end
            end
          end
        end
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
    debugger
    #stage 2(main) fines count
    all_fines = []
    @modified_matrix.each_with_index do |line, line_num|
      line.each_with_index do |el, column_num|
        if el.value == 0 
          el_with_fines = {}
          min_by_line = line.sort_by(&:value)[1]
          if min_by_line.value == INFINITY
            min_by_line = el
          end
          min_by_column = @new_matrix[column_num].sort_by(&:value)[1]
          if min_by_column.value == INFINITY
            min_by_column = el
          end
          fines = min_by_line.value + min_by_column.value
          el_with_fines = {fines: fines, position: [line_num, column_num], default_position: [el.line_num, el.column_num]}
          all_fines << el_with_fines
        end
      end
    end
    debugger
    element_with_max_fines = all_fines.max_by {|fine| fine[:fines] }
    pos_line = element_with_max_fines[:default_position][0]
    pos_column = element_with_max_fines[:default_position][1]
    #without top
    cost_of_path_without = element_with_max_fines[:fines] + @min_limit
    modified_matrix_without = @modified_matrix
    Distance_matrix[pos_line][pos_column].value = INFINITY
    #with top
    Distance_matrix[pos_column][pos_line].value = INFINITY
    @modified_matrix.delete(@modified_matrix[pos_line])
    tranpose_matrix_without_line = @modified_matrix.transpose
    tranpose_matrix_without_line.delete(tranpose_matrix_without_line[pos_column])
    new_matrix_without_elements = tranpose_matrix_without_line.transpose
    common_limit = @min_limit
    @min_limit = 0
    stage_2(new_matrix_without_elements)
    cost_of_path_with = common_limit + @min_limit
    start = element_with_max_fines[:default_position][0]
    finish = element_with_max_fines[:default_position][1]
    if cost_of_path_with > cost_of_path_without
      @modified_matrix = modified_matrix_without
      @min_limit = cost_of_path_without
      @no_solution[start] = finish
    else 
      @min_limit = common_limit
      @in_solution[start] = finish
      if @in_solution.count > 1
        check_nonhamilron(@in_solution, new_matrix_without_elements)
      end
      @modified_matrix = new_matrix_without_elements
    end
    if @modified_matrix.count > 1
      find_solution(@modified_matrix)
    end
    @in_solution
  end

end
