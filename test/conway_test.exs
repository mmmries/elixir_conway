defmodule ConwayTest do
  use ExUnit.Case, async: true
  import Conway

  test "still lifes" do
    block = """
    ....
    .oo.
    .oo.
    ....
    """
    assert next_frame(block) == block

    beehive = """
    ......
    ..oo..
    .o..o.
    ..oo..
    ......
    """
    assert next_frame(beehive) == beehive
  end

  test "transformations" do
    blinker_1 = """
    .....
    ..o..
    ..o..
    ..o..
    .....
    """

    blinker_2 = """
    .....
    .....
    .ooo.
    .....
    .....
    """

    assert next_frame(blinker_1) == blinker_2
    assert next_frame(blinker_2) == blinker_1
  end
end
