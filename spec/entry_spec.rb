require_relative '../models/entry'

# #1 standard first line of an RSpec test file. The file is a spec file and it tests Entry
RSpec.describe Entry do
# #2 we use context to give our test structure and communicate that all specs inside it belong to the same context. In this case, the specs in the context will test Entry attributes.
  describe "attributes" do
    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }
# #3 we separate our individual tests using the it method. Each it represents a unique test.
    it "responds to name" do
# #4 each RSpec test ends with one or more expect method, which we use to declare the expectations for the test. If expectations are met, test passes, if they are not, it fails.
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone_number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone_number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
# #5 we use a new context to separate the to_s test from the initializer tests. The # in front of to_s indicates that it is an instance method
    describe "#to_s" do
      it "prints an entry as a string" do
        entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
        expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
# #6 we use eq to check that to_s returns a string equal to expected_string.
        expect(entry.to_s).to eq(expected_string)
      end
   end
 end
end
