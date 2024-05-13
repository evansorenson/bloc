defmodule Jira.CustomFieldConfigurations do
  @moduledoc """
  Provides struct and type for a CustomFieldConfigurations
  """

  @type t :: %__MODULE__{configurations: [Jira.ContextualConfiguration.t()]}

  defstruct [:configurations]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [configurations: [{Jira.ContextualConfiguration, :t}]]
  end
end
