require_relative("../db/sql_runner")
require('pry')
class Customer

  attr_accessor :name, :funds, :id

  def initialize(options)
    @name = options["name"]
    @funds = options["funds"]
    @id = options["id"].to_i
    @tickets = options["tickets"]

  end

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |cust_hash| Customer.new(cust_hash)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def bookings()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1
    ORDER BY films.title"
    values = [@id]
    book_data = SqlRunner.run(sql, values)
    result = book_data.map { |booking| Film.new(booking)}
    return result
  end

  def take_cash(film)
    @funds -= film.price
    update()
  end

  def count_tickets #(customer)
  #   # @tickets = customer.customer_id.count  # tried a few things and could't get it!!
  #   # @tickets = Ticket.all.count  # this counted all the tickets!!!
  #   # @tickets = Ticket.all.count(customer) # always returned 0 here!
  end



end
