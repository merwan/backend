require 'json_serializer'

RSpec.describe JsonSerializer do
  subject { JsonSerializer.new }

  it 'reads json from file' do
    data = {
      "cars" => [
        { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
      ],
      "rentals" => [
        { "id" => 1, "car_id" => 1, "start_date" => "2015-12-8", "end_date" => "2015-12-8", "distance" => 100, "deductible_reduction" => true },
        { "id" => 2, "car_id" => 1, "start_date" => "2015-03-31", "end_date" => "2015-04-01", "distance" => 300, "deductible_reduction" => false },
        { "id" => 3, "car_id" => 1, "start_date" => "2015-07-3", "end_date" => "2015-07-14", "distance" => 1000, "deductible_reduction" => true }
      ]
    }

    data_from_file = subject.read('data.json')

    expect(data_from_file).to eq(data)
  end

  it 'writes hash to file' do
    original_data = subject.read('data.json')
    subject.write('data_output.json', original_data)
    processed_data = subject.read('data_output.json')
    File.delete('data_output.json')

    expect(processed_data).to eq(original_data)
  end
end
