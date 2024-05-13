defmodule Jira.SecuritySchemeMembersRequest do
  @moduledoc """
  Provides struct and type for a SecuritySchemeMembersRequest
  """

  @type t :: %__MODULE__{members: [Jira.SecuritySchemeLevelMemberBean.t()] | nil}

  defstruct [:members]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [members: [{Jira.SecuritySchemeLevelMemberBean, :t}]]
  end
end
