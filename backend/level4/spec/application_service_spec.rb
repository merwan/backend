require 'application_service'

RSpec.describe ApplicationService do
  it 'reads cars from input' do
    data_reader = double('data_reader')
    application = ApplicationService.new(data_reader)
    filename = 'data.json'
    allow(data_reader).to receive(:get_rentals)

    expect(data_reader).to receive(:get_cars).with(filename)

    application.calculate_rentals(filename)
  end

  it 'reads rentals from input' do
    data_reader = double('data_reader')
    application = ApplicationService.new(data_reader)
    filename = 'data.json'
    allow(data_reader).to receive(:get_cars)

    expect(data_reader).to receive(:get_rentals).with(filename)

    application.calculate_rentals(filename)
  end
end
