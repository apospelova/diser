class BrunchAndCut

  def initialize(distance_matrix)
    @distance_matrix = distance_matrix
    @infinity = -1_000_000_000 
  end

  def find_solution
    #for lines
    min_limit = 0
    new_line_matrix = []
    new_matrix = []
    @distance_matrix.each do |line|
      min = line.sort[1]
      min_limit = min_limit + min
      new_line = []
      line.each do |el|
        new_el = el - min
        if new_el < 0 
          new_el = @infinity
        end
        new_line << new_el
      end
      new_line_matrix << new_line
      min_limit
    end

    #for columns
    new_line_matrix.transpose.each do |column|
      min = column.sort[1]
      min_limit = min_limit + min
      new_column = []
      column.each do |el|
        new_el = el - min
        if new_el < 0 
          new_el = @infinity
        end
        new_column << new_el
      end
      new_matrix << new_column
    end
    modified_matrix = new_matrix.transpose
    min_limit

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
    debugger
    element_with_max_fines = all_fines.max_by {|fine| fine[:fines] }
    #обработка с учетом нуля с максимальным штрафов
    # without top
    way = element_with_max_fines[:fines] + min_limit
    # with top

  end

end
