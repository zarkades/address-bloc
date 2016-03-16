puts "Welcome to AddressBloc!"

require_relative 'controllers/menu_controller'

# #4 Create a new MenuController when AddressBloc starts
menu = MenuController.new
# #5 Use system "clear" to clear the command line
system "clear"
puts "Welcome to AddressBloc!"
# #6 Call main_menu to display the menu
menu.main_menu
