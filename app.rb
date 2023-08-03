require_relative 'classes/book_lister'
require_relative 'classes/person_lister'
require_relative 'classes/person_creator'
require_relative 'classes/book_creator'
require_relative 'classes/rental_creator'
require_relative 'classes/rental_lister'
require_relative 'classes/utility/menu'
require_relative 'classes/utility/io'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @book_lister = BookLister.new(@books)
    @person_lister = PersonLister.new(@people)
    @person_creator = PersonCreator.new(@people)
    @book_creator = BookCreator.new(@books)
    @rental_creator = RentalCreator.new(@books, @people, @rentals)
    @rental_lister = RentalLister.new(@rentals, @people, @books)
    @menu = Menu.new
    @io = @io = IO.new(
      book_lister: BookLister.new(@books),
      person_lister: PersonLister.new(@people),
      person_creator: PersonCreator.new(@people),
      book_creator: BookCreator.new(@books),
      rental_creator: RentalCreator.new(@books, @people, @rentals),
      rental_lister: RentalLister.new(@rentals, @people, @books)
    )
  end

  def start
    loop do
      @menu.print
      choice = gets.chomp.downcase
      break unless @io.handle_choice(choice)

      puts "\n"
    end
  end
end
