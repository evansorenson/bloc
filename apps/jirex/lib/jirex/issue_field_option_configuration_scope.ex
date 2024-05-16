defmodule Jirex.IssueFieldOptionConfigurationScope do
  @moduledoc """
  Provides struct and type for a IssueFieldOptionConfigurationScope
  """

  @type t :: %__MODULE__{
          global: Jirex.IssueFieldOptionConfigurationScopeGlobal.t() | nil,
          projects: [integer] | nil,
          projects2: [Jirex.ProjectScopeBean.t()] | nil
        }

  defstruct [:global, :projects, :projects2]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      global: {Jirex.IssueFieldOptionConfigurationScopeGlobal, :t},
      projects: [:integer],
      projects2: [{Jirex.ProjectScopeBean, :t}]
    ]
  end
end
