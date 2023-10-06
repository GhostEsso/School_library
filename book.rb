require_relative 'rental'

class Book
  attr_reader :rentals
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_new_rental(person, date)
    Rental.new(date, self, person)
  end

  def add_rental(rental)
    @rentals << rental
  end
end
