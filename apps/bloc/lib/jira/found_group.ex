defmodule Jira.FoundGroup do
  @moduledoc """
  Provides struct and type for a FoundGroup
  """

  @type t :: %__MODULE__{
          groupId: String.t() | nil,
          html: String.t() | nil,
          labels: [Jira.GroupLabel.t()] | nil,
          name: String.t() | nil
        }

  defstruct [:groupId, :html, :labels, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groupId: {:string, :generic},
      html: {:string, :generic},
      labels: [{Jira.GroupLabel, :t}],
      name: {:string, :generic}
    ]
  end
end
