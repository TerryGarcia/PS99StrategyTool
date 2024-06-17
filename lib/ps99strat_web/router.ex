defmodule Ps99stratWeb.Router do
  use Ps99stratWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Ps99stratWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ps99stratWeb do
    pipe_through :browser

    get "/", HomeController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ps99stratWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard preview in development
  if Application.compile_env(:ps99strat, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Ps99stratWeb.Telemetry
    end
  end
end
