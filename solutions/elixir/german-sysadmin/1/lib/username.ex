defmodule Username do
  @ascii_equivalency %{
    ?ä => ~c"ae",
    ?ö => ~c"oe",
    ?ü => ~c"ue",
    ?ß => ~c"ss"
  }

  def sanitize([]), do: []
  def sanitize([head | tail]) when head in [?ä, ?ö, ?ü, ?ß] do
    @ascii_equivalency
    |> Map.fetch!(head)
    |> Kernel.++(sanitize(tail))
  end
  def sanitize([head | tail]) when (head in ?a..?z) or head == ?_ do
    [head | sanitize(tail)]
  end
  def sanitize([_head | tail]), do: sanitize(tail)
end
