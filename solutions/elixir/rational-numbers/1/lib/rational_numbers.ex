defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @spec add(a :: rational, b :: rational) :: rational
  def add({a_num, a_den}, {b_num, b_den}) do
    {
      a_num * b_den + b_num * a_den,
      a_den * b_den
    }
    |> reduce()
  end

  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a_num, a_den}, {b_num, b_den}) do
    {
      a_num * b_den - b_num * a_den,
      a_den * b_den
    }
    |> reduce()
  end

  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a_num, a_den}, {b_num, b_den}) do
    {
      a_num * b_num,
      a_den * b_den
    }
    |> reduce()
  end

  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a_num, a_den}, {b_num, b_den}) do
    {
      a_num * b_den,
      a_den * b_num
    }
    |> reduce()
  end

  @spec abs(a :: rational) :: rational
  def abs({num, den}) do
    {
      Kernel.abs(num),
      Kernel.abs(den)
    }
    |> reduce()
  end

  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({num, den}, n) when n >= 0 do
    {
      Integer.pow(num, n),
      Integer.pow(den, n)
    }
    |> reduce()
  end

  def pow_rational({num, den}, n) when n < 0 do
    exponent = Kernel.abs(n)

    {
      Integer.pow(den, exponent),
      Integer.pow(num, exponent)
    }
    |> reduce()
  end

  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {num, den}) do
    :math.pow(x, num / den)
  end

  @spec reduce(a :: rational) :: rational
  def reduce({num, den}) do
    gcd = Integer.gcd(num, den)

    normalized_num = div(num, gcd)
    normalized_den = div(den, gcd)

    if normalized_den < 0 do
      {-normalized_num, -normalized_den}
    else
      {normalized_num, normalized_den}
    end
  end
end