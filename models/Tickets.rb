require_relative("../db/sql_runner")

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(options)
    @customer_id = options["customer_id"]
    @film_id = options["film_id"]
    @id = options["id"].to_i if options['id']
  end

  def save()

    sql = "INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET (customer_id, file_id) = ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @film_id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    results = tickets.map { |tick_hash| Ticket.new(tick_hash)}
    return results
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
