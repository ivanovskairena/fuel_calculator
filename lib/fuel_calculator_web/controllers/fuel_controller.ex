defmodule FuelCalculatorWeb.FuelController do
  use FuelCalculatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html",  conn: conn )
  end

end
