require './classes/nameable'
require './decorators/capitalize_decorator'
require './decorators/trimmer_decorator'
require './classes/book'
require './classes/rental'

class Person < Nameable
  attr_reader :parent_permission
  attr_accessor :name, :age, :rentals

  def initialize(age, name: 'Unknown', parent_permission: true)
    super()
    @id = rand(1000..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end
end
