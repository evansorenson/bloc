defmodule Jirex.TimeTrackingConfiguration do
  @moduledoc """
  Provides struct and type for a TimeTrackingConfiguration
  """

  @type t :: %__MODULE__{
          defaultUnit: String.t(),
          timeFormat: String.t(),
          workingDaysPerWeek: number,
          workingHoursPerDay: number
        }

  defstruct [:defaultUnit, :timeFormat, :workingDaysPerWeek, :workingHoursPerDay]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultUnit: {:enum, ["minute", "hour", "day", "week"]},
      timeFormat: {:enum, ["pretty", "days", "hours"]},
      workingDaysPerWeek: :number,
      workingHoursPerDay: :number
    ]
  end
end
