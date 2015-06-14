class Rental
  def process(processors)
    processors.each do |processor|
      processor.process(self)
    end
  end
end
