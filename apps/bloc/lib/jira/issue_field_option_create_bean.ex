defmodule Jira.IssueFieldOptionCreateBean do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionCreateBean
  """

  @type t :: %__MODULE__{
          config: Jira.IssueFieldOptionConfiguration.t() | nil,
          properties: Jira.IssueFieldOptionCreateBeanProperties.t() | nil,
          value: String.t()
        }

  defstruct [:config, :properties, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      config: {Jira.IssueFieldOptionConfiguration, :t},
      properties: {Jira.IssueFieldOptionCreateBeanProperties, :t},
      value: {:string, :generic}
    ]
  end
end
