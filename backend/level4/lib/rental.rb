require 'date'

class Rental
  attr_reader :id, :distance,
    :start_date, :end_date,
    :price_per_km, :price_per_day,
    :deductible_reduction
  attr_accessor :price, :commission

  def initialize(args = {})
    @id = args.fetch('id')
    @distance = args.fetch('distance')
    @start_date = Date.parse(args.fetch('start_date'))
    @end_date = Date.parse(args.fetch('end_date'))
    @deductible_reduction = args.fetch('deductible_reduction')
    @price = 0
  end

  def set_car(car)
    @price_per_km = car.price_per_km
    @price_per_day = car.price_per_day
  end

  def process(processors)
    processors.each do |processor|
      processor.process(self)
    end
  end
end
