require_relative 'spec_helper'

describe Book do
  let(:title) { 'Sample Book' }
  let(:author) { 'John Doe' }
  let(:book) { Book.new(title, author) }

  describe '#initialize' do
    it 'creates a new book with the correct title and author' do
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
    end

    it 'initializes with an empty rentals array' do
      expect(book.rentals).to be_an(Array)
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_new_rental' do
    it 'creates a new rental for the book' do
      person = double('Person')
      date = '2023-10-12'
      rental = book.add_new_rental(person, date)

      expect(rental).to be_a(Rental)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(rental.date).to eq(date)
    end
  end

  describe '#add_rental' do
    it 'adds a rental to the rentals array' do
      rental = double('Rental')
      book.add_rental(rental)

      expect(book.rentals).to include(rental)
    end
  end
end
