defmodule FuelCalculatorWeb.CalculatorLiveTest do
   use ExUnit.Case
   import  FuelCalculatorWeb.CalculatorLive


  test "new_launch function" do
    assert FuelCalculatorWeb.CalculatorLive.new_launch(Decimal.new("28801"), Decimal.from_float(9.807)) == 11829
    assert FuelCalculatorWeb.CalculatorLive.new_launch(Decimal.new("28801"), Decimal.from_float(1.62)) == 1926
  end

  test "new_landing function" do
    assert FuelCalculatorWeb.CalculatorLive.new_landing(Decimal.new("28801"), Decimal.from_float(3.711)) == 3485
    assert FuelCalculatorWeb.CalculatorLive.new_landing(Decimal.new("28801"), Decimal.from_float(9.807)) == 9278
  end

  test "add_launching function" do
    assert FuelCalculatorWeb.CalculatorLive.add_launching(28801, Decimal.from_float(9.807)) == 19771
    assert FuelCalculatorWeb.CalculatorLive.add_launching(28801, Decimal.from_float(1.62)) == 2024
  end

  test "add_landing function" do
    assert FuelCalculatorWeb.CalculatorLive.add_landing(28801, Decimal.from_float(3.711)) == 3869
    assert FuelCalculatorWeb.CalculatorLive.add_landing(28801, Decimal.from_float(9.807)) == 13447
  end


end
