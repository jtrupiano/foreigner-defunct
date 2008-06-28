
class ForeignKey
  attr_reader :table, :column, :referenced_table, :referenced_column
  def initialize(table, column, referenced_table, referenced_column)
    @table = table
    @column = column
    @referenced_table = referenced_table
    @referenced_column = referenced_column
  end

  def ==(fk)
    fk.table == @table && fk.column == @column && fk.referenced_table == @referenced_table && fk.referenced_column == @referenced_column
  end

  def to_s
    "#{referenced_table}.#{referenced_column} => #{table}.#{column}"
  end
end
