require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(name = 'Unknown', age = nil, specialization = nil)
    super(name, age)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
