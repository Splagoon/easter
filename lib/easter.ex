defmodule Easter do
  @moduledoc """
  Functions for getting the date of Easter.
  """

  @doc """
  Gets the date of Easter on a given year.

  ## Examples

      iex> Easter.get_date(2023)
      {:ok, ~D[2023-04-09]}

      iex> Easter.get_date(10_000)
      {:error, :invalid_date}

  """
  @spec get_date(integer) :: {:ok, Date.t()} | {:error, atom}
  def get_date(year) do
    # Derived from https://www.algorithm-archive.org/contents/computus/computus.html

    # Year's position on the 19 year metonic cycle
    a = rem(year, 19)

    # Century index
    k = div(year, 100)

    # Shift of the metonic cycle, add a day offset every 300 years
    p = div(13 + 8 * k, 25)

    # Correction for non-observed leap days
    q = div(k, 4)

    # Correction to starting point of calculation each century
    m = rem(15 - p + k - q, 30)

    # Number of days from March 21st until the full moon
    d = rem(19 * a + m, 30)

    # Finding the next Sunday
    # Century-based offset in weekly calculation
    n = rem(4 + k - q, 7)

    # Correction for leap days
    b = rem(year, 4)
    c = rem(year, 7)

    # Days from d to next Sunday
    e =
      with e <- rem(2 * b + 4 * c + 6 * d + n, 7) do
        # Historical corrections for April 26 and 25
        if (d == 29 and e == 6) or (d == 28 and e == 6 and a > 10) do
          -1
        else
          e
        end
      end

    # Determination of the correct month for Easter
    if 22 + d + e > 31 do
      Date.new(year, 4, d + e - 9)
    else
      Date.new(year, 3, 22 + d + e)
    end
  end

  @doc """
  Gets the date of Easter on a given year.

  ## Examples

      iex> Easter.get_date!(2023)
      ~D[2023-04-09]

      iex> Easter.get_date!(10_000)
      ** (ArgumentError) cannot get Easter date, reason: invalid_date

  """
  @spec get_date!(integer) :: Date.t()
  def get_date!(year) do
    case get_date(year) do
      {:ok, date} ->
        date

      {:error, reason} ->
        raise(ArgumentError, message: "cannot get Easter date, reason: #{reason}")
    end
  end
end
