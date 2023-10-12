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
      person = person_class.new(person_data['age'], person_data['name'], person_data['parent_permission'])
      # Assuming 'date' is a valid key in your JSON data
      Rental.new(data['date'], book, person)
    end
  end

  def save_people
    File.open('./data/people.json', 'w') do |file|
      people_data = @people.map do |person|
        if person.is_a?(Student)
          { 'type' => 'Student', 'id' => person.id, 'name' => person.name, 'age' => person.age,
            'parent_permission' => person.parent_permission }
        elsif person.is_a?(Teacher)
          { 'type' => 'Teacher', 'id' => person.id, 'name' => person.name, 'age' => person.age, 'specialization' => person.specialization }
        end
      end
      file.puts JSON.generate(people_data)
    end
  end

  def load_people
    return unless File.exist?('./data/people.json')

    @people = []
    json_str = File.read('./data/people.json')
    begin
      people_data = JSON.parse(json_str)
    rescue JSON::ParserError
      # Handle the JSON parsing error if necessary
      return
    end
    people_data.each do |data|
      if data['type'] == 'Student'
        parent_permission = data['parent_permission'] == 'true'
        person = Student.new(data['age'], data['name'], parent_permission)
      elsif data['type'] == 'Teacher'
        person = Teacher.new(data['specialization'], data['age'].to_i, data['name'])
      end
      @people.push(person)
    end
  end
end
