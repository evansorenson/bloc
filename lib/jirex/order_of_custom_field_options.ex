defmodule Jirex.OrderOfCustomFieldOptions do
  @moduledoc """
  Provides struct and type for a OrderOfCustomFieldOptions
  """

  @type t :: %__MODULE__{
          after: String.t() | nil,
          customFieldOptionIds: [String.t()],
          position: String.t() | nil
        }

  defstruct [:after, :customFieldOptionIds, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      after: {:string, :generic},
      customFieldOptionIds: [string: :generic],
      position: {:enum, ["First", "Last"]}
    ]
  end
end
