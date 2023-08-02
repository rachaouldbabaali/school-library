class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @book.rentals << self
    @person.rentals << self
  end

  def to_json(*args)
    {
      'date' => @date,
      'book' => @book,
      'person' => @person
    }.to_json(*args)
  end

  def self.json_create(_object)
    new(json['date'], json['book'], json['person'])
  end
end
