defmodule Jira.CreateIssueSecuritySchemeDetails do
  @moduledoc """
  Provides struct and type for a CreateIssueSecuritySchemeDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          levels: [Jira.SecuritySchemeLevelBean.t()] | nil,
          name: String.t()
        }

  defstruct [:description, :levels, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      levels: [{Jira.SecuritySchemeLevelBean, :t}],
      name: {:string, :generic}
    ]
  end
end
