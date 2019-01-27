require_relative("models/Customers")
require_relative("models/Films")
require_relative("models/Tickets")

require("pry")

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({"name" => "Stuart", "funds" => 250})
customer1.save()
customer2 = Customer.new({"name" => "Jenny", "funds" => 150})
customer2.save()
customer3 = Customer.new({"name" => "Smudge", "funds" => 100})
customer3.save()

film1 = Film.new({"title" => "LOTR", "price" => 10})
film1.save()
film2 = Film.new({"title" => "Point Break", "price" => 6})
film2.save()
film3 = Film.new({"title" => "The Matrix", "price" => 8})
film3.save()
#
ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket1.save()
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket2.save()
ticket3 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})
ticket3.save()
ticket4 = Ticket.new({"customer_id" => customer1.id, "film_id" => film3.id})
ticket4.save()


# customer1.name = "Handsome Dan"
# customer1.update()
# film1.title = "Lord of The Rings"
# film1.update()
# Ticket.all()
# customer1.bookings()
# customer1.save()
# customer1.take_cash(film1)
binding.pry
nil
