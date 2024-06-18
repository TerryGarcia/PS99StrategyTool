defmodule Ps99stratWeb.HomeController do
  use Ps99stratWeb, :controller

  def home(conn, _params) do
    render(conn, :index)
  end
end
