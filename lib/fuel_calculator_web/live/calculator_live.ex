defmodule FuelCalculatorWeb.CalculatorLive do
  use FuelCalculatorWeb, :live_view
  require Logger
  require Decimal

  def mount(_params, _session, socket) do
    missions =
      ["Apollo 11", "Mission on Mars", "Passenger ship"]

    data  = %{}
    types = %{mass: :string, mission: :string}

    changeset =
      {data, types}
      |> Ecto.Changeset.cast(data, Map.keys(types))

      assigns = [
        changeset: changeset,
        missions: missions,
        result: 0,
        lanching_fuel: 0,
        landing_fuel: 0,
        additional_fuel: 0
      ]

      {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    Phoenix.View.render(FuelCalculatorWeb.FuelCalculatorView, "index.html", assigns)
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end


  def handle_event("do_calculation", %{"calculation" => params}, socket) do

    routes =
     case params["mission"] do
      "Apollo 11" ->  [%{launch: 9.807, land: 1.62}, %{launch: 1.62, land: 9.807} ]
      "Mission on Mars" ->  [%{launch: 9.807, land: 3.711}, %{launch: 3.711, land: 9.807}]
      "Passenger ship" -> [%{launch: 9.807, land: 1.62}, %{launch: 1.62, land: 3.711}, %{launch: 3.711, land: 9.807}]
      _ -> []
      end



      result =
        for r <- routes do
          launch =
            new_launch(Decimal.new(params["mass"]), Decimal.from_float(r.launch) )

          land =
            new_landing(Decimal.new(params["mass"]), Decimal.from_float(r.land) )

          %{
            launching_fuel: launch,
            landing_fuel: land,
            additional_launch_fuel: add_launching(launch, Decimal.from_float(r.launch)),
            additional_landing_fuel: add_landing(land, Decimal.from_float(r.land)),
            total_land_fuel: land + add_landing(land, Decimal.from_float(r.land)),
            total_launch_fuel: launch + add_launching(launch, Decimal.from_float(r.launch)),
          }
        end

        lanching_fuel = Enum.map(result, fn x -> x.launching_fuel end) |> Enum.sum()

        landing_fuel = Enum.map(result, fn x -> x.landing_fuel end) |> Enum.sum()

        additional_fuel = Enum.map(result, fn x -> Enum.sum([x.additional_launch_fuel, x.additional_landing_fuel])   end) |> Enum.sum()

        total_fuel = Enum.map(result, fn x -> Enum.sum([x.total_launch_fuel, x.total_land_fuel])   end) |> Enum.sum()



      assigns = [
        result: total_fuel,
        lanching_fuel: lanching_fuel,
        landing_fuel: landing_fuel,
        additional_fuel: additional_fuel
      ]

    {:noreply, assign(socket, assigns)}
  end



  def new_landing(mass, gravity) do
    landing_vals = [mass, gravity, Decimal.from_float(0.033)]
    landing_sum = landing_vals |> Enum.reduce(fn x, acc -> Decimal.mult(x, acc) end) |> Decimal.sub(42)
    tt = Decimal.round(landing_sum, 2) |> Decimal.to_string()

    {val, _num} = Integer.parse(tt)

    Logger.warn("landing fuel  #{inspect val}  ")
    val
  end

  def add_landing(v, gravity)   do
      landing_vals = [v, gravity, Decimal.from_float(0.033)]
      landing_sum = landing_vals |> Enum.reduce(fn x, acc -> Decimal.mult(x, acc) end) |> Decimal.sub(42)

      tt = landing_sum |> Decimal.to_string()

      {val, _num} = Integer.parse(tt)

      if val > 40 or val == 40 do

        Logger.warn("requires #{inspect val} more fuel")
        val + add_landing(val, gravity)

      else
        0
      end

  end

  def new_launch(mass, gravity) do
    launching_vals = [mass, gravity, Decimal.from_float(0.042)]
    launching_sum = launching_vals |> Enum.reduce(fn x, acc -> Decimal.mult(x, acc) end) |> Decimal.sub(33)
    tt = Decimal.round(launching_sum, 2) |> Decimal.to_string()

    {val, _num} = Integer.parse(tt)
    Logger.warn("launching fuel #{inspect val}  ")

    val
  end

  def add_launching(v, gravity)  do
    launching_vals = [v, gravity, Decimal.from_float(0.042)]
    launching_sum = launching_vals |> Enum.reduce(fn x, acc -> Decimal.mult(x, acc) end) |> Decimal.sub(33)
    tt = launching_sum |> Decimal.to_string()

    {val, _num} = Integer.parse(tt)

    if val > 40 or val == 40  do

      Logger.warn("requires #{inspect val} more fuel")
      val + add_launching(val, gravity)

    else
      0
    end

  end

end
