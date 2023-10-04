require_relative 'person'

class Student < Person
  def initialize(classroom)
    super(name, age, parent_permission: true)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.classroom_students.push(self) unless classroom.students.include?(self)
  end
end
