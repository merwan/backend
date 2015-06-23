require 'rental'
require 'car'

class Mapper
  def from_hash(data)
    cars = []
    data['cars'].each do |car_data|
      cars << Car.new(car_data)
    end

    rentals = []
    data['rentals'].each do |rental_data|
      rental = Rental.new(rental_data)
      rental.set_car(cars[0])
      rentals << rental
    end

    return rentals
  end
end
