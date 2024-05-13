defmodule Jira.LinkGroup do
  @moduledoc """
  Provides struct and type for a LinkGroup
  """

  @type t :: %__MODULE__{
          groups: [Jira.LinkGroup.t()] | nil,
          header: Jira.SimpleLink.t() | nil,
          id: String.t() | nil,
          links: [Jira.SimpleLink.t()] | nil,
          styleClass: String.t() | nil,
          weight: integer | nil
        }

  defstruct [:groups, :header, :id, :links, :styleClass, :weight]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groups: [{Jira.LinkGroup, :t}],
      header: {Jira.SimpleLink, :t},
      id: {:string, :generic},
      links: [{Jira.SimpleLink, :t}],
      styleClass: {:string, :generic},
      weight: :integer
    ]
  end
end
