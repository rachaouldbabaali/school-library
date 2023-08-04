require './decorators/decorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    to_capitalize(@nameable.correct_name)
  end

  def to_capitalize(name)
    name.capitalize
  end
end
