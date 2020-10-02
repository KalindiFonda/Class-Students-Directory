
class Student
  
  def initialize(name, cohort)
    @name = name
    @cohort = cohort
  end

  attr_accessor :name
  attr_accessor :cohort

  def print_student
    puts "#{@name} joined in the Cohort: #{@cohort}"
  end


end


class StudentList

  def initialize
    @students = []
  end
  
  # Method to print list of students
  def print_student_list()
    puts "Students:"
    puts "----------------"
    @students.each do |student|
      puts "#{student.name}, Cohort: #{student.cohort.to_s}"
    end
    puts "Overall, we have #{@students.count} students"
  end

  # Method to print only last names
  def print_last_name()
    last_names = []
    @students.each do |student|
      last_name = student.name.split(" ")[-1]
      last_names.push(last_name)
    end
    puts last_names
  end

  # Method to add a student
  def add_student()
    puts "Enter name of student:"
    name = gets.chomp
    puts "Enter cohort of student:"
    cohort = gets.chomp.to_sym
    student = Student.new(name, cohort)
    @students.push(student)
  end
  
  # Method to delete a student
  def delete_student()
    puts "Press num of student you want to delete"
    @students.each_with_index do |student, idx|
      puts (idx + 1).to_s + ": " + student.name
    end
    student_idx = gets.chomp.to_i - 1
    student_to_del = @students[student_idx]
    puts "Are you sure you want to delete: #{student_to_del.name}. Y/N"
    confirm = gets.chomp
    case confirm.upcase
    when "Y"
      @students.delete(student_to_del)
      "You deleted student #{student_to_del.name} from the database"
    when "N"
    end
  end

  # Method to edit student details
  def edit_student()
    student_index = 0
    puts "Enter name of student to edit:"
    input = gets.chomp
    while true
      puts "Enter data to edit (name or cohort):"
      data_to_edit = gets.chomp
      if data_to_edit == "name" || data_to_edit == "cohort"
        break
      end
    end
    puts "Input new #{data_to_edit}:"
    new_data = gets.chomp
    @students.each_with_index do |student, index|
      if student.name == input
        student_index = index
      end
    end
    case data_to_edit
    when "name"
      @students[student_index].name = new_data
    when "cohort"
      @students[student_index].name = new_data.to_sym
    end
  end
  
  # save students to file
  def save_students()
    # open file for write
    file = File.open("students.csv", "w+")
    # iterate over students and save
    @students.each do |student|
      student_data = [student.name, student.cohort]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    file.close
  end

  # load students from file
  def load_students()
    # open file for read
    file = File.open("students.csv", "a+")
    # iterate over lines and read student name and cohort
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {Student.new(name, cohort.to_sym)}
    end
    file.close
  end

end

def print_menu
  puts "1. View student list"
  puts "2. Add new student"
  puts "3. Delete student"
  puts "4. Edit student details"
  puts "8. Get student last names"
  puts "9. Quit"
end

directory = StudentList.new
directory.load_students()
#Main program loop
while true
  print_menu
  input = gets.chomp.to_i
  case input
  when 9
    directory.save_students
    break
  when 1
    directory.print_student_list
  when 2
    directory.add_student
  when 3
    directory.delete_student
  when 4
    directory.edit_student
    directory.save_students
  when 8
    directory.print_last_name
  else
    puts "Try again"
  end
end
