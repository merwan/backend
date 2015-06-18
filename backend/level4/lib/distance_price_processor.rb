class DistancePriceProcessor
  def process(rental)
    rental.price = rental.distance * rental.price_per_km
  end
end
