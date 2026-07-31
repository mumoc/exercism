defmodule DNA do
  def encode_nucleotide(?A), do: 1
  def encode_nucleotide(?C), do: 2
  def encode_nucleotide(?G), do: 4
  def encode_nucleotide(?T), do: 8
  def encode_nucleotide(?\s), do: 0

  def decode_nucleotide(1), do: ?A
  def decode_nucleotide(2), do: ?C
  def decode_nucleotide(4), do: ?G
  def decode_nucleotide(8), do: ?T
  def decode_nucleotide(0), do: ?\s

  def encode(dna) do
    encode(dna, <<>>)
  end

  def decode(dna) do
    dna
    |> decode([])
    |> reverse([])
  end

  defp encode([], accumulator), do: accumulator

  defp encode([head | tail], accumulator) do
    encoded = encode_nucleotide(head)
    new_accumulator = <<accumulator::bitstring, encoded::4>>
    encode(tail, new_accumulator)
  end

  defp decode(<<>>, accumulator), do: accumulator
  defp decode(<<encoded::4, rest::bitstring>>, accumulator) do
    nucleotide = decode_nucleotide(encoded)
    decode(rest, [nucleotide | accumulator])
  end

  defp reverse([], accumulator), do: accumulator
  defp reverse([head | tail], accumulator) do
    reverse(tail, [head | accumulator])
  end
end
