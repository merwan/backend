require "json"
require 'date'
require_relative 'lib/duration_policy'

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

class PriceCalculator
  def initialize(duration_policy = DurationPolicy.new)
    @duration_policy = duration_policy
  end

  def calculate(rental, car)
    distance_price = rental.distance * car.price_per_km
    duration_price = @duration_policy.calculate(rental.duration, car.price_per_day)

    return duration_price + distance_price
  end
end

def read_cars(data)
  cars = []
  data['cars'].each do |hash|
    cars << Car.new(hash)
  end
  return cars
end

def read_rentals(data)
  rentals = []
  data['rentals'].each do |hash|
    rentals << Rental.new(hash)
  end
  return rentals
end

filename = 'data.json'
file = File.read(filename)
data = JSON.load(file)

cars = read_cars(data)
rentals = read_rentals(data)

output_rentals = []
rentals.each do |rental|
  car_index = cars.index { |car| car.id == rental.car_id }
  rental_car = cars[car_index]
  calculator = PriceCalculator.new
  price = calculator.calculate(rental, rental_car)
  output_rentals << {id: rental.id, price: price.to_i}
end

output = {rentals: output_rentals}
content = JSON.pretty_generate(output)
filename = 'output2.json'
File.write(filename, content)
