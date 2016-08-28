# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    [@first_name, @middle_name, @last_name]
      .reject { |name| name == nil }
      .join(" ")
  end

  def full_name_with_middle_initial
  [@first_name, abbreviate(@middle_name), @last_name]
    .reject { |name| name == nil }
    .join(" ")
  end

  def full_name_as_initials
  [abbreviate(@first_name), abbreviate(@middle_name), abbreviate(@last_name)]
    .reject { |name| name == nil }
    .join(" ")
  end

  def abbreviate(name)
    return name if name == nil

    initial(name) + "."
  end

  def initial(name)
    return name if name == nil

    name[0]
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      guy = Person.new(
        first_name: 'Thomas',
        middle_name: 'Adam',
        last_name: 'Anderson'
      )

      expect(guy.full_name).to eq('Thomas Adam Anderson')
    end
    it "does not add extra spaces if middle name is missing" do
      guy = Person.new(
        first_name: 'Thomas',
        last_name: 'Anderson'
      )

      expect(guy.full_name).to eq('Thomas Anderson')
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first name, middle name, and last name with spaces" do
      guy = Person.new(
        first_name: 'Thomas',
        middle_name: 'Adam',
        last_name: 'Anderson'
      )

      expect(guy.full_name_with_middle_initial).to eq('Thomas A. Anderson')
    end

    it "does not add extra spaces if middle name is missing" do
      guy = Person.new(
        first_name: 'Thomas',
        last_name: 'Anderson'
      )

      expect(guy.full_name).to eq('Thomas Anderson')
    end
  end

  describe "#initials" do
    it "concatenates the initials of first name, middle name, and last name with spaces" do
      guy = Person.new(
        first_name: 'Thomas',
        middle_name: 'Adam',
        last_name: 'Anderson'
      )

      expect(guy.full_name_as_initials).to eq('T. A. A.')
    end

    it "does not add extra spaces if middle name is missing" do
      guy = Person.new(
        first_name: 'Thomas',
        last_name: 'Anderson'
      )

      expect(guy.full_name_as_initials).to eq('T. A.')
    end
  end
end
