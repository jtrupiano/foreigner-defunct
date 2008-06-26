
class ForeignKey
  attr_reader :table, :column, :referenced_table, :referenced_column
  def initialize(table, column, referenced_table, referenced_column)
    @table = table
    @column = column
    @referenced_table = referenced_table
    @referenced_column = referenced_column
  end
end
