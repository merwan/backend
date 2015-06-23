require 'rental'
require 'car'

RSpec.describe Rental do

  def build_rental
    args = {
      'id' => 1,
      'distance' => 30,
      'start_date' => '2015-06-21',
      'end_date' => '2015-06-30',
      'deductible_reduction' => true,
    }
    return Rental.new(args)
  end

  it 'requests rental processing' do
    processor = double('processor')
    rental = build_rental
    expect(processor).to receive(:process).with(rental)

    rental.process([processor])
  end

  it 'initializes rental from hash' do
    rental = build_rental

    expect(rental.id).to eq(1)
    expect(rental.distance).to eq(30)
    expect(rental.start_date).to eq(Date.new(2015, 6, 21))
    expect(rental.end_date).to eq(Date.new(2015, 6, 30))
    expect(rental.deductible_reduction).to be true
  end

  it 'can set car' do
    rental = build_rental
    car = double('car', price_per_km: 10, price_per_day: 20)

    rental.set_car(car)

    expect(rental.price_per_km).to eq(car.price_per_km)
    expect(rental.price_per_day).to eq(car.price_per_day)
  end
end
