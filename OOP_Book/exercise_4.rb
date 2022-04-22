class Student
  attr_reader :name
  attr_writer :grade

  def initialize(n, g)
    @name = n
    self.grade = g
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected
  def grade
    @grade
  end


end

joe = Student.new("joe", 90)
bob = Student.new("bob", 80)

puts "Well done!" if joe.better_grade_than?(bob)