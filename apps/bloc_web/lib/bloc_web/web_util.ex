defmodule BlocWeb.Util do
  alias Bloc.Scope

  def block_datetime_string(
        %Scope{timezone: timezone},
        %DateTime{} = datetime,
        start_or_end
      ) do
    datetime
    |> DateTime.shift_zone!(timezone)
    |> do_block_datetime_string(start_or_end)
  end

  def do_block_datetime_string(%DateTime{minute: 0} = datetime, :start) do
    Calendar.strftime(datetime, "%-I")
  end

  def do_block_datetime_string(%DateTime{minute: 0} = datetime, :end) do
    Calendar.strftime(datetime, "%-I %p")
  end

  def do_block_datetime_string(%DateTime{} = datetime, :start) do
    Calendar.strftime(datetime, "%-I:%M")
  end

  def do_block_datetime_string(%DateTime{} = datetime, :end) do
    Calendar.strftime(datetime, "%-I:%M %p")
  end

  @doc """
  Converts a number of minutes to a string representation of hours and minutes.

  ## Examples

      iex> minutes_to_string(30)
      "30m"

      iex> minutes_to_string(60)
      "1h"

      iex> minutes_to_string(90)
      "1h 30m"
  """
  @spec minutes_to_string(integer()) :: String.t()
  def minutes_to_string(minutes) when minutes < 60 do
    "#{minutes}m"
  end

  def minutes_to_string(minutes) do
    hours = div(minutes, 60)
    remainder = rem(minutes, 60)

    if remainder == 0 do
      "#{hours}h"
    else
      "#{hours}h #{remainder}m"
    end
  end
end
