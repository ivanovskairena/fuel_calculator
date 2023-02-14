defmodule FuelCalculator.Repo.Migrations.CreateFuel do
  use Ecto.Migration

  def change do
    create table(:fuel) do
      add :ship_mass, :integer
      add :flight_route, :map

      timestamps()
    end
  end
end
