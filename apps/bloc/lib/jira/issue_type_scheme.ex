defmodule Jira.IssueTypeScheme do
  @moduledoc """
  Provides struct and type for a IssueTypeScheme
  """

  @type t :: %__MODULE__{
          defaultIssueTypeId: String.t() | nil,
          description: String.t() | nil,
          id: String.t(),
          isDefault: boolean | nil,
          name: String.t()
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
