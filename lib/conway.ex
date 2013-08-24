defmodule Conway do
  def run(board) do
    IO.write("\e[H\e[2J")
    IO.puts board
    :timer.sleep 200
    board |> next_frame |> run
  end

  def next_frame(board) do
    board |> parse_board |> execute_rules |> serialize_board
  end

  defp serialize_board(board) do
    rows = Enum.map(board, fn(row) ->
      row_str = Enum.join(row)
      "#{row_str}\n"
    end)
    rows |> Enum.join
  end

  defp parse_board(binary) do
    rows = Regex.scan(%r/^[.o]+$/m, binary)
    Enum.map rows, fn row_matches ->
      String.graphemes(Enum.at(row_matches,0))
    end
  end

  defp execute_rules(board) do
    Enum.map Enum.with_index(board), fn {row, y} ->
      Enum.map Enum.with_index(row), fn {cell, x} ->
        living_neighbors = count_neighbors(board, x, y)
        next_generation(cell, living_neighbors)
      end
    end
  end

  defp count_neighbors(board, x, y) do
    list = [cell_at(board,x-1,y-1), cell_at(board, x, y-1), cell_at(board, x+1, y-1),
            cell_at(board,x-1,y  ),                         cell_at(board, x+1, y  ),
            cell_at(board,x-1,y+1), cell_at(board, x, y+1), cell_at(board, x+1, y+1)]
    living = Enum.filter(list, fn cell -> cell == "o" end)
    length(living)
  end

  defp cell_at(_board, x, y) when (x < 0 or y < 0), do:  "."

  defp cell_at(board, x, y) do
    Enum.at(Enum.at(board, y, []),x, ".")
  end



  defp next_generation("o", live_neighbors) when live_neighbors in 2..3, do: "o"
  defp next_generation("o", _live_neighbors), do: "."
  defp next_generation(".", live_neighbors) when live_neighbors == 3, do: "o"
  defp next_generation(".", _live_neighbors), do: "."
end
