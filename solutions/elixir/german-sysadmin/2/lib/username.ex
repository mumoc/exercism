defmodule Username do
  @ascii_equivalency %{
    ?ä => ~c"ae",
    ?ö => ~c"oe",
    ?ü => ~c"ue",
    ?ß => ~c"ss"
  }

  def sanitize([]), do: []
  def sanitize([head | tail]) do
    character = 
    case head do
      character when character in [?ä, ?ö, ?ü, ?ß] -> 
        Map.fetch!(@ascii_equivalency, character)
      character when (character in ?a..?z) or character == ?_ -> 
        [character]
      _ -> 
        []
    end
    character ++ sanitize(tail)
  end
end
