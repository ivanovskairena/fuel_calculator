defmodule FuelCalculatorWeb.CalculatorLive.FormComponent do
  use FuelCalculatorWeb, :live_component

  alias FuelCalculator.Fuel

  @impl true
  def update(%{calculator: calculator} = assigns, socket) do
    changeset = Fuel.change_calculator(calculator)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"calculator" => calculator_params}, socket) do
    changeset =
      socket.assigns.calculator
      |> Fuel.change_calculator(calculator_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"calculator" => calculator_params}, socket) do
    save_calculator(socket, socket.assigns.action, calculator_params)
  end

  defp save_calculator(socket, :edit, calculator_params) do
    case Fuel.update_calculator(socket.assigns.calculator, calculator_params) do
      {:ok, _calculator} ->
        {:noreply,
         socket
         |> put_flash(:info, "Calculator updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_calculator(socket, :new, calculator_params) do
    case Fuel.create_calculator(calculator_params) do
      {:ok, _calculator} ->
        {:noreply,
         socket
         |> put_flash(:info, "Calculator created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
