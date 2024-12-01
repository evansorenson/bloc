defmodule Jirex.ChangedValueBean do
  @moduledoc """
  Provides struct and type for a ChangedValueBean
  """

  @type t :: %__MODULE__{
          changedFrom: String.t() | nil,
          changedTo: String.t() | nil,
          fieldName: String.t() | nil
        }

  defstruct [:changedFrom, :changedTo, :fieldName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      changedFrom: {:string, :generic},
      changedTo: {:string, :generic},
      fieldName: {:string, :generic}
    ]
  end
end
