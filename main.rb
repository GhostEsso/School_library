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

App.new.run if __FILE__ == $PROGRAM_NAME

prompt
