# Easter

The Easter module adds functions to get the date of Easter for a given year.
[It's more complicated than you might think!](https://en.wikipedia.org/wiki/Date_of_Easter).
This module uses the algorithm described [here](https://www.algorithm-archive.org/contents/computus/computus.html).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `easter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:easter, "~> 1.0.0"}
  ]
end
```

## Usage

To get the date of Easter for a given year, use `Easter.get_date`:

```elixir
iex> Easter.get_date(2023)
{:ok, ~D[2023-04-09]}
```
If the year is outside of the `Calendar.ISO` valid range (-9999 to 9999), an error will be returned:
```elixir
iex> Easter.get_date(10_000)
{:error, :invalid_date}
```
There is also `Easter.get_date!` if you want it to raise an exception instead.