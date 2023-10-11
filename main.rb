require_relative 'options'
require './app'

def prompt
  puts 'Welcome to School Library App!'
  loop do
    show_options
    option = gets.chomp.to_i
    break if option == 7

    call_option(option)
  end
end

def call_option(option)
  case option
  when 1
    list_books
  when 2
    list_people
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental
  when 6
    list_rentals
  when 7
    save_data
  else
    puts 'Invalid option. Please try again.'
  end
end

# Appelle la méthode run de la classe App
@app = App.new.run if __FILE__ == $PROGRAM_NAME

# Appelle la méthode prompt pour démarrer l'application
prompt
