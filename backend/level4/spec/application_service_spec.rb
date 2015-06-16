require 'application_service'
require 'rental'

RSpec.describe ApplicationService do
  it 'reads rentals from input' do
    data_reader = double('data_reader')
    data_writer = double('data_writer').as_null_object
    processors = []
    application = ApplicationService.new(data_reader, data_writer, processors)
    filename = 'data.json'

    expect(data_reader).to receive(:get_rentals).with(filename).and_return([])

    application.calculate_rentals(filename)
  end

  it 'calls processors on rentals' do
    data_reader = double('data_reader')
    data_writer = double('data_writer').as_null_object
    processors = [double('price_processor'), double('commission_processor')]
    application = ApplicationService.new(data_reader, data_writer, processors)
    rentals = [Rental.new]
    allow(data_reader).to receive(:get_rentals).and_return(rentals)

    rentals.each do |rental|
      expect(rental).to receive(:process).with(processors)
    end

    application.calculate_rentals('data.json')
  end

  it 'writes rentals to output' do
    data_reader = double('data_reader')
    data_writer = double('data_writer')
    processors = []
    application = ApplicationService.new(data_reader, data_writer, processors)
    rentals = [Rental.new]
    allow(data_reader).to receive(:get_rentals).and_return(rentals)

    expect(data_writer).to receive(:write_rentals).with(rentals)

    application.calculate_rentals('data.json')
  end
end
