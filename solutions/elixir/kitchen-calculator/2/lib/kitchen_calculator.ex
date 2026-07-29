defmodule KitchenCalculator do
  def get_volume({_unit, volume}), do: volume

  def to_milliliter({unit, volume}) do
    {:milliliter, volume * conversion(unit)}
  end

  def from_milliliter({:milliliter, volume}, unit) do
    {unit, volume / conversion(unit)}
  end

  def convert(volume_pair, target_unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(target_unit)
  end

  defp conversion(:cup), do: 240
  defp conversion(:fluid_ounce), do: 30
  defp conversion(:teaspoon), do: 5
  defp conversion(:tablespoon), do: 15
  defp conversion(:milliliter), do: 1
end
