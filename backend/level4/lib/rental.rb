class Rental
  attr_accessor :price_per_day, :duration, :price, :commission

  def process(processors)
    processors.each do |processor|
      processor.process(self)
    end
  end
end
