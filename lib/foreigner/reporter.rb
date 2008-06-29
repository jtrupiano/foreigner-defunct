
class Reporter

  def self.report(missing_fks, missing_associations)
    
    puts "\n#################################"
    puts "A/R associations that exist but do not have a corresponding foreign key"
    puts "#################################"
    missing_fks.each do |macro, fks|
      fks.each do |fk|
        puts "#{macro.to_s}: #{fk.to_s}"
      end
    end

    puts "\n\n#################################"
    puts "Foreign keys that exist in the database but do not have an A/R association"
    puts "#################################"
    missing_associations.each do |fk|
      puts "#{fk.table}.#{fk.column} => #{fk.referenced_table}.#{fk.referenced_column}"
    end

  end

end
