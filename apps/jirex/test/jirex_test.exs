defmodule JirexTest do
  use ExUnit.Case
  doctest Jirex

  test "greets the world" do
    assert Jirex.hello() == :world
  end
end
