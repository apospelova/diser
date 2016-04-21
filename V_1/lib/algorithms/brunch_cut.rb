class BrunchAndCut

  def initialize()
    @min_limit = 0
    @in_solution = {}
    @no_solution = {}
  end

  def find_minimal(item, el)
    copy_item = item.clone
    copy_item.delete(el)
    minimal = copy_item.min_by{|k, v| v[:distance]}[1][:distance]
    if minimal == INFINITY
      minimal = el
    end
    minimal
  end

  def calc_cost_for_line_and_column(item)
    min = item.min_by{|k, v| v[:distance]}[1][:distance]
    @min_limit = @min_limit + min
    new_item = []
    item.each do |el|
      new_value = el[1][:distance] - min
      el[1][:distance] = new_value
      new_item << el
    end
    new_item.to_h
  end

  def check_nonhamilton(collection, matrix)
    #sort collection
    copy_collection = Marshal.load(Marshal.dump(collection))
    collection.each do |start_ver, finish_ver|
      copy_collection.each do |copy_start, copy_finish|
        if finish_ver == copy_start && matrix[copy_finish] != nil && matrix[copy_finish][start_ver] != nil
          matrix[copy_finish][start_ver][:distance] = INFINITY
        end
      end
    end
    if Size_start_matrix > collection.size
      matrix.each do |line_num, line|
        line.each do |column_num, value|
          copy_collection = Marshal.load(Marshal.dump(collection))
          copy_collection[line_num] = column_num
          i = 0
          res = []
          while i < copy_collection.length
            res << copy_collection[res.last]
            if res.last == nil
              res = [copy_collection.keys[i]] 
              next
            end
            if res.last == res.first
              matrix[line_num][column_num][:distance] = INFINITY
              break
            end
            i += 1
          end
        end
      end
    end
  end

  def find_best_zero(line, pos_line, el, pos_column)
    if el[:distance] == 0 
      el_with_fines = {}
      min_by_line = find_minimal(line, pos_column)
      #for column
      value_in_column = {}
      @modified_matrix.each do |key, line|
        value = line[pos_column][:distance]
        value_in_column[key] = value 
      end
      value_in_column.delete(pos_line)
      min_by_column = value_in_column.min_by{|k, v| v}[1]
      #calc
      fines = min_by_line + min_by_column
      el_with_fines = {fines: fines, position: [pos_line, pos_column]}
      @all_fines << el_with_fines
    end
    @all_fines
  end

  def stage_2(matrix)
    @modified_matrix = matrix.clone
    new_line_matrix = {}
    @new_matrix = {}
    #for_lines
    @modified_matrix.each do |key, line|
      new_line_matrix[key] = calc_cost_for_line_and_column(line)
    end

    #for columns
    column_nums = new_line_matrix.first[1].keys
    column_nums.each do |column_num|
      value_in_column = []
      new_line_matrix.each do |key, line|
        value = line[column_num][:distance]
        value_in_column << value 
      end
      @min_in_column = value_in_column.min
      @min_limit += @min_in_column
      new_line_matrix.each do |key, line|
        line[column_num][:distance] -= @min_in_column
      end
    end
    new_line_matrix
  end

  def solution_with_edge()
    @modified_matrix_with = Marshal.load(Marshal.dump(@modified_matrix))
    if @modified_matrix_with[@pos_column] != nil && @modified_matrix_with[@pos_column][@pos_line] != nil
      @modified_matrix_with[@pos_column][@pos_line][:distance] = INFINITY
    end
    @modified_matrix_with.delete(@pos_line)
    @modified_matrix_with.each do |line_num, line|
      line.delete(@pos_column)
    end    
    @common_limit = @min_limit
    @min_limit = 0
    stage_2(@modified_matrix_with)
    @cost_of_path_with = @common_limit + @min_limit
  end

  def select_optimal_way()
    if @cost_of_path_with > @cost_of_path_without
      @min_limit = @cost_of_path_without
      @no_solution[@pos_line] = @pos_column
      @modified_matrix = @modified_matrix_without
    else 
      @min_limit = @common_limit
      @in_solution[@pos_line] = @pos_column
      if @in_solution.count > 1
        check_nonhamilton(@in_solution, @modified_matrix_with)
      end
      @modified_matrix = @modified_matrix_with
    end
  end

  def find_solution(current_distance_matrix)

    @modified_matrix = stage_2(current_distance_matrix)
    #stage 2(main) fines count
    @all_fines = []
    @modified_matrix.each do |line_num, line|
      line.each do |column_num, el|
        find_best_zero(line, line_num, el, column_num)
      end
    end
    element_with_max_fines = @all_fines.max_by {|fine| fine[:fines] }
    @pos_line = element_with_max_fines[:position][0]
    @pos_column = element_with_max_fines[:position][1]
    #without top
    @cost_of_path_without = element_with_max_fines[:fines] + @min_limit
    @modified_matrix_without = Marshal.load(Marshal.dump(@modified_matrix))
    @modified_matrix_without[@pos_line][@pos_column][:distance] = INFINITY
    #with top
    @cost_of_path_with = solution_with_edge()
    select_optimal_way()
    if @modified_matrix.count > 1
      find_solution(@modified_matrix)
    else
      @in_solution[@modified_matrix.first[0]] = @modified_matrix[@modified_matrix.first[0]].first[0]
    end
    @in_solution
  end

end
