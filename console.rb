require_relative('models/customer')
require_relative('models/customer')
require_relative('models/customer')
require('pry')

customer1 = Customer.new({'name' => 'Eloise', 'funds' => '30'})
customer1.save()
customer2 = Customer.new({'name' => 'Carme', 'funds' => '25'})
customer2.save()
customer3 = Customer.new({'name' => 'Collin', 'funds' => '20'})
customer3.save()

binding.pry
nil
