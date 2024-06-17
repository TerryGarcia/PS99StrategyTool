defmodule Ps99stratWeb.HomeController do
  use Ps99stratWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :index)
  end
end
