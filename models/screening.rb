require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :time

  def initialize(options)
    @id = options['id'].to_i if options['to_i']
    @time = options['time']
  end

  def save()
    sql = "INSERT INTO screenings (time) VALUES ($1) RETURNING id"
    values = [@time]
    screening = SqlRunner.run(sql, values)[0]
    @id = screening['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = screenings.map { |screening| Screening.new(screening) }
    return result
  end

  def update()
    sql = "UPDATE screenings
           SET time
           = $1 WHERE id = $2"
    values = [@time, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    screening = Screening.new(result)
  end
end
