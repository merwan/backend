class ApplicationService
  def initialize(serializer, mapper, processors)
    @serializer = serializer
    @mapper = mapper
    @processors = processors
  end

  def calculate_rentals(input, output)
    data = @serializer.read(input)
    rentals = @mapper.from_hash(data)
    rentals.each do |rental|
      rental.process(@processors)
    end
    data = @mapper.to_hash(rentals)
    @serializer.write(output, data)
  end
end
