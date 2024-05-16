defmodule Jirex.IssueSecurityLevelMember do
  @moduledoc """
  Provides struct and type for a IssueSecurityLevelMember
  """

  @type t :: %__MODULE__{
          holder: Jirex.IssueSecurityLevelMemberHolder.t(),
          id: integer,
          issueSecurityLevelId: integer,
          managed: boolean | nil
        }

  defstruct [:holder, :id, :issueSecurityLevelId, :managed]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      holder: {Jirex.IssueSecurityLevelMemberHolder, :t},
      id: :integer,
      issueSecurityLevelId: :integer,
      managed: :boolean
    ]
  end
end
