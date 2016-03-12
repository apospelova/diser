class Element
  attr_reader :line_num, :column_num, :value
  attr_writer :value
  def initialize(line_num, column_num, value)
    @line_num = line_num
    @column_num = column_num
    @value = value
  end
end
