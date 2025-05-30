defmodule TimeUtils do
  @moduledoc false
  alias Bloc.Scope

  def today(%Scope{timezone: timezone}) do
    DateTime.utc_now()
    |> DateTime.shift_zone!(timezone)
    |> DateTime.to_date()
  end

  def shift(%Scope{timezone: timezone}, %DateTime{} = datetime) do
    DateTime.shift_zone!(datetime, timezone)
  end

  def block_datetime_string(%Scope{timezone: timezone}, %DateTime{} = datetime, start_or_end) do
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

  def format_hour(hour) do
    cond do
      hour == 0 -> "12 AM"
      hour < 12 -> "#{hour} AM"
      hour == 12 -> "12 PM"
      true -> "#{hour - 12} PM"
    end
  end

  def format_event_time(start_time, end_time) do
    "#{Calendar.strftime(start_time, "%-l:%M")} - #{Calendar.strftime(end_time, "%-l:%M")}"
  end

  def current_time_percentage do
    now = Time.utc_now()
    (now.hour * 60 + now.minute) / (24 * 60) * 100
  end
end
