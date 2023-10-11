require 'json'

class DataManager
  attr_accessor :books, :rentals, :people

  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  # Load Data
  def load_data
    load_books
    load_rentals
    load_people
  end

  # Save Data
  def save_data
    save_books
    save_rentals
    save_people
    puts 'Data saved!'
  rescue StandardError => e
    puts "Error Saving Data: #{e.message}"
  end

  private

  def save_books
    # Use File.open with a block to automatically close the file after writing
    File.open('./data/books.json', 'w') do |file|
      book_data = @books.map { |book| { 'title' => book.title, 'author' => book.author } }
      file.puts JSON.generate(book_data)
    end
  end

  def load_books
    return unless File.exist?('./data/books.json')

    json_str = File.read('./data/books.json')
    book_data = JSON.parse(json_str)

    @books = book_data.map do |data|
      Book.new(data['title'], data['author'])
    end
  end

  def save_rentals
    rentals_data = @rentals.map do |rental|
      {
        'date' => rental.date,
        'book' => { 'title' => rental.book.title, 'author' => rental.book.author },
        'person' => { 'type' => rental.person.class.name, 'age' => rental.person.age, 'name' => rental.person.name }
      }
    end

    File.open('./data/rentals.json', 'w') do |file|
      file.puts JSON.generate(rentals_data)
    end
  end

  def load_rentals
    return unless File.exist?('./data/rentals.json')

    json_str = File.read('./data/rentals.json')
    rentals_data = JSON.parse(json_str)

    @rentals = rentals_data.map do |data|
      book_data = data['book']
      person_data = data['person']
      book = Book.new(book_data['title'], book_data['author'])
      person_class = Object.const_get(person_data['type'])
      person = person_class.new(person_data['age'], person_data['name'])
      Rental.new(data['date'], book, person)
    end
  end

  def create_person(type, age, name)
    person = Object.const_get(type).new(age, name)
    @people.push(person)
    save_people
  end

  def save_people
    # Load existing people data
    existing_people = []
    if File.exist?('./data/people.json')
      json_str = File.read('./data/people.json')
      existing_people = JSON.parse(json_str)
      existing_people = [] unless existing_people.is_a?(Array) # Ensure it's an array
    end

    # Append the new person
    @people.each do |person|
      existing_people << if person.is_a?(Student)
                           { type: 'Student', id: person.id, name: person.name, age: person.age,
                             parent_permission: person.parent_permission }
                         else
                           { type: 'Teacher', id: person.id, name: person.name, age: person.age,
                             parent_permission: person.parent_permission, specialization: person.specialization }
                         end
    end

    # Save the updated data
    File.open('./data/people.json', 'w') do |file|
      file.puts JSON.pretty_generate(existing_people)
    end
  end

  def load_people
    return unless File.exist?('classes/people.json')

    @people = []
    File.foreach('classes/people.json') do |line|
      element = JSON.parse(line)
      new_person = if element['type'] == 'Student'
                     Student.new(element['id'], element['name'], element['age'], element['parent_permission'])
                   else
                     Teacher.new(element['id'], element['name'], element['age'], element['specialization'])
                   end
      @people.push(new_person)
    end
  end
end
