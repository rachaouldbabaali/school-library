require_relative 'decorators/nameable'

class Person < Nameable
  attr_accessor :name, :age, :parrent_permission
  attr_reader :id

  def initialize(name = 'Unknown', age = nil, parrent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parrent_permission = parrent_permission
  end

  def correct_name
    @name
  end

  def can_use_services?
    @parrent_permission || of_age?
  end

  private

  def of_age?
    @age && @age >= 18
  end
end
