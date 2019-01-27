require_relative("../db/sql_runner")


class Film

  attr_accessor :title, :price, :id

  def initialize(options)
    @title = options["title"]
    @price = options["price"]
    @id = options["id"].to_i

  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@title, @price]
    films = SqlRunner.run(sql, values).first
    @id = films["id"].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    albums = SqlRunner.run(sql)
    result = albums.map { |film_hash| Film.new(film_hash)}
    return result
  end

    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

    def customer()
      sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
      values = [@id]
      customer_data = SqlRunner.run(sql, values)
      return customer_data.map { |customer| Customer.new(customer)}
    end

  end
