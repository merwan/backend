class Car
  attr_reader :id, :price_per_km, :price_per_day

  def initialize(args)
    @id = args.fetch('id')
    @price_per_km = args.fetch('price_per_km')
    @price_per_day = args.fetch('price_per_day')
  end
end
