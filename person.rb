require_relative 'decorators/nameable'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission, :rentals
  attr_reader :id

  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    @parent_permission || of_age?
  end

  private

  def of_age?
    @age && @age >= 18
  end

  def add_rental(person, date)
    rental = Rental.new(date, self, person)
    @rentals << rental
    person.add_rental(rental)
  end
end
