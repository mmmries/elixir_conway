defmodule Mix.Tasks.Laser do
  use Mix.Task

  @shortdoc "run a conway game with a laser"

  @moduledoc """
  hello world
  """
  def run(_) do
    board = """
    .........................................
    .oooooooo.ooooo...ooo......ooooooo.ooooo.
    .........................................
    """
    Conway.run(board)
  end
end
