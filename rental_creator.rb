require 'json'
require_relative 'rental'
require_relative 'book'
require_relative 'person'

class RentalCreator
  def initialize(books, people, rentals)
    @books = books
    @people = people
    @rentals = rentals
  end

  def create_rental

    book = select_book_from_list
    return unless book

    person = select_person_from_list
    return unless person

    rental_date = read_rental_date_from_user_input
    create_new_rental(rental_date, book, person)
    puts "Created rental for '#{book.title}' by #{book.author} " \
         "on #{rental_date}, for #{person.name} (id: #{person.id})."
    save_rentals_to_json
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  end

  def select_book_from_list
    puts 'Available books:'
    load_books_from_json_file('books.json') if @books.empty?
    @books.each_with_index do |book, index|
      puts "#{index}) Title:\"#{book.title}\", Author:#{book.author}"
    end
    print 'Select a book (by index): '
    book_index = gets.chomp.to_i
    @books[book_index]
  end

  def select_person_from_list
    display_people_list
    person_index = read_person_index_from_user_input
    @people[person_index]
  end

  def display_people_list
    puts 'Available people:'
    load_people_from_json_file('people.json') if @people.empty?
    @people.each_with_index do |person, index|
      display_person_info(person, index)
    end
  end

  def read_person_index_from_user_input
    print 'Select a person (by index): '
    gets.chomp.to_i
  end

  def display_person_info(person, index)
    if person.is_a?(Student)
      puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    elsif person.is_a?(Teacher)
      puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    else
      puts "#{index}) Unknown person type"
    end
  end

  def read_rental_date_from_user_input
    print 'Rental date (yyyy-mm-dd): '
    gets.chomp
  end

  def create_new_rental(rental_date, book, person)
    rental = Rental.new(rental_date, book, person)
    @rentals << rental
    rental
  end

  def save_rentals_to_json
    File.write('rentals.json', JSON.pretty_generate(@rentals))
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



end
