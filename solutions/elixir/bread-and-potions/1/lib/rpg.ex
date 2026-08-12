defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end
end

defprotocol RPG.Edible do
  def eat(item, character)
end

defimpl RPG.Edible, for: RPG.LoafOfBread do
  def eat(_item, character) do
    {nil, %{character | health: character.health + 5}}
  end
end

defimpl RPG.Edible, for: RPG.ManaPotion do
  def eat(item, character) do
    updated_character = %{
      character
      | mana: character.mana + item.strength
    }

    {%RPG.EmptyBottle{}, updated_character}
  end
end

defimpl RPG.Edible, for: RPG.Poison do
  def eat(_item, character) do
    updated_character = %{character | health: 0}

    {%RPG.EmptyBottle{}, updated_character}
  end
end