require_relative("../db/sql_runner")

class Ticket
  attr_accessor :customer_id, :screening_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def update()
    sql = "UPDATE tickets
           SET (customer_id, screening_id)
           = ($1, $2) WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    ticket = Ticket.new(result)
  end

  # def most_pop_time
  #   sql = "SELECT time, COUNT(time)
  #          AS MOST_FREQUENT FROM
  #          screenings GROUP BY
  #          screenings.title ORDER BY COUNT(time) DESC"
  # end

#   select column, COUNT(column) AS MOST_FREQUENT
# from TABLE_NAME
# GROUP BY column
# ORDER BY COUNT(column) DESC

  # def self.most_pop_time(film)
  #   sql = "SELECT screenings.*
  #          FROM screenings
  #          INNER JOIN tickets
  #          ON screenings.id = tickets.screening_id
  #          WHERE film_id = $1"
  #   values = [film]
  #   pop_time = SqlRunner.run(sql, values)
  #   result = pop_time.map{ |time| Screening.new(time) }
  #   return result
  # end
end
