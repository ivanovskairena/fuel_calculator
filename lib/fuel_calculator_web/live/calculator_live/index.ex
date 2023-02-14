defmodule FuelCalculatorWeb.CalculatorLive.Index do
  use FuelCalculatorWeb, :live_view

  alias FuelCalculator.Fuel
  alias FuelCalculator.Fuel.Calculator

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :fuel, list_fuel())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Calculator")
    |> assign(:calculator, Fuel.get_calculator!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Calculator")
    |> assign(:calculator, %Calculator{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fuel")
    |> assign(:calculator, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    calculator = Fuel.get_calculator!(id)
    {:ok, _} = Fuel.delete_calculator(calculator)

    {:noreply, assign(socket, :fuel, list_fuel())}
  end

  defp list_fuel do
    Fuel.list_fuel()
  end
end
