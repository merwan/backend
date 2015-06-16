require 'application_service'

RSpec.describe ApplicationService do
  it 'reads rentals from input' do
    data_reader = double('data_reader')
    processors = [double('processor')]
    application = ApplicationService.new(data_reader, processors)
    filename = 'data.json'

    expect(data_reader).to receive(:get_rentals).with(filename).and_return([])

    application.calculate_rentals(filename)
  end

  it 'calls processors on rentals' do
    data_reader = double('data_reader')
    processors = [double('price_processor'), double('commission_processor')]
    application = ApplicationService.new(data_reader, processors)
    rentals = [double('rental')]
    allow(data_reader).to receive(:get_rentals).and_return(rentals)

    rentals.each do |rental|
      expect(rental).to receive(:process).with(processors)
    end

    application.calculate_rentals('data.json')
  end
end
