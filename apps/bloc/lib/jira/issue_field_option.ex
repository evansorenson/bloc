defmodule Jira.IssueFieldOption do
  @moduledoc """
  Provides struct and type for a IssueFieldOption
  """

  @type t :: %__MODULE__{
          config: Jira.IssueFieldOptionConfiguration.t() | nil,
          id: integer,
          properties: Jira.IssueFieldOptionProperties.t() | nil,
          value: String.t()
        }

  defstruct [:config, :id, :properties, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      config: {Jira.IssueFieldOptionConfiguration, :t},
      id: :integer,
      properties: {Jira.IssueFieldOptionProperties, :t},
      value: {:string, :generic}
    ]
  end
end
