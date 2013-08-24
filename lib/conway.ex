defmodule Conway do
  def run(frame) do
    IO.write("\e[H\e[2J")
    IO.puts frame
    :timer.sleep 200
    frame |> next_frame |> run
  end

  def next_frame(frame) do
    frame |> Board.parse_frame |> next_board |> Board.serialize_board
  end

  defp next_board(board) do
    board |> Enum.with_index |> Enum.map fn {row,y} ->
      row |> Enum.with_index |> Enum.map fn {cell,x} ->
        neighbors({x,y},board) |> count_living |> next_generation(cell)
      end
    end
  end

  defp neighbors(xy,board) do
    neighbor_coords(xy) |> Enum.map cell_at(&1,board)
  end

  defp neighbor_coords({x,y}) do
    [
      {x-1,y-1},{x  ,y-1},{x+1,y-1},
      {x-1,y  },          {x+1,y  },
      {x-1,y+1},{x  ,y+1},{x+1,y+1}
    ]
  end

  defp count_living(list) do
    list |> Enum.filter(fn cell -> cell == "o" end) |> length
  end

  defp cell_at({x,y}, _board) when (x<0 or y<0), do: "."

  defp cell_at({x,y}, board) do
    Enum.at(Enum.at(board, y, []),x, ".")
  end


  defp next_generation(live_neighbors,"o") when live_neighbors in 2..3, do: "o"
  defp next_generation(_live_neighbors,"o"), do: "."
  defp next_generation(live_neighbors,".") when live_neighbors == 3, do: "o"
  defp next_generation(_live_neighbors,"."), do: "."
end
