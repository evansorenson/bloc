defmodule Jira.ColumnRequestBody do
  @moduledoc """
  Provides struct and type for a ColumnRequestBody
  """

  @type t :: %__MODULE__{columns: [String.t()] | nil}

  defstruct [:columns]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [columns: [string: :generic]]
  end
end
