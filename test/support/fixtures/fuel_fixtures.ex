defmodule FuelCalculator.FuelFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FuelCalculator.Fuel` context.
  """

  @doc """
  Generate a calculator.
  """
  def calculator_fixture(attrs \\ %{}) do
    {:ok, calculator} =
      attrs
      |> Enum.into(%{
        flight_route: %{},
        ship_mass: 42
      })
      |> FuelCalculator.Fuel.create_calculator()

    calculator
  end
end
