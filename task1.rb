class Student
  attr_accessor :surname, :name, :date_of_birth
  @students = []
  def initialize(surname, name, date_of_birth)
    if date_of_birth < Time.now
      @date_of_birth = date_of_birth
      @surname = surname
      @name = name
    else
      raise ArgumentError, "Invalid date of birth"
    end
  end

  def self.students
    @students
  end

  def calculate_age
    age = Time.now.year - @date_of_birth.year
    age -= 1 if (Time.now.month < @date_of_birth.month) ||
      (Time.now.month == @date_of_birth.month && Time.now.day < @date_of_birth.day)
    age
  end

  def add_student!
    if self.class.students.any? { |student| student.name == name && student.surname == surname && student.date_of_birth == date_of_birth }
      raise ArgumentError, "Student already exists"
    else
      self.class.students << self
    end
  end

  def remove_student!
    if self.class.students.include?(self)
      self.class.students.delete(self)
    else
      raise ArgumentError, "Student does not exist"
    end
  end

  def self.get_student_by_age(age)
    @students.select {|x| x.calculate_age == age}
  end

  def self.get_students_by_name(name)
    @students.select {|x| x.name == name}
  end
end

begin
  student0 = Student.new("Ivanova", "Olena", Time.new(2024, 11, 4))
rescue  ArgumentError => e
  puts e.message
end
student1 = Student.new("Popova", "Olena", Time.new(2005, 11, 26))
student1.add_student!
student2 = Student.new("Popov", "Petro", Time.new(1998, 9, 25))
student2.add_student!
student3 = Student.new("Popov", "Petro", Time.new(1998, 9, 25))
begin
  student3.add_student!
rescue ArgumentError => e
  puts e.message
end
puts student1.calculate_age
puts student2.calculate_age
students_aged_26 = Student.get_student_by_age(26)
puts "Students aged 26: #{students_aged_26.map { |student| "#{student.name} #{student.surname}" }}"
students_named_olena = Student.get_students_by_name("Olena")
puts "Students with name 'Olena': #{students_named_olena.map { |student| "#{student.name} #{student.surname}" }}"
begin
  student3.remove_student!
rescue ArgumentError => e
  puts e.message
end
puts "All students: #{Student.students.map { |student| "#{student.name} #{student.surname}" }}"

