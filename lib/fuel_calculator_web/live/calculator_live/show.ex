defmodule FuelCalculatorWeb.CalculatorLive.Show do
  use FuelCalculatorWeb, :live_view

  alias FuelCalculator.Fuel

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:calculator, Fuel.get_calculator!(id))}
  end

  defp page_title(:show), do: "Show Calculator"
  defp page_title(:edit), do: "Edit Calculator"
end
