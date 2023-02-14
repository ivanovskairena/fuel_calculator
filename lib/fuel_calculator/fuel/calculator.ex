defmodule FuelCalculator.Fuel.Calculator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fuel" do
    field :flight_route, :map
    field :ship_mass, :integer

    timestamps()
  end

  @doc false
  def changeset(calculator, attrs) do
    calculator
    |> cast(attrs, [:ship_mass, :flight_route])
    |> validate_required([:ship_mass, :flight_route])
  end
end
