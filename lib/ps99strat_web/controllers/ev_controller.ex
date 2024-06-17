defmodule Ps99stratWeb.EvController do
  use Ps99stratWeb, :controller

  def ev(conn, _params) do
    render(conn, :index, egg_data: Ps99strat.ExpectedValue.get_egg_data())
  end
end
