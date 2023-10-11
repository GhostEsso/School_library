require_relative 'nameable'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

class Person < Nameable
  attr_accessor :name, :age, :rental

  attr_reader :id, :classroom

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental = []
  end

  def correct_name
    @name
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end

  def add_new_rental(book, date)
    @rental << Rental.new(date, book, self)
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    Time.now.to_i
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end

  def to_hash
    {
      'type' => self.class.name,
      'age' => @age,
      'name' => @name
    }
  end
end

Person.new(22, 'maximilianus')
