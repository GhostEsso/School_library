require './json_helper'
require './student'
require './teacher'
require './book'
require './rental'
require_relative 'data/data_manager'

class App
  include JsonHelper

  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @rentals = []
    @people = []
    # define Data manager here
    @data_manager = DataManager.new
    # load data used here as Callback func
    load_data
  end

  # load Data
  def load_data
    @data_manager.load_data
    @books = @data_manager.books
    @people = @data_manager.people
    @rentals = @data_manager.rentals
  end

  # save data
  def save_data
    @data_manager.save_books
    @data_manager.save_rentals
    @data_manager.save_people
    puts 'Data saved!'
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_books_with_index
    @books.each_with_index { |book, i| puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      if person.is_a?(Student)
        puts "[#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}, Parent_Permission: #{person.parent_permission}"
      elsif person.is_a?(Teacher)
        puts "[#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}, Specialization: #{person.specialization}"
      else
        puts 'Unknown person type'
      end
    end
  end

  def list_people_with_index
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp.to_i
    case choice
    when 1
      create_student
    when 2
      create_teacher
    else
      puts "Error: Invalid choice (#{choice})"
    end
  end

  def create_student
    student = input_student_details
    @data_manager.people.push(student) if student
    @data_manager.save_data
  end

  def create_teacher
    teacher = input_teacher_details
    @data_manager.people.push(teacher) if teacher
    @data_manager.save_data # Sauvegarde après l'ajout de l'enseignant
  end

  def create_book
    book = input_book_details
    @data_manager.books.push(book) if book
    @data_manager.save_data # Sauvegarde après l'ajout du livre
  end

  def create_rental
    rental = input_rental_details
    @data_manager.rentals.push(rental) if rental
    @data_manager.save_data # Sauvegarde après l'ajout de la location
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    selected_rentals = @rentals.select { |rental| rental.person.id == id }
    if selected_rentals.empty?
      puts "Person with id=#{id} doesn't exist"
    else
      puts 'Rentals:'
      selected_rentals.each do |rental|
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end

  private

  def input_student_details
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.to_s
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.strip.downcase

    if %w[yes y].include?(parent_permission)
      Student.new(age, name, true) # true for parent permission
    elsif %w[no n].include?(parent_permission)
      Student.new(age, name, false) # false for no parent permission
    else
      puts "Error: Invalid parent permission value (#{parent_permission})"
      nil
    end
  end

  def input_teacher_details
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.to_s
    print 'Specialization: '
    specialization = gets.chomp.to_s
    Teacher.new(specialization, age, name)
  end

  def input_book_details
    print 'Title: '
    title = gets.chomp.to_s
    print 'Author: '
    author = gets.chomp.to_s
    Book.new(title, author)
  end

  def input_rental_details
    book_index = select_book_index
    if book_index.nil?
      puts "Can not add a record. Book #{book_index} doesn't exist"
      return nil
    end
    person_index = select_person_index
    if person_index.nil?
      puts "Can not add a record. Person #{person_index} doesn't exist"
      return nil
    end
    print 'Date: '
    date = gets.chomp.to_s
    book = @books[book_index]
    person = @people[person_index]
    Rental.new(date, book, person)
  end

  def select_book_index
    puts 'Select a book from the following list by number'
    list_books_with_index
    book_index = gets.chomp.to_i
    (0...@books.length).include?(book_index) ? book_index : nil
  end

  def select_person_index
    puts "\nSelect a person from the following list by number (not id)"
    list_people_with_index
    person_index = gets.chomp.to_i
    (0...@people.length).include?(person_index) ? person_index : nil
  end

  public

  def run
    load_data
    prompt
  end
end
