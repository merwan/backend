require 'application_service'

RSpec.describe ApplicationService do
  it 'reads cars from input' do
    data_reader = double('data_reader')
    application = ApplicationService.new(data_reader)
    filename = 'data.json'

    expect(data_reader).to receive(:get_cars).with(filename)

    application.calculate_rentals(filename)
  end
end
