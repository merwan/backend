require 'commission_calculator'

RSpec.describe CommissionCalculator do
  subject { CommissionCalculator.new }

  it 'gives half of the commission to the insurance for 1000' do
    commission = subject.calculate(1, 1000)
    expect(commission.insurance).to eq(150)
  end

  it 'gives half of the commission to the insurance for 10000' do
    commission = subject.calculate(1, 10000)
    expect(commission.insurance).to eq(1500)
  end

  it 'gives 1€ for assistance for 1 day rental' do
    commission = subject.calculate(1, 1000)
    expect(commission.assistance).to eq(100)
  end

  it 'gives 2€ for assistance for 2 days rental' do
    commission = subject.calculate(2, 1000)
    expect(commission.assistance).to eq(200)
  end

  it 'gives the rest to drivy for 1000' do
    commission = subject.calculate(1, 1000)
    expect(commission.drivy).to eq(50)
  end

  it 'gives the rest to drivy for 10000' do
    commission = subject.calculate(1, 10000)
    expect(commission.drivy).to eq(1400)
  end

  it 'is 30% of rental price' do
    commission = subject.calculate(15, 10000)
    total = commission.insurance + commission.assistance + commission.drivy
    expect(total).to eq(3000)
  end

  it 'should handle the case when assistance is more than half the commission' do
    # We should refine the spec with someone from the business team
    # to know how we should handle this case
    # For now, I assume that drivy commission is 0 and insurance is the remainder
    commission = subject.calculate(1, 500)
    expect(commission.assistance).to eq(100)
    expect(commission.drivy).to eq(0)
    expect(commission.insurance).to eq(50)
    total = commission.insurance + commission.assistance + commission.drivy
    expect(total).to eq(150)
  end

  it 'should handle the case when assistance is greater than the commission' do
    # We should refine the spec with someone from the business team
    # to know how we should handle this case
    # For now, I raise an exception
    expect { subject.calculate(2, 500) }.to raise_error
  end
end
