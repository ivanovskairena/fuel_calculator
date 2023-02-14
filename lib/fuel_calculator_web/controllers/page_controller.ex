defmodule FuelCalculatorWeb.PageController do
  use FuelCalculatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
