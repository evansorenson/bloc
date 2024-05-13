defmodule Jira.IssueFieldOptionConfigurationScope do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionConfigurationScope
  """

  @type t :: %__MODULE__{
          global: Jira.IssueFieldOptionConfigurationScopeGlobal.t() | nil,
          projects: [integer] | nil,
          projects2: [Jira.ProjectScopeBean.t()] | nil
        }

  defstruct [:global, :projects, :projects2]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      global: {Jira.IssueFieldOptionConfigurationScopeGlobal, :t},
      projects: [:integer],
      projects2: [{Jira.ProjectScopeBean, :t}]
    ]
  end
end
