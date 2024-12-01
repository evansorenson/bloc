defmodule Jirex.CreatedIssue do
  @moduledoc """
  Provides struct and type for a CreatedIssue
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          key: String.t() | nil,
          self: String.t() | nil,
          transition: Jirex.CreatedIssueTransition.t() | nil,
          watchers: Jirex.CreatedIssueWatchers.t() | nil
        }

  defstruct [:id, :key, :self, :transition, :watchers]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      key: {:string, :generic},
      self: {:string, :generic},
      transition: {Jirex.CreatedIssueTransition, :t},
      watchers: {Jirex.CreatedIssueWatchers, :t}
    ]
  end
end
