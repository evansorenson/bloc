defmodule Jira.ScreenWithTab do
  @moduledoc """
  Provides struct and type for a ScreenWithTab
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          scope: Jira.ScreenWithTabScope.t() | nil,
          tab: Jira.ScreenWithTabTab.t() | nil
        }

  defstruct [:description, :id, :name, :scope, :tab]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      scope: {Jira.ScreenWithTabScope, :t},
      tab: {Jira.ScreenWithTabTab, :t}
    ]
  end
end
