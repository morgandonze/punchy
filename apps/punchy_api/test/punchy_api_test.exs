defmodule PunchyApiTest do
  use ExUnit.Case
  doctest PunchyApi

  test "greets the world" do
    assert PunchyApi.hello() == :world
  end
end
