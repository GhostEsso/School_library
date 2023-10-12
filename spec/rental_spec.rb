require_relative 'spec_helper'

describe Rental do
  before :each do
    @book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
    @person = Person.new(30, 'John Doe', parent_permission: true)
    @date = '2023-10-15'
    @rental = Rental.new(@date, @book, @person)
  end

  describe '#new' do
    it 'returns a new Rental object' do
      expect(@rental).to be_an_instance_of Rental
    end

    it 'has correct attributes' do
      expect(@rental.date).to eql @date
      expect(@rental.book).to eql @book
      expect(@rental.person).to eql @person
    end
  end

  describe '#book' do
    it 'returns the correct book' do
      expect(@rental.book).to eql @book
    end
  end

  describe '#person' do
    it 'returns the correct person' do
      expect(@rental.person).to eql @person
    end
  end
end
