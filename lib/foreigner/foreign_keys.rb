require 'foreigner/foreign_key'

class ForeignKeys
  
  def self.retrieve(configuration)
    fks = []
    case configuration['adapter']
    when 'mysql':
      result = ActiveRecord::Base.connection.execute(mysql_sql(configuration['database']))
      result.each_hash do |row|
        fks << ForeignKey.new(row['table_name'], row['column_name'], row['referenced_table_name'], row['referenced_column_name'])
      end
    else
      raise StandardError, "#{configuration['adapter']} is not currently supported"
    end
    fks
  end

  def self.mysql_sql(schema_name)
    sql = <<-END_OF_SQL
      SELECT table_name, column_name, referenced_table_name, referenced_column_name
      FROM information_schema.KEY_COLUMN_USAGE
      WHERE REFERENCED_TABLE_SCHEMA = '#{schema_name}'
        AND REFERENCED_TABLE_NAME is not null
      ORDER BY TABLE_NAME, COLUMN_NAME;
    END_OF_SQL
  end

end
