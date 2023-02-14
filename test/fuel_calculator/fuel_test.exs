defmodule FuelCalculator.FuelTest do
  use FuelCalculator.DataCase

  alias FuelCalculator.Fuel

  describe "fuel" do
    alias FuelCalculator.Fuel.Calculator

    import FuelCalculator.FuelFixtures

    @invalid_attrs %{flight_route: nil, ship_mass: nil}

    test "list_fuel/0 returns all fuel" do
      calculator = calculator_fixture()
      assert Fuel.list_fuel() == [calculator]
    end

    test "get_calculator!/1 returns the calculator with given id" do
      calculator = calculator_fixture()
      assert Fuel.get_calculator!(calculator.id) == calculator
    end

    test "create_calculator/1 with valid data creates a calculator" do
      valid_attrs = %{flight_route: %{}, ship_mass: 42}

      assert {:ok, %Calculator{} = calculator} = Fuel.create_calculator(valid_attrs)
      assert calculator.flight_route == %{}
      assert calculator.ship_mass == 42
    end

    test "create_calculator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fuel.create_calculator(@invalid_attrs)
    end

    test "update_calculator/2 with valid data updates the calculator" do
      calculator = calculator_fixture()
      update_attrs = %{flight_route: %{}, ship_mass: 43}

      assert {:ok, %Calculator{} = calculator} = Fuel.update_calculator(calculator, update_attrs)
      assert calculator.flight_route == %{}
      assert calculator.ship_mass == 43
    end

    test "update_calculator/2 with invalid data returns error changeset" do
      calculator = calculator_fixture()
      assert {:error, %Ecto.Changeset{}} = Fuel.update_calculator(calculator, @invalid_attrs)
      assert calculator == Fuel.get_calculator!(calculator.id)
    end

    test "delete_calculator/1 deletes the calculator" do
      calculator = calculator_fixture()
      assert {:ok, %Calculator{}} = Fuel.delete_calculator(calculator)
      assert_raise Ecto.NoResultsError, fn -> Fuel.get_calculator!(calculator.id) end
    end

    test "change_calculator/1 returns a calculator changeset" do
      calculator = calculator_fixture()
      assert %Ecto.Changeset{} = Fuel.change_calculator(calculator)
    end
  end
end
