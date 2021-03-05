require "byebug"

# class Library
#   attr_accessor :address, :phone, :books

#   def initialize(address, phone)
#     @address = address
#     @phone = phone
#     @books = []
#   end

#   def check_in(book)
#     books.push(book)
#   end

#   def display_books
#     books.each { |book| book.display_data }
#   end
# end

# class Book
#   attr_accessor :title, :author, :isbn

#   def initialize(title, author, isbn)
#     @title = title
#     @author = author
#     @isbn = isbn
#   end

#   def display_data
#     puts "---------------"
#     puts "Title: #{title}"
#     puts "Author: #{author}"
#     puts "ISBN: #{isbn}"
#     puts "---------------"
#   end
# end

# community_library = Library.new('123 Main St.', '555-232-5652')
# learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
# little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
# wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

# community_library.check_in(learn_to_program)
# community_library.check_in(little_women)
# community_library.check_in(wrinkle_in_time)

# # community_library.books.display_data => Wrong because it's calling Array#display_data, which doesn't exist
# community_library.display_books



# class Animal
#   def initialize(diet, superpower)
#     @diet = diet
#     @superpower = superpower
#   end

#   def move
#     puts "I'm moving!"
#   end

#   def superpower
#     puts "I can #{@superpower}!"
#   end
# end

# class Fish < Animal
#   def move
#     puts "I'm swimming!"
#   end
# end

# class Bird < Animal
# end

# class FlightlessBird < Bird
#   def initialize(diet, superpower)
#     super
#   end

#   def move
#     puts "I'm running!"
#   end
# end

# class SongBird < Bird
#   def initialize(diet, superpower, song)
#     super(diet, superpower)
#     @song = song
#   end

#   def move
#     puts "I'm flying!"
#   end
# end

# # Examples

# p unicornfish = Fish.new(:herbivore, 'breathe underwater')
# p penguin = FlightlessBird.new(:carnivore, 'drink sea water')
# p robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')



# class Person
#   attr_reader :name
#   attr_accessor :location

#   def initialize(name)
#     @name = name
#   end

#   def teleport_to(latitude, longitude)
#     @location = GeoLocation.new(latitude, longitude)
#   end
# end

# class GeoLocation
#   attr_reader :latitude, :longitude

#   def initialize(latitude, longitude)
#     @latitude = latitude
#     @longitude = longitude
#   end

#   def to_s
#     "(#{latitude}, #{longitude})"
#   end

#   def ==(other_location)
#     self.to_s == other_location.to_s
#   end
# end

# # Example

# ada = Person.new('Ada')
# ada.location = GeoLocation.new(53.477, -2.236)

# grace = Person.new('Grace')
# grace.location = GeoLocation.new(-33.89, 151.277)

# ada.teleport_to(-33.89, 151.277)

# puts ada.location                   # (-33.89, 151.277)
# puts grace.location                 # (-33.89, 151.277)
# puts ada.location == grace.location # expected: true
#                                     # actual: false



# class EmployeeManagementSystem
#   attr_reader :employer

#   def initialize(employer)
#     @employer = employer
#     @employees = []
#   end

#   def add(employee)
#     if exists?(employee)
#       puts "Employee serial number is already in the system."
#     else
#       employees.push(employee)
#       puts "Employee added."
#     end
#   end

#   alias_method :<<, :add

#   def remove(employee)
#     if !exists?(employee)
#       puts "Employee serial number is not in the system."
#     else
#       employees.delete(employee)
#       puts "Employee deleted."
#     end
#   end

#   def exists?(employee)
#     employees.any? { |e| e == employee }
#   end

#   def display_all_employees
#     puts "#{employer} Employees: "

#     employees.each do |employee|
#       puts ""
#       puts employee.to_s
#     end
#   end

#   private

#   attr_accessor :employees
# end

# class Employee
#   attr_reader :name

#   def initialize(name, serial_number)
#     @name = name
#     @serial_number = serial_number
#   end

#   def ==(other)
#     serial_number == other.serial_number
#   end

#   def to_s
#     "Name: #{name}\n" +
#     "Serial No: #{abbreviated_serial_number}"
#   end

#   protected

#   attr_reader :serial_number

#   def abbreviated_serial_number
#     serial_number[-4..-1]
#   end
# end

# # Example

# miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

# becca = Employee.new('Becca', '232-4437-1932')
# raul = Employee.new('Raul', '399-1007-4242')
# natasha = Employee.new('Natasha', '399-1007-4242')

# miller_contracting << becca     # => Employee added.
# miller_contracting << raul      # => Employee added.
# miller_contracting << raul      # => Employee serial number is already in the system.
# miller_contracting << natasha   # => Employee serial number is already in the system.
# miller_contracting.remove(raul) # => Employee deleted.
# miller_contracting.add(natasha) # => Employee added.

# miller_contracting.display_all_employees



# class File
#   attr_accessor :name, :byte_content

#   def initialize(name)
#     @name = name
#   end

#   alias_method :read,  :byte_content
#   alias_method :write, :byte_content=

#   def copy(target_file_name)
#     target_file = self.class.new(target_file_name)
#     target_file.write(read)

#     target_file
#   end

#   def to_s
#     "#{name}.#{self.class::FORMAT}"
#   end
# end

# class MarkdownFile < File
#   FORMAT = :md
# end

# class VectorGraphicsFile < File
#   FORMAT = :svg
# end

# class MP3File < File
#   FORMAT = :mp3
# end

# # Test

# blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
# blog_post.write('Content will be added soon!'.bytes)

# copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

# puts copy_of_blog_post.is_a? MarkdownFile     # true
# puts copy_of_blog_post.read == blog_post.read # true

# puts blog_post



# class Length
#   attr_reader :value, :unit

#   def initialize(value, unit)
#     @value = value
#     @unit = unit
#   end

#   def as_kilometers
#     convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
#   end

#   def as_miles
#     convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
#   end

#   def as_nautical_miles
#     convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
#   end

#   def ==(other)
#     case unit
#     when :km  then value == other.as_kilometers.value
#     when :mi  then value == other.as_miles.value
#     when :nmi then value == other.as_nautical_miles.value
#     end
#   end

#   def <(other)
#     case unit
#     when :km  then value < other.as_kilometers.value
#     when :mi  then value < other.as_miles.value
#     when :nmi then value < other.as_nautical_miles.value
#     end
#   end

#   def <=(other)
#     self < other || self == other
#   end

#   def >(other)
#     !(self <= other)
#   end

#   def >=(other)
#     self > other || self == other
#   end

#   def to_s
#     "#{value} #{unit}"
#   end

#   def <=>(other_length)
#     self.as_kilometers.value <=> other_length.as_kilometers.value
#   end
#   private

#   def convert_to(target_unit, conversion_factors)
#     Length.new((value / conversion_factors[unit]).round(4), target_unit)
#   end
# end

# # Example

# puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# # => comparison of Length with Length failed (ArgumentError)
# # expected output:
# # 1 km
# # 1 mi
# # 1 nmi



# class BankAccount
#   attr_reader :balance

#   def initialize(account_number, client)
#     @account_number = account_number
#     @client = client
#     @balance = 0
#   end

#   def deposit(amount)
#     if amount > 0
#       self.balance += amount
#       "$#{amount} deposited. Total balance is $#{balance}."
#     else
#       "Invalid. Enter a positive amount."
#     end
#   end

#   def withdraw(amount)
#     if amount > 0 && amount <= balance
#       success = (self.balance -= amount)
#     else
#       success = false
#     end

#     if success
#       "$#{amount} withdrawn. Total balance is $#{balance}."
#     else
#       "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
#     end
#   end

#   def balance=(new_balance)
#     if valid_transaction?(new_balance)
#       @balance = new_balance
#       true
#     else
#       false
#     end
#   end

#   def valid_transaction?(new_balance)
#     new_balance >= 0
#   end
# end

# # Example

# account = BankAccount.new('5538898', 'Genevieve')

#                           # Expected output:
# p account.balance         # => 0
# p account.deposit(50)     # => $50 deposited. Total balance is $50.
# p account.balance         # => 50
# p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
# p account.balance         # => 50



class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil
    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    high_priority_tasks = tasks.select { |task| task.priority == :high }

    display(high_priority_tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

puts valentinas_tasks.display_all_tasks
puts valentinas_tasks.display_high_priority_tasks