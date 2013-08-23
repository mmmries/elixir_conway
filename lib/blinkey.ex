defmodule Mix.Tasks.Blinkey do
  use Mix.Task

  @shortdoc "run a conway game with a blinker"

  @moduledoc """
  hello world
  """
  def run(_) do
    blinker = """
    .....
    ..o..
    ..o..
    ..o..
    .....
    """
    Conway.run(blinker)
  end
end
