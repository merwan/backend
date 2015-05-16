class CommissionCalculator
  def calculate(duration, price)
    assistance = duration * 100
    total = price * 3 / 10

    if assistance > total
      raise InvalidRentalException.new('Assistance cost is greated than the commission')
    end

    insurance = total / 2
    drivy = total - insurance - assistance

    if drivy < 0
      drivy = 0
    end

    if insurance + assistance + drivy > total
      insurance = total - assistance
    end

    return Commission.new(insurance, assistance, drivy)
  end
end

class Commission
  attr_reader :insurance, :assistance, :drivy

  def initialize(insurance, assistance, drivy)
    @insurance = insurance
    @assistance = assistance
    @drivy = drivy
  end
end

class InvalidRentalException
end
