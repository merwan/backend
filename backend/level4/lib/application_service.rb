class ApplicationService
  def initialize(data_reader)
    @data_reader = data_reader
  end

  def calculate_rentals(filename)
    @data_reader.get_cars(filename)
    @data_reader.get_rentals(filename)
  end
end
