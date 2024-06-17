defmodule Ps99strat.DataGrabber do
  use GenServer


  ############################
  # External API
  def start_link(inital_state) do
    GenServer.start_link(__MODULE__, inital_state, name: __MODULE__)
  end

  def data do
    GenServer.call(__MODULE__, :get_state)
  end


  ############################
  # GenServer Implementation
  def init(_) do
    :timer.send_interval(:timer.hours(1), :tick)
    {:ok, get_data()}
  end

  def handle_info(:tick, _) do
    {:noreply, get_data()}
  end

  def handle_call(:get_state, _, state) do
    { :reply, state, state }
  end

  defp get_data do
    Req.get!("https://ps99rap.com/api/get/items").body["data"]
    |> Enum.map(&(%{&1["id"] => &1}))
    |> Enum.reduce(&Map.merge/2)
  end
end
