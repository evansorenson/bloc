defmodule Jirex.CustomFieldContextDefaultValueForgeDateTimeField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeDateTimeField
  """

  @type t :: %__MODULE__{
          contextId: String.t(),
          dateTime: String.t() | nil,
          type: String.t(),
          useCurrent: boolean | nil
        }

  defstruct [:contextId, :dateTime, :type, :useCurrent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contextId: {:string, :generic},
      dateTime: {:string, :generic},
      type: {:string, :generic},
      useCurrent: :boolean
    ]
  end
end
