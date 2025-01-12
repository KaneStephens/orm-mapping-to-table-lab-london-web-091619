class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_reader :id
  attr_accessor  :name, :grade

  @@all = []

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
    @@all << self
  end

  def self.create_table
    sql = "CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT, 
      grade INTEGER
      );"
      DB[:conn].execute(sql)      
  end  

  def self.drop_table
    sql = "DROP TABLE students;"
      DB[:conn].execute(sql) 
  end

  def save 
    sql = <<-SQL
    INSERT INTO students(name, grade)
    VALUES(?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade) 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student

  end



  
end
