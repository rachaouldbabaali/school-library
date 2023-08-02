class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_json(*args)
    {
      'title' => @title,
      'author' => @author
    }.to_json(*args)
  end

  def self.json_create(_object)
    new(json['title'], json['author'])
  end

  def add_rental(date, person)
    rental = Rental.new(date, self, person)
    @rentals << rental
    person.add_rental(rental)
  end
end
