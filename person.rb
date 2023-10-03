require_relative 'nameable'

class Person < Nameable
  # Using attr_accessor to create the read and write methods for :name and :age.
  attr_accessor :name, :age

  # Using attr_reader to create the read method for :id.
  attr_reader :id

  # The constructor of the Person class with default parameters.
  def initialize(id, age, name: 'Unknown', parent_permission: true)
    # Generation of a random identifier.
    @id = id

    # Assignment of values ​​passed as parameters to instance variables.
    @name = name
    @age = age
    @parent_permission = parent_permission
    super()
  end

  # Method to determine if the person can use the services (based on age and parental permission).
  def can_use_services?
    @age >= 18 || @parent_permission
  end

  # Method to check if the person is an adult.
  def of_age?
    @age >= 18
  end

  def correct_name
    @name
  end
end

n1 = Person.new(1, 25)
puts n1.of_age?
