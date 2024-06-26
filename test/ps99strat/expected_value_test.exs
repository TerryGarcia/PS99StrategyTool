defmodule Ps99strat.ExpectedValueTest do
  use ExUnit.Case, async: true

  test "expected value is calculated correctly 1" do
    pet_data = [
      {
        %{
        "rap" => 1
        },
        100
      },
      {
        %{
        "rap" => 1
        },
        100
      },
      {
        %{
        "rap" => 1
        },
        100
      }
    ]
    assert Ps99strat.ExpectedValue.expected_value(pet_data) == 3
  end

  test "expected value is calculated correctly 2" do
    pet_data = [
      {
        %{
        "rap" => 2890810238
        },
        0
      },
      {
        %{
        "rap" => 0
        },
        0
      },
      {
        %{
        "rap" => 123456
        },
        100
      }
    ]
    assert Ps99strat.ExpectedValue.expected_value(pet_data) == 123456
  end

end
