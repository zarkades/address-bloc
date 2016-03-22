# #1 Include AddressBook using require_relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu

# #2 Display the main menu options to the command line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

# #3 Retrieve user input from the command line using gets.
    selection = gets.to_i
# #7 Use a case statement operator to determine the proper response to the user's input
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      puts "Good-bye!"
# #8 Terminate the program using exit(0). 0 signals the program is exiting without an error
      exit(0)
# #9 Use an else to catch invalid user imput and prompt user to retry
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

# #10 Stub the rest of the methods called in main_menu
    def view_all_entries
# #14 Iterate through all entries in AddressBook using each
      address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
# #15 Call entry_submenu to display a submenu for each entry. Add this method at bottom of MenuController
        entry_submenu(entry)
      end

      system "clear"
      puts "End of entries"
    end

    def create_entry
# #11 Clear the screen before displaying the create entry prompts
      system "clear"
      puts "New AddressBloc Entry"
# #12 Use print to prompt the user for each Entry attribute. Pring works just like puts except it doesn't add a newline
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

# #13 Add a new entry to address_book using add_entry to ensure that the new entry is added in proper order
      address_book.add_entry(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def search_entries
 # #9 Get the name that the user wants to search for and store it in name.
      print "Search by name: "
      name = gets.chomp
 # #10 Call search on address_book which will either return a match or nil, it will never return and empty string since import_from_csv will fail if entry does not have a name.
      match = address_book.binary_search(name)
      system "clear"
 # #11 Check if search returned a match. This expression evaluates to false if search returns nil since nil evaltuates to false in Ruby. If search finds a match then call helper method search_submenu to display list of operations that can be performed on an Entry.
      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end
    end

    def search_submenu(entry)
 # #12 Print out the submenu for an entry
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
 # #13 Save the user input to selection
     selection = gets.chomp

 # #14 Use a case statement to take a specific action based on user input.
     case selection
     when "d"
       system "clear"
       delete_entry(entry)
       main_menu
     when "e"
       edit_entry(entry)
       system "clear"
       main_menu
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       puts entry.to_s
       search_submenu(entry)
     end
    end

    def delete_entry(entry)
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
# #4 Perform a series of print statements followed by gets.chomp assignment statements
      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp
# #5 Use !attribute.empty? to set attributes on entry only if a valid attribute was read from user input
      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"
# #6 Print out entry with the updated attributes
      puts "Updated entry:"
      puts entry
    end

    def read_csv
  # #1 Prompt the user to enter a name of a CSV file to import. Call the chomp method to remove newlines
      print "Enter CSV file to import: "
      file_name = gets.chomp
  # #2 Check to see if the file name is empty. If empty we retunr the user makc to main menu
      if file_name.empty?
        system "clear"
        puts "no CSV file read"
        main_menu

      end

  # #3 Import the spefified file with import_from_csv on address_book. Then clear screen and print number of entries read from file.
      begin
        entry_count = address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end
    end

    def entry_submenu(entry)
# #16 Display the submenu options
      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

# #17  Chomp removes any trailing whitepsace from the strong gets returns
      selection = gets.chomp

      case selection
# #18 When user asks to see next entry, control will be returned to view_all_entries
      when "n"
# #19 User will be shown next entry (deleting and editng in later checkpoint)
      when "d"
# #7 When a user is viewing the submenu and they press d, we call delete_entry. After the entry is deleted, control will return to view_all_entries and next entry will be displayed.
        delete_entry(entry)
      when "e"
# #8 Call edit_entry when user presses e. Then display submenu with entry_submenu for the entry under edit.
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system "clear"
        main_menu
# #20 We return the user to the main menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
      end
    end
end
