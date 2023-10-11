require 'json'
require './student'
require './teacher'
require './book'
require './rental'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_books_with_index
    @books.each_with_index { |book, i| puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
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
    @people.push(student) if student
  end

  def create_teacher
    teacher = input_teacher_details
    @people.push(teacher) if teacher
  end

  def create_book
    book = input_book_details
    @books.push(book) if book
  end

  def create_rental
    rental = input_rental_details
    @rentals.push(rental) if rental
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
      Student.new('Unknown', age, name, parent_permission: true)
    elsif %w[no n].include?(parent_permission)
      Student.new('Unknown', age, name, parent_permission: false)
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

  # data repo where we'll store nos json files
  def save_data
    save_to_json('books', @books)
    save_to_json('people', @people)
    save_to_json('rentals', @rentals)
  end

  def save_to_json(filename, data)
    File.open("data/#{filename}.json", 'w') do |file|
      file.puts JSON.generate(data)
    end
  end

  # Loading data from Json files
  def load_data
    @books = load_from_json('books')
    @people = load_from_json('people')
    @rentals = load_from_json('rentals')
  end

  def load_from_json(filename)
    return [] unless File.exist?("data/#{filename}.json")

    JSON.parse(File.read("data/#{filename}.json"))
  end

  public
  def run
    prompt
  end
end
