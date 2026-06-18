defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    monthly_rate = 22 * FreelancerRates.daily_rate(hourly_rate)
    discounted_rate = FreelancerRates.apply_discount(monthly_rate, discount)
    trunc(Float.ceil(discounted_rate))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    monthly_rate = FreelancerRates.monthly_rate(hourly_rate, discount) / 22
    days = budget / monthly_rate
    Float.floor(days, 1)
  end
end
