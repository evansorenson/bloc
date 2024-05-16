defmodule Jirex.ChangeDetails do
  @moduledoc """
  Provides struct and type for a ChangeDetails
  """

  @type t :: %__MODULE__{
          field: String.t() | nil,
          fieldId: String.t() | nil,
          fieldtype: String.t() | nil,
          from: String.t() | nil,
          fromString: String.t() | nil,
          to: String.t() | nil,
          toString: String.t() | nil
        }

  defstruct [:field, :fieldId, :fieldtype, :from, :fromString, :to, :toString]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {:string, :generic},
      fieldId: {:string, :generic},
      fieldtype: {:string, :generic},
      from: {:string, :generic},
      fromString: {:string, :generic},
      to: {:string, :generic},
      toString: {:string, :generic}
    ]
  end
end
