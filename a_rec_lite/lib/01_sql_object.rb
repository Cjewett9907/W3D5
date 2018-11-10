require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
      return @results unless @results.nil?
    results = DBConnection.execute2(<<-SQL)
      SELECT
      *
      FROM
      cats
      LIMIT 1
      SQL
      
      @results = results[0].map do |el|
        el.to_sym
      end
    # ...
  end

  def self.finalize!

      self.columns.each do |col|
        define_method(col) do
          self.attributes[col]


        end
      end

      define_method("#{name}=") do |val|
        self.attributes[col] = val
      end


  end

  def self.table_name=(table_name)
    # define_method(self, table_name) do
    #   self.table_name = "#{self}s".downcase
    # end
    # define_method("#{self}=") {|value| instance_variable_set("#{self}", value)}
    @table_name = table_name
    # p "#{self}s".downcase

  end



  def self.table_name
    # define_method(table_name) do
    #   "@#{table_name}"
    # end
    @table_name ||= "#{self}s".downcase
    # define_method("#{self}") {instance_variable_get(self)}

  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}

  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
