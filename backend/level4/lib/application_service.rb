class ApplicationService
  def initialize(data_reader, processors)
    @data_reader = data_reader
    @processors = processors
  end

  def calculate_rentals(filename)
    rentals = @data_reader.get_rentals(filename)
    rentals.each do |rental|
      rental.process(@processors)
    end
  end
end
