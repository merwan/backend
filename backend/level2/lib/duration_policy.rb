class DurationPolicy
  def calculate(duration, price_per_day)
    @price_per_day = price_per_day
    total = 0

    return 0 if duration == 0

    days_for_50_percent = duration - 10
    if days_for_50_percent > 0
      total += discount_50_percent(days_for_50_percent)
      duration -= days_for_50_percent
    end

    days_for_30_percent = duration - 4
    if days_for_30_percent > 0
      total += discount_30_percent(days_for_30_percent)
      duration -= days_for_30_percent
    end

    days_for_10_percent = duration - 1
    if days_for_10_percent > 0
      total += discount_10_percent(days_for_10_percent)
      duration -= days_for_10_percent
    end

    total += price_for_one_day
  end

  def price_for_one_day
    @price_per_day
  end

  def discount_10_percent duration
    @price_per_day * duration * 0.9
  end

  def discount_30_percent duration
    @price_per_day * duration * 0.7
  end

  def discount_50_percent duration
    @price_per_day * duration * 0.5
  end
end
