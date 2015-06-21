require 'duration_price_processor'
require 'rental'

RSpec.describe DurationPriceProcessor do
  subject { DurationPriceProcessor.new }

  def create_rental(duration, price_per_day)
    rental = Rental.new
    rental.duration = duration
    rental.price_per_day = price_per_day
    return rental
  end

  it 'costs 0 for 0 days rental' do
    rental = create_rental(0, 100)
    subject.process(rental)
    expect(rental.price).to eq(0)
  end

  it 'does not change existing price for 0 days rental' do
    rental = create_rental(0, 100)
    rental.price = 100
    subject.process(rental)
    expect(rental.price).to eq(100)
  end

  it 'does not discount anything for 1 day rental' do
    rental = create_rental(1, 100)
    subject.process(rental)
    expect(rental.price).to eq(100)
  end

  it 'adds price to existing price' do
    rental = create_rental(1, 100)
    rental.price = 100
    subject.process(rental)
    expect(rental.price).to eq(200)
  end

  it 'discounts 10% on second day for 2 days rental' do
    rental = create_rental(2, 100)
    subject.process(rental)
    expect(rental.price).to eq(190)
  end

  it 'discounts 10% on 2d and 3d days for 3 days rental' do
    rental = create_rental(3, 100)
    subject.process(rental)
    expect(rental.price).to eq(280)
  end

  it 'discounts 30% on 5th day' do
    rental = create_rental(5, 100)
    subject.process(rental)
    expect(rental.price).to eq(440)
  end

  it 'discounts 50% after 10th day' do
    rental = create_rental(12, 2000)
    subject.process(rental)
    expect(rental.price).to eq(17800)
  end
end
