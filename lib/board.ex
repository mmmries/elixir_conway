defmodule Board do
  def parse_frame(binary) do
    rows = Regex.scan(%r/^[.o]+$/m, binary)
    Enum.map rows, fn row_matches ->
      String.graphemes(Enum.at(row_matches,0))
    end
  end

  def serialize_board(board) do
    board |> Enum.map(serialize_row(&1)) |> Enum.join
  end

  defp serialize_row(row) do
    (row |> Enum.join) <> "\n"
  end
end
