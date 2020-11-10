class Employee
  def initialize(name, type, serial_number, vacation_days, desk)
    @name = name
    @type = type
    @serial_number = serial_number
    @vacation_days = vacation_days
    @desk = desk
  end

  def to_s
    "Name: #{@name}\nType: #{@type}\nSerial number: #{@serial_number}\nVacation days: #{@vacation_days}\nDesk: #{@desk}"
  end
end

class RegularEmployee < Employee
  def initialize(name, serial_number)
    super(name, "Regular employee", serial_number, 10, "cubicle")
  end

  def take_vacation(days)
    days > @vacation_days ? "Incorrect: taking more vacation days than available" : @vacation_days -= days
  end
end

class PartTimeEmployee < Employee
  def initialize(name, serial_number)
    super(name, "Part-time employee", serial_number, 0, "none")
  end
end

class Manager < RegularEmployee
  def initialize(name, serial_number)
    @name = name
    @type = "Manager"
    @serial_number = serial_number
    @vacation_days = 14
    @desk = "private office"
  end

  def delegate
    "Delegating my work!"
  end
end

class Executive < Manager
  def initialize(name, serial_number)
    @name = name
    @type = "Executive"
    @serial_number = serial_number
    @vacation_days = 20
    @desk = "corner office"
  end
end


# regular_employee = RegularEmployee.new("Jose", "06705703F")
# p regular_employee.take_vacation(5)
# p regular_employee.take_vacation(15)

# manager = Manager.new("Jose", "06705703F")
# p manager.take_vacation(5)
# p manager.take_vacation(15)
# p manager.delegate

executive = Executive.new("Jose", "06705703F")
p Executive.new("Jose", "06705703F").take_vacation(5)
p Executive.new("Jose", "06705703F").take_vacation(25)
p executive.delegate

puts PartTimeEmployee.new("Jose", "06705703F")
p PartTimeEmployee.new("Jose", "06705703F").take_vacation(5)
p PartTimeEmployee.new("Jose", "06705703F").take_vacation(25)

=begin
to_s
Prints: name, type, serial number, vacation days, desk

Desks:
- Executive: corner office
- Managers: private office
- Regular: cubicle
- PTE: no desk/open workspace

FTE:
- #take_vacation

Managers and executives
- #delegate
=end