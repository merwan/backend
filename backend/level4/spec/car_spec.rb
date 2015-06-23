require 'car'

RSpec.describe Car do
  it 'initializes car from hash' do
    args = {
      'id' => 1,
      'price_per_km' => 10,
      'price_per_day' => 20,
    }
    car = Car.new(args)

    expect(car.id).to eq(1)
    expect(car.price_per_km).to eq(10)
    expect(car.price_per_day).to eq(20)
  end
end
