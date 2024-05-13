defmodule Jira.IssueTypeCreateBean do
  @moduledoc """
  Provides struct and type for a IssueTypeCreateBean
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          hierarchyLevel: integer | nil,
          name: String.t(),
          type: String.t() | nil
        }

  defstruct [:description, :hierarchyLevel, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      hierarchyLevel: :integer,
      name: {:string, :generic},
      type: {:enum, ["subtask", "standard"]}
    ]
  end
end
