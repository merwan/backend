require "json"
require 'date'

class Car
  attr_reader :id
  attr_reader :price_per_km
  attr_reader :price_per_day

  def initialize hash
    @id = hash['id']
    @price_per_day = hash['price_per_day']
    @price_per_km = hash['price_per_km']
  end
end

class Rental
  attr_reader :id
  attr_reader :car_id
  attr_reader :distance

  def initialize hash
    @id = hash['id']
    @car_id = hash['car_id']
    @start_date = Date.parse hash['start_date']
    @end_date = Date.parse hash['end_date']
    @distance = hash['distance']
  end

  def duration
    @end_date.mjd - @start_date.mjd + 1
  end
end

filename = 'data.json'
file = File.read(filename)
data = JSON.load(file)

cars = []
data['cars'].each do |hash|
  cars << Car.new(hash)
end

rentals = []
data['rentals'].each do |hash|
  rentals << Rental.new(hash)
end

output_rentals = []
rentals.each do |rental|
  car_index = cars.index { |car| car.id == rental.car_id }
  rental_car = cars[car_index]
  price = rental.duration * rental_car.price_per_day + rental.distance * rental_car.price_per_km
  output_rentals << {id: rental.id, price: price}
end

output = {rentals: output_rentals}
content = JSON.pretty_generate(output)
filename = 'output2.json'
File.write(filename, content)
