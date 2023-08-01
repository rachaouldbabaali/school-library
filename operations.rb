# operations.rb
require_relative 'app'

class LibraryOperations
  def initialize
    @app = App.new
    @operations = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_by_person_id,
      7 => :exit
    }
  end

  def execute_option(selection)
    operation = @operations[selection]
    if operation
      send(operation)
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  private

  def list_books
    @app.list_books
  end

  def list_people
    @app.list_people
  end

  def create_person
    @app.create_person
  end

  def create_book
    @app.create_book
  end

  def create_rental
    @app.create_rental
  end

  def list_rentals_by_person_id
    @app.list_rentals_by_person_id
  end

  def exit
    Kernel.exit
  end
end
