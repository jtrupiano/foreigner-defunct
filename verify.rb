#!/usr/bin/env ruby
rails_root = ARGV[0]

require "#{rails_root}/config/environment"
require 'foreign_keys'

path = File.join(RAILS_ROOT, "app", "models")
#puts "path: #{path}"

fks = ForeignKeys.retrieve(ActiveRecord::Base.configurations[RAILS_ENV])

puts "\n#################################"
puts "A/R associations that exist but do not have a corresponding foreign key"

Dir.glob(File.join(path, "**", "*.rb")).each do |f|
  #puts "file: #{f}"
  filename = File.split(f)[-1]
  
  begin
    model = filename.split('.')[0].classify.constantize
  rescue => ex
    puts "**** Error loading file: #{filename}: #{ex.message} ****** ignoring"
  end

  next unless model.respond_to? :table_name

  table_name = model.table_name
  #puts "looking for #{table_name}"

  model.reflections.each do |key, value|
    if value.macro == :belongs_to
      #puts "   belongs_to : #{key}"
      primary_class_table = value.class_name.tableize
      foreign_key_field = value.respond_to?(:foreign_key) ? value.foreign_key : value.name.to_s + '_id'

      tmp_fk = ForeignKey.new(table_name, foreign_key_field, primary_class_table, "id")

      unless fks.reject! {|fk| fk == tmp_fk}
        puts "belongs_to: #{tmp_fk.to_s}"
      end
    elsif value.macro == :has_and_belongs_to_many
      pk_table = value.class_name.tableize
      pk_field = "id"
      fk_table = value.options[:join_table] # the join table
      fk_field = value.class_name.foreign_key
      
      tmp_fk = ForeignKey.new(fk_table, fk_field, pk_table, pk_field)

      unless fks.reject! {|fk| fk == tmp_fk}
        puts "habtm: #{tmp_fk.to_s}"
      end
    end
  end
  
end

puts "\n\n#################################"
puts "Foreign keys that exist in the database but do not have an A/R association"
fks.each do |fk|
  puts "#{fk.table}.#{fk.column} => #{fk.referenced_table}.#{fk.referenced_column}"
end

