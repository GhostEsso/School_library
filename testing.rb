require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

person = Person.new(22, 'maximilianus')
puts "Person's correct name: #{person.correct_name}"

capitalized_person = CapitalizeDecorator.new(person)
puts "Capitalized person's correct name: #{capitalized_person.correct_name}"

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts "Capitalized and trimmed person's correct name: #{capitalized_trimmed_person.correct_name}"
