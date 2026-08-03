defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime) do 28 else 29 end

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    days = Date.diff(actual_return_date, planned_return_date)
    max(days, 0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.== 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime =
      datetime_from_string(checkout)
  
    actual_return_datetime =
      datetime_from_string(return)
  
    planned_return_date =
      return_date(checkout_datetime)
  
    fee =
      planned_return_date
      |> days_late(actual_return_datetime)
      |> Kernel.*(rate)
  
    if monday?(actual_return_datetime) do
      div(fee, 2)
    else
      fee
    end
  end
end
