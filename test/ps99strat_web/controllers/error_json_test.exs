defmodule Ps99stratWeb.ErrorJSONTest do
  use Ps99stratWeb.ConnCase, async: true

  test "renders 404" do
    assert Ps99stratWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Ps99stratWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
