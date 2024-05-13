defmodule Jira.IssueSecurityLevelMemberHolder do
  @moduledoc """
  Provides struct and type for a IssueSecurityLevelMemberHolder
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          parameter: String.t() | nil,
          type: String.t() | nil,
          value: String.t() | nil
        }

  defstruct [:expand, :parameter, :type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expand: {:string, :generic},
      parameter: {:string, :generic},
      type: {:string, :generic},
      value: {:string, :generic}
    ]
  end
end
