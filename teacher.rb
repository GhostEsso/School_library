class Teacher < Person
  def initialize(specialization:, name: 'Unknown', age: 0)
    super(id, name, age, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
