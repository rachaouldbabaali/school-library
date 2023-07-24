require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(name = 'Unknown', age = nil, classroom = nil, parrent_permission = true)
    super(name, age, parrent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
