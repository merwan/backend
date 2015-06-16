class ApplicationService
  def initialize(data_reader, data_writer, processors)
    @data_reader = data_reader
    @data_writer = data_writer
    @processors = processors
  end

  def calculate_rentals(filename)
    rentals = @data_reader.get_rentals(filename)
    rentals.each do |rental|
      rental.process(@processors)
    end
    @data_writer.write_rentals(rentals)
  end
end
