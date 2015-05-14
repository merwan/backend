require 'duration_policy'

RSpec.describe DurationPolicy do
  subject { DurationPolicy.new }

  it 'cost 0 for 0 days rental' do
    price = subject.calculate(0, 100)
    expect(price).to eq(0)
  end

  it 'does not discount anything for 1 day rental' do
    price = subject.calculate(1, 100)
    expect(price).to eq(100)
  end

  it 'discounts 10% on second day for 2 days rental' do
    price = subject.calculate(2, 100)
    expect(price).to eq(190)
  end

  it 'discounts 10% on 2d and 3d days for 3 days rental' do
    price = subject.calculate(3, 100)
    expect(price).to eq(280)
  end

  it 'discounts 30% on 5th day' do
    price = subject.calculate(5, 100)
    expect(price).to eq(440)
  end

  it 'discounts 50% after 10th day' do
    price = subject.calculate(12, 2000)
    expect(price).to eq(17800)
  end
end
