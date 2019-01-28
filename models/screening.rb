require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['to_i']
    @time = options['time']
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (time, film_id) VALUES ($1, $2) RETURNING id"
    values = [@time, @film_id]
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
           SET (time, film_id)
           = ($1, $2) WHERE id = $3"
    values = [@time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    screening = Screening.new(result)
  end

  def most_pop_time()
    sql = "SELECT screening_id,
           COUNT(screening_id) AS VALUE_OCCURRENCE
           FROM tickets GROUP BY screening_id
           WHERE film_id = $1
           ORDER BY VALUE_OCCURRENCE DESC"
    values = [@id]
    binding.pry
    pop_time = SqlRunner.run(sql, values)['screening_id'][0].to_i
    return result.map { |time| Screening.new(time) }
  end
  #how do i get pry to work?
end
