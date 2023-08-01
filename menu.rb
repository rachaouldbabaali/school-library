def print_menu
    options = ['List all books', 'List all people', 'Create a person', 'Create a book',
               'Create a rental', 'List all rentals for a given person id', 'Exit']
    puts 'Please, select an option:'
  
    options.each.with_index(1) do |option, index|
      puts "#{index}. #{option}"
    end
end