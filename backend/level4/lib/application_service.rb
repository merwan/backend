class ApplicationService
  def initialize(serializer, rental_adapter, processors)
    @serializer = serializer
    @rental_adapter = rental_adapter
    @processors = processors
  end

  def calculate_rentals(input, output)
    data = @serializer.read(input)
    rentals = @rental_adapter.from_hash(data)
    rentals.each do |rental|
      rental.process(@processors)
    end
    data = @rental_adapter.to_hash(rentals)
    @serializer.write(output, data)
  end
end
