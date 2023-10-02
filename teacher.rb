require_relative 'person'

class Teacher < Person
  def initialize(specialization)
    super(id, name, age, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
