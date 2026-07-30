defmodule KitchenCalculator do
  def get_volume({_unit, volume}), do: volume

  def to_milliliter({unit, volume}) do
    {:milliliter, volume * conversion(unit)}
  end

  def from_milliliter({:milliliter, volume}, new_unit) do
    {new_unit, volume / conversion(new_unit)}
  end

  def convert(volume_pair, new_unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(new_unit)
  end

  def conversion(:cup), do: 240
  def conversion(:fluid_ounce), do: 30
  def conversion(:teaspoon), do: 5
  def conversion(:tablespoon), do: 15
  def conversion(:milliliter), do: 1
end
