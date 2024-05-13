defmodule Jira.CustomFieldOption do
  @moduledoc """
  Provides struct and type for a CustomFieldOption
  """

  @type t :: %__MODULE__{self: String.t() | nil, value: String.t() | nil}

  defstruct [:self, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [self: {:string, :uri}, value: {:string, :generic}]
  end
end
