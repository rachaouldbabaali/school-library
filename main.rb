# main.rb
require_relative 'operations'
require_relative 'menu'

def main
  operations = LibraryOperations.new
  menu = Menu.new

  loop do
    menu.display
    selection = menu.selection
    operations.execute_option(selection)
    puts "\n"
  end
end

main
