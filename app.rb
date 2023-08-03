require 'json'
require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'rental'
require_relative 'student'
require_relative 'person_creator'
require_relative 'book_creator'
require_relative 'rental_creator'

# The main application class for managing rentals of books to people.
class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_books
    puts 'All books:'
    load_books_from_json_file('books.json') if @books.empty?

    if @books.empty?
      puts 'No books available.'
      return
    end
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts 'All people:'
    load_people_from_json_file('people.json') if @people.empty?

    if @people.empty?
      puts 'No people available.'
      return
    end

    @people.each do |person|
      if person.is_a?(Student)
        puts "[Student] Name: #{person.name}, Age: #{person.age}, Parent Permission: #{person.parent_permission}"
      else
        puts "[Teacher] Name: #{person.name}, Age: #{person.age}, Specialization: #{person.specialization}"
      end
    end
  end

  # def create_person
  #   puts 'Do you want to create a Student (1) or Teacher (2)? [Input the number]:'
  #   choice = gets.chomp.to_i
  #   person_creator = PersonCreator.new(@people)
  #   case choice
  #   when 1
  #     person_creator.create_student
  #   when 2
  #     person_creator.create_teacher
  #   end
  # end
  def create_person
    puts 'Do you want to create a Student (1) or Teacher (2)? [Input the number]:'
    choice = gets.chomp.to_i
    person_creator = PersonCreator.new(@people)
    case choice
    when 1
      person = person_creator.create_student
    when 2
      person = person_creator.create_teacher
    end
    existing_person = find_person_by_name_and_age(person.name, person.age)
    if existing_person
      puts "Person '#{person.name}' already exists with ID #{existing_person.id}."
      person.id = existing_person.id
    else
      @people << person
    end
    save_people_to_json
  end
  
  def find_person_by_name_and_age(name, age)
    @people.find { |p| p.name == name && p.age == age }
  end
  
  def save_people_to_json
    File.open('people.json', 'w') do |file|
      json_data = @people.map do |person|
        {
          'name' => person.name,
          'age' => person.age,
          'id' => person.id,
          'person_type' => person.class.name,
          'parent_permission' => person.parent_permission,
          'specialization' => person.specialization
        }
      end
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def create_book
    book_creator = BookCreator.new(@books)
    book_creator.create_book
  end

  def create_rental
    rental_creator = RentalCreator.new(@books, @people, @rentals)
    rental_creator.create_rental
  end

  def read_person_id_from_user_input
    print 'Person id: '
    gets.chomp.to_i
  end

  def find_person_by_id(id)
    person = @people.find { |p| p.id == id }
    unless person
      puts "Could not find person with id #{id}."
      return nil
    end
    person
  end

  def get_rentals_by_person(person)
    @rentals.select { |r| r.person == person }
  end

  def print_rentals(rentals)
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def load_books_from_json_file(file_path)
    json_data = File.read(file_path)
    books_data = JSON.parse(json_data)

    @books = books_data.map { |data| Book.new(data['title'], data['author']) }

    puts "Books loaded from #{file_path}."
  rescue StandardError => e
    puts "Error loading books: #{e.message}"
  end

  def load_people_from_json_file(file_path)
    json_data = File.read(file_path)
    people_data = JSON.parse(json_data)

    @people = people_data.map do |data|
      if data['person_type'] == 'Student'
        Student.new(data['name'], data['age'], parent_permission: data['parent_permission'])
      else
        Teacher.new(data['name'], data['age'], data['specialization'])
      end
    end

    puts "People loaded from #{file_path}."
  rescue StandardError => e
    puts "Error loading people: #{e.message}"
  end

  def list_rentals_by_person_id
    load_rentals_from_json_file('rentals.json') if @rentals.empty?
    if @rentals.empty?
      puts 'No rentals available.'
      return
    end
  
    person_id = read_person_id_from_user_input
    return if person_id.nil?
  
    puts "Rentals for person with id #{person_id}:"
  
    @rentals.each do |rental|
      puts "Checking rental: #{rental.date}, Book: #{rental.book.title}, Author: #{rental.book.author}, Person ID: #{rental.person.id}"
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book: #{rental.book.title}, Author: #{rental.book.author}"
      end
    end
  end

  def load_rentals_from_json_file(file_path)
    json_data = File.read(file_path)
    rentals_data = JSON.parse(json_data)

    @rentals = rentals_data.map do |data|
      book = Book.new(data['book']['title'], data['book']['author'])
      person = if data['person']['person_type'] == 'Student'
                 Student.new(data['person']['name'], data['person']['age'], parent_permission: data['person']['parent_permission'])
               else
                 Teacher.new(data['person']['name'], data['person']['age'], data['person']['specialization'])
               end
      Rental.new(data['date'], book, person)
    end

    puts "Rentals loaded from #{file_path}."
  rescue StandardError => e
    puts "Error loading rentals: #{e.message}"
  end
end
