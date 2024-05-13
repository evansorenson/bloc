defmodule Jira.CustomFieldOptionUpdate do
  @moduledoc """
  Provides struct and type for a CustomFieldOptionUpdate
  """

  @type t :: %__MODULE__{disabled: boolean | nil, id: String.t(), value: String.t() | nil}

  defstruct [:disabled, :id, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [disabled: :boolean, id: {:string, :generic}, value: {:string, :generic}]
  end
end
