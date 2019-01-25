require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require('pry')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({'name' => 'Eloise', 'funds' => '30'})
customer1.save()
customer2 = Customer.new({'name' => 'Carme', 'funds' => '25'})
customer2.save()
customer3 = Customer.new({'name' => 'Collin', 'funds' => '20'})
customer3.save()
customer4 = Customer.new({'name' => 'James', 'funds' => '15'})
customer4.save()
customer5 = Customer.new({'name' => 'Paddy', 'funds' => '12'})
customer5.save()
customer6 = Customer.new({'name' => 'Connor', 'funds' => '18'})
customer6.save()

film1 = Film.new({'title' => 'Meru', 'price' => '5'})
film1.save()
film2 = Film.new({'title' => 'Split', 'price' => '8'})
film2.save()
film3 = Film.new({'title' => 'Deadpool', 'price' => '4'})
film3.save()
film4 = Film.new({'title' => 'Alien', 'price' => '5'})
film4.save()
film5 = Film.new({'title' => '12 Monkeys', 'price' => '6'})
film5.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket5.save
ticket6 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film4.id})
ticket6.save()
ticket7 = Ticket.new({'customer_id' => customer6.id, 'film_id' => film3.id})
ticket7.save()

binding.pry
nil
