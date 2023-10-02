class Teacher < Person
  def initialize(name = "Unknown", age = 0, specialization)
    super(id, name, age, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
