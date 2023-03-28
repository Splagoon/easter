defmodule EasterTest do
  use ExUnit.Case
  doctest Easter

  # https://www.census.gov/data/software/x13as/genhol/easter-dates.html
  @valid_years [
    {1600, ~D[1600-04-02]},
    {1693, ~D[1693-03-22]},
    {1777, ~D[1777-03-30]},
    {1855, ~D[1855-04-08]},
    {1994, ~D[1994-04-03]},
    {2023, ~D[2023-04-09]},
    {2038, ~D[2038-04-25]},
    {2097, ~D[2097-03-31]}
  ]

  @invalid_years [-10_000, 10_000]

  test "get_date" do
    for {year, expected_date} <- @valid_years do
      assert(Easter.get_date(year) == {:ok, expected_date})
    end

    for year <- @invalid_years do
      assert(Easter.get_date(year) == {:error, :invalid_date})
    end
  end

  test "get_date!" do
    for {year, expected_date} <- @valid_years do
      assert(Easter.get_date!(year) == expected_date)
    end

    for year <- @invalid_years do
      assert_raise(ArgumentError, fn -> Easter.get_date!(year) end)
    end
  end
end
