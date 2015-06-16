class Rental
  attr_accessor :duration, :price, :commission

  def process(processors)
    processors.each do |processor|
      processor.process(self)
    end
  end
end
