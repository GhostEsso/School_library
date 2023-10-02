class Person
    # Using attr_accessor to create the read and write methods for :name and :age.
    attr_accessor :name, :age
  
    # Using attr_reader to create the read method for :id.
    attr_reader :id

    # The constructor of the Person class with default parameters.
    def initialize(name = "Unknown", age = 0, parent_permission = true)
        # Generation of a random identifier.
      @id = generate_id

        # Assignment of values ​​passed as parameters to instance variables.
      @name = name
      @age = age
      @parent_permission = parent_permission
    end
  
    # Method to determine if the person can use the services (based on age and parental permission).
    def can_use_services?
      of_age? || @parent_permission
    end
  
    private
  
    # Method to check if the person is an adult.
    def of_age?
      @age >= 18
    end
  
    # Method to generate a random identifier.
    def generate_id
      rand(1..1000)
    end
  end
  