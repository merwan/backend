class DurationPriceProcessor
  def process(rental)
    @price_per_day = rental.price_per_day
    duration = rental.duration
    total = 0

    if duration == 0
      rental.price = 0
      return
    end

    days_above_10 = duration - 10
    if days_above_10 > 0
      total += discount_50_percent(days_above_10)
      duration -= days_above_10
    end

    days_above_4 = duration - 4
    if days_above_4 > 0
      total += discount_30_percent(days_above_4)
      duration -= days_above_4
    end

    days_above_1 = duration - 1
    if days_above_1 > 0
      total += discount_10_percent(days_above_1)
      duration -= days_above_1
    end

    total += price_for_one_day

    rental.price += total
  end

  def price_for_one_day
    @price_per_day
  end

  def discount_10_percent(duration)
    @price_per_day * duration * 9 / 10
  end

  def discount_30_percent(duration)
    @price_per_day * duration * 7 / 10
  end

  def discount_50_percent(duration)
    @price_per_day * duration * 5 / 10
  end
end
