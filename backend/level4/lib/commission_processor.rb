require 'commission'

class CommissionProcessor
  def process(rental)
    assistance = rental.duration * 100
    total = rental.price * 3 / 10

    if assistance > total
      raise InvalidRentalException.new('Assistance cost is greater than the commission')
    end

    insurance = total / 2
    drivy = total - insurance - assistance

    if drivy < 0
      drivy = 0
    end

    if insurance + assistance + drivy > total
      insurance = total - assistance
    end

    rental.commission = Commission.new(insurance, assistance, drivy)
  end
end

class InvalidRentalException < Exception
end
