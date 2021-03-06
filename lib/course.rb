class Course
  attr_reader(:course_name, :course_id)


  define_method(:initialize) do |attributes|
    @course_name = attributes.fetch(:course_name)
    @course_id = attributes.fetch(:course_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO courses (course_name) VALUES ('#{@course_name}') RETURNING course_id")
    @course_id = result.first().fetch("course_id").to_i()
  end

  define_singleton_method(:all) do
      returned_courses = DB.exec("SELECT * FROM courses")
      courses = []
      returned_courses.each() do |course|
        course_name = course.fetch("course_name")
        course_id = course.fetch("course_id").to_i()
        courses.push(Course.new({:course_name => course_name, :course_id => course_id}))
      end
      courses
  end

  # define_method(:get_students)
  #   get_students = DB.exec("SELECT student_id FROM students")
  #   students = []
  #   get_students.each() do |student|
  #     student_id = student.fetch("student_id")
  #     students.push()

  define_singleton_method(:course_find) do |id|
    found_course = nil
    Course.all().each() do |course|
      if course.course_id().==(id)
        found_course = course
      end
    end
    found_course
  end

  define_method(:==) do |another_course|
    self.course_name().==(another_course.course_name()).&(self.course_id().==(another_course.course_id()))
  end
end
