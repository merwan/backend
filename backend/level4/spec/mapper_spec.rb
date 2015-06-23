require 'date'
require 'mapper'

RSpec.describe Mapper do
  subject { Mapper.new }

  it 'maps data to rentals' do
    data = {
      "cars" => [
        { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
      ],
      "rentals" => [
        { "id" => 1, "car_id" => 1, "start_date" => "2015-12-8", "end_date" => "2015-12-8", "distance" => 100, "deductible_reduction" => true },
      ]
    }
    rentals = subject.from_hash(data)

    rental = rentals[0]
    expect(rental.id).to eq(1)
    expect(rental.price_per_day).to eq(2000)
    expect(rental.price_per_km).to eq(10)
    expect(rental.start_date).to eq(Date.new(2015, 12, 8))
    expect(rental.end_date).to eq(Date.new(2015, 12, 8))
    expect(rental.distance).to eq(100)
    expect(rental.deductible_reduction).to be true
  end
end
