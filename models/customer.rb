require_relative("../db/sql_runner")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1 ,$2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def update()
    sql = "UPDATE customers
           SET (name, funds)
           = ($1, $2) WHERE
           id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    customer = Customer.new(result)
    return customer
  end

  def films()
    sql = "SELECT films.*
           FROM films
           INNER JOIN screenings
           ON films.id = screenings.film_id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE customer_id = $1 ORDER BY title"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map { |film| Film.new(film) }
  end

  def buys_ticket(film)
    @funds -= film.price
    update
  end

  def tickets_purchased()
    films().length
  end
end
