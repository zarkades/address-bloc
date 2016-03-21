# #8 we tell Ruby to load the library named entry.rb relative to address_book.rb file path using require_relative
require_relative "entry.rb"
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
# #9 we create a variable to store the insertion of index
    index = 0
    entries.each do |entry|
# #10 We compare name with the name of the current entry
      if name < entry.name
        break
      end
      index += 1
    end
# #11 we insert a new entry into entries using the calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

# #7 Define import_from_csv. Method reads file in CSV format. Using CSV class to parse the file. Result is an object of type CSV::Table
 def import_from_csv(file_name)
   csv_text = File.read(file_name)
   csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
# #8 Iterate over the CSV::Table object's rows. Create a hash for each row, and convert each row_hash to an Entry by using add_entry method
   csv.each do |row|
     row_hash = row.to_hash
     add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
   end

 end
end
