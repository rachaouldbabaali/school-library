
require_relative 'app'

class LibraryOperations
  def initialize
    @app = App.new
  end

  def execute_option(selection)
    case selection
    when 1 then @app.list_books
    when 2 then @app.list_people
    when 3 then @app.create_person
    when 4 then @app.create_book
    when 5 then @app.create_rental
    when 6 then @app.list_rentals_by_person_id
    when 7 then exit
    else puts 'Invalid choice. Please try again.'
    end
  end
end

# menu.rb
class Menu
  def display
    puts 'What would you like to do?'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person id'
    puts '7. Quit'
    print '> '
  end

  def get_selection
    gets.chomp.to_i
  end
end