defmodule Ps99strat.ExpectedValue do
  ############################
  # External API


  @eggs %{
    "exclusive egg 28" => [
      {"blazing shark",          50},
      {"blazing corgi",          35},
      {"blazing bat",            13},
      {"huge blazing shark",     1.25},
      {"huge blazing bat",       0.7},
      {"titanic blazing dragon", 0.05}
    ]
  }

  defp expected_value(pet_data) do
    pet_data
    |> Enum.map(fn {pet, prob} -> pet["rap"] * prob / 100 end)
    |> Enum.sum
  end

  def get_egg_data do
    data = Ps99strat.DataGrabber.data
    @eggs
    |> Enum.map(fn {egg_id, pets} ->
      pet_data = Enum.map(pets, fn {pet_id, prob} -> {data[pet_id], prob} end)
      %{
        "egg" => Map.put(data[egg_id], "exp_val", expected_value(pet_data)),
        "pets" => pet_data
      }
      end
    )
  end
end
