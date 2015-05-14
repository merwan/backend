class DurationPolicy
  def calculate(duration, price_per_day)
    @price_per_day = price_per_day
    total = 0

    return 0 if duration == 0

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
  end

  def price_for_one_day
    @price_per_day
  end

  def discount_10_percent(duration)
    @price_per_day * duration * 0.9
  end

  def discount_30_percent(duration)
    @price_per_day * duration * 0.7
  end

  def discount_50_percent(duration)
    @price_per_day * duration * 0.5
  end
end
