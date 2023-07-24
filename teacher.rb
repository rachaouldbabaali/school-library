require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(name = 'Unknown', age = nil, specialization = nil, parrent_permission: true)
    super(name, age, parrent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
