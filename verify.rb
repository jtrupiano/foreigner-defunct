#!/usr/bin/env ruby
rails_root = ARGV[0]
puts "rails root: #{rails_root}"
require "#{rails_root}/config/environment"
require 'foreign_keys'

path = File.join(RAILS_ROOT, "app", "models")
puts "path: #{path}"

fks = ForeignKeys.retrieve(ActiveRecord::Base.configurations[RAILS_ENV])
fks.each do |fk|
  puts "#{fk.table}.#{fk.column} => #{fk.referenced_table}.#{fk.referenced_column}"
end

Dir.glob(File.join(path, "**", "*.rb")).each do |f|
  #puts "file: #{f}"
  filename = File.split(f)[-1]
  
  begin
    model = filename.split('.')[0].classify.constantize
  rescue; next; end
  next unless model.respond_to? :table_name

  table_name = model.table_name
  #puts "looking for #{table_name}"

  model.reflections.each do |key, value|
    next unless value.macro == :belongs_to
    #puts "   belongs_to : #{key}"
    primary_class_table = value.class_name.tableize
    foreign_key_field = value.respond_to?(:foreign_key) ? value.foreign_key : value.name.to_s + '_id'

    unless fks.any? {|fk| fk.table == table_name && fk.column == foreign_key_field && fk.referenced_table == primary_class_table}
      puts "*** #{table_name}.#{foreign_key_field} => #{primary_class_table}.id failed!"
    end

  end
  
end
