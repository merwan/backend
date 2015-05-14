require_relative 'duration_policy'

class PriceCalculator
  def initialize(duration_policy = DurationPolicy.new)
    @duration_policy = duration_policy
  end

  def calculate(rental, car)
    distance_price = rental.distance * car.price_per_km
    duration_price = @duration_policy.calculate(rental.duration, car.price_per_day)

    return duration_price + distance_price
  end
end

