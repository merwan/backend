require 'distance_price_processor'
require 'rental'

RSpec.describe DistancePriceProcessor do
  subject { DistancePriceProcessor.new }

  def create_rental(distance, price_per_km)
    rental = Rental.new
    rental.distance = distance
    rental.price_per_km = price_per_km
    return rental
  end

  it 'costs 0 for 0 km rental' do
    rental = create_rental(0, 100)
    subject.process(rental)
    expect(rental.price).to eq(0)
  end

  it 'costs 0 for 0€ price per km' do
    rental = create_rental(100, 0)
    subject.process(rental)
    expect(rental.price).to eq(0)
  end

  it 'costs 20000 for 500km and 400/km' do
    rental = create_rental(500, 40)
    subject.process(rental)
    expect(rental.price).to eq(20000)
  end
end
