defmodule Jirex.CustomFieldValueUpdateDetails do
  @moduledoc """
  Provides struct and type for a CustomFieldValueUpdateDetails
  """

  @type t :: %__MODULE__{updates: [Jirex.CustomFieldValueUpdate.t()] | nil}

  defstruct [:updates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [updates: [{Jirex.CustomFieldValueUpdate, :t}]]
  end
end
