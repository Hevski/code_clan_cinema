require_relative("../db/sql_runner")
require('pry')

class Film
  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map{ |film| Film.new(film)}
    return result
  end

  def update()
    sql = "UPDATE films
           SET (title, price)
           = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    film = Film.new(result)
  end

  def customer
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON tickets.customer_id = customers.id
           WHERE film_id = $1 ORDER BY name"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map { |customer| Customer.new(customer) }
  end

  def customer_count
    customer().length
  end

  def screening
    sql = "SELECT screenings.*
           FROM screenings
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE film_id = $1"
    customer_count
    values = [@id]
    screening_data = SqlRunner.run(sql, values)
    return screening_data.map { |screen| Screening.new(screen) }
  end
end
