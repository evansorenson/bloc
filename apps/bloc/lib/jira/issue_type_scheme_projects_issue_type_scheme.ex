defmodule Jira.IssueTypeSchemeProjectsIssueTypeScheme do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeProjectsIssueTypeScheme
  """

  @type t :: %__MODULE__{
          defaultIssueTypeId: String.t() | nil,
          description: String.t() | nil,
          id: String.t() | nil,
          isDefault: boolean | nil,
          name: String.t() | nil
        }

  defstruct [:defaultIssueTypeId, :description, :id, :isDefault, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultIssueTypeId: {:string, :generic},
      description: {:string, :generic},
      id: {:string, :generic},
      isDefault: :boolean,
      name: {:string, :generic}
    ]
  end
end
