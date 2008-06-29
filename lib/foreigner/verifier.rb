require 'foreigner/foreign_keys'
require 'foreigner/reporter'

class Verifier

  attr_reader :rails_root

  def initialize(rails_root)
    @rails_root = rails_root
  end

  def verify!
    path = File.join(rails_root, "app", "models")
    #puts "path: #{path}"

    fks = ForeignKeys.retrieve(ActiveRecord::Base.configurations[RAILS_ENV])

    missing_fks = {:belongs_to => [], :has_and_belongs_to_many => []}

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
        case value.macro
        when :belongs_to then
          #puts "   belongs_to : #{key}"
          primary_class_table = value.class_name.tableize
          foreign_key_field = value.respond_to?(:foreign_key) ? value.foreign_key : value.name.to_s + '_id'

          tmp_fk = ForeignKey.new(table_name, foreign_key_field, primary_class_table, "id")
        when :has_and_belongs_to_many then
          pk_table = value.class_name.tableize
          pk_field = "id"
          fk_table = value.options[:join_table] # the join table
          fk_field = value.class_name.foreign_key
          
          tmp_fk = ForeignKey.new(fk_table, fk_field, pk_table, pk_field)
        else
          next
        end
        
        # check to see if our database has the foriegn key
        unless fks.reject! {|fk| fk == tmp_fk}
          missing_fks[value.macro] << tmp_fk
        end
      end
      
    end

    Reporter.report(missing_fks, fks)

  end

end
