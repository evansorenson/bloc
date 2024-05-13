defmodule Jira.CustomFieldCreatedContextOptionsList do
  @moduledoc """
  Provides struct and type for a CustomFieldCreatedContextOptionsList
  """

  @type t :: %__MODULE__{options: [Jira.CustomFieldContextOption.t()] | nil}

  defstruct [:options]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [options: [{Jira.CustomFieldContextOption, :t}]]
  end
end
