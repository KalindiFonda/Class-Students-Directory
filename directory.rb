# Declaring array of student hashes
=begin
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
=end

class Student
  def initialize(name, cohort)
    @name = name
    @cohort = cohort
  end

  def print_student
    puts "#{@name} joined in the Cohort: #{@cohort}"
  end

end

students = []
# Method to print list of students
def print_student_list(students)
  puts "Students:"
  puts "----------------"
  puts "Overall, we have #{students.count} students"
end

def print_last_name(students)
  last_names = []
  students.each do |student|
    last_name = student[:name].split(" ")[-1]
    last_names.push(last_name)
  end
  puts last_names
end

def add_student(students)
  puts "Enter name of student:"
  name = gets.chomp
  puts "Enter cohort of student:"
  cohort = gets.chomp.to_sym
  new_student = Student.new(name, cohort)
  new_student.print_student #this is to try it out if it's working
end

def delete_student(students)
  puts "Press num of student you want to delete"
  students.each_with_index do |student, idx|
    puts (idx + 1).to_s + ": " + student[:name]
  end
  student_idx = gets.chomp.to_i - 1
  student_to_del = students[student_idx]
  puts "Are you sure you want to delete: #{student_to_del[:name]}. Y/N"
  confirm = gets.chomp
  case confirm.upcase
  when "Y"
    students.delete(student_to_del)
    "You deleted student #{student_to_del[:name]} from the database"
  when "N"
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

# save students to file
def save_students(students)
  # open file for write
  file = File.open("students.csv", "w+")
  # iterate over students and save
  students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

# load students from file
def load_students(students)
  # open file for read
  file = File.open("students.csv", "a+")
  # iterate over lines and read student name and cohort
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def edit_student(students)
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
  students.each_with_index do |student, index|
    if student[:name] == input
      student_index = index
    end
  end
  case data_to_edit
  when "name"
    students[student_index][:name] = new_data
  when "cohort"
    students[student_index][:cohort] = new_data.to_sym
  end
end

load_students(students)
#Main program loop
while true
  print_menu
  input = gets.chomp.to_i
  case input
  when 9
    save_students(students)
    break
  when 1
    print_student_list(students)
  when 2
    add_student(students)
  when 3
    delete_student(students)
  when 4
    edit_student(students)
    save_students(students)
  when 8
    print_last_name(students)
  else
    puts "Try again"
  end
end
