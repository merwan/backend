require 'rental'

RSpec.describe Rental do
  it 'requests rental processing' do
    processor = double('processor')
    rental = Rental.new
    expect(processor).to receive(:process).with(rental)

    rental.process([processor])
  end
end
