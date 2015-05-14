require 'duration_policy'

RSpec.describe DurationPolicy do
  it 'cost 0 for 0 days rental' do
    policy = DurationPolicy.new
    price = policy.calculate(0, 100)
    expect(price).to eq(0)
  end

  it 'does not discount anything for 1 day rental' do
    policy = DurationPolicy.new
    price = policy.calculate(1, 100)
    expect(price).to eq(100)
  end

  it 'discounts 10% on second day for 2 days rental' do
    policy = DurationPolicy.new
    price = policy.calculate(2, 100)
    expect(price).to eq(190)
  end

  it 'discounts 10% on 2d and 3d days for 3 days rental' do
    policy = DurationPolicy.new
    price = policy.calculate(3, 100)
    expect(price).to eq(280)
  end

  it 'discounts 30% on 5th day' do
    policy = DurationPolicy.new
    price = policy.calculate(5, 100)
    expect(price).to eq(440)
  end

  it 'discounts 50% after 10th day' do
    policy = DurationPolicy.new
    price = policy.calculate(12, 2000)
    expect(price).to eq(17800)
  end
end
