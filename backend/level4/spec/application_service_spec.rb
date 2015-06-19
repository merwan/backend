require 'application_service'
require 'rental'

RSpec.describe ApplicationService do
  it 'calls collaborators to calculate rentals' do
    serializer = double('serializer')
    hash = double('hash')
    rental_adapter = double('rental_adapter')
    rentals = []
    processors = []
    application = ApplicationService.new(serializer, rental_adapter, processors)

    input = 'input.json'
    output = 'output.json'
    expect(serializer).to receive(:read).with(input).and_return(hash)
    expect(rental_adapter).to receive(:from_hash).with(hash).and_return(rentals)
    expect(rental_adapter).to receive(:to_hash).with(rentals).and_return(hash)
    expect(serializer).to receive(:write).with(output, hash)

    application.calculate_rentals(input, output)
  end

  it 'calls processors on rentals' do
    serializer = double('serializer').as_null_object
    rental_adapter = double('rental_adapter').as_null_object
    processors = [double('price_processor'), double('commission_processor')]
    rentals = [Rental.new]
    allow(rental_adapter).to receive(:from_hash).and_return(rentals)
    application = ApplicationService.new(serializer, rental_adapter, processors)

    rentals.each do |rental|
      expect(rental).to receive(:process).with(processors)
    end

    application.calculate_rentals('input.json', 'output.json')
  end
end
