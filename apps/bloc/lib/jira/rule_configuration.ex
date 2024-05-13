defmodule Jira.RuleConfiguration do
  @moduledoc """
  Provides struct and type for a RuleConfiguration
  """

  @type t :: %__MODULE__{disabled: boolean | nil, tag: String.t() | nil, value: String.t()}

  defstruct [:disabled, :tag, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [disabled: :boolean, tag: {:string, :generic}, value: {:string, :generic}]
  end
end
