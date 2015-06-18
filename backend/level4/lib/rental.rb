class Rental
  attr_accessor :price_per_km, :distance,
    :price_per_day, :duration,
    :price, :commission

  def initialize
    @price = 0
  end

  def process(processors)
    processors.each do |processor|
      processor.process(self)
    end
  end
end
