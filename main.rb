require_relative 'options'
require_relative 'app' # Assuming app.rb is in the same directory

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
  options = {
    1 => -> { list_books },
    2 => -> { list_people },
    3 => -> { create_person },
    4 => -> { create_book },
    5 => -> { create_rental },
    6 => -> { list_rentals },
    7 => -> { save_data }
  }

  action = options[option]
  if action
    action.call
  else
    puts 'Invalid option. Please try again.'
  end
end

# Initialize and run the app if this file is run directly
@app = App.new.run if __FILE__ == $PROGRAM_NAME

# Prompt for user input
prompt
