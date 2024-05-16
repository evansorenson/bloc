defmodule Jirex.IssueFieldOptionConfigurationScopeGlobal do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionConfigurationScopeGlobal
  """

  @type t :: %__MODULE__{attributes: [String.t()] | nil}

  defstruct [:attributes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [attributes: [enum: ["notSelectable", "defaultValue"]]]
  end
end
