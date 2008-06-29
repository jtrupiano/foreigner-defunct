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

      # assocation is the name used to access the association, 
      # reflection is the actual A/R object that represents the association
      model.reflections.each do |association, reflection|
        case reflection.macro
        when :belongs_to then
          # ignore polymorphics
          next if reflection.options[:polymorphic]

          #puts "   belongs_to : #{association}"
          primary_class_table = reflection.class_name.tableize
          foreign_key_field = reflection.respond_to?(:foreign_key) ? reflection.foreign_key : reflection.name.to_s + '_id'

          tmp_fk = ForeignKey.new(table_name, foreign_key_field, primary_class_table, "id")
        when :has_and_belongs_to_many then
          pk_table = reflection.class_name.tableize
          pk_field = "id"
          fk_table = reflection.options[:join_table] # the join table
          fk_field = reflection.class_name.foreign_key
          
          tmp_fk = ForeignKey.new(fk_table, fk_field, pk_table, pk_field)
        else
          next
        end
        
        # check to see if our database has the foriegn key
        unless fks.reject! {|fk| fk == tmp_fk}
          missing_fks[reflection.macro] << tmp_fk
        end
      end
      
    end

    Reporter.report(missing_fks, fks)

  end

end
