defmodule Jira.ChangedWorklogs do
  @moduledoc """
  Provides struct and type for a ChangedWorklogs
  """

  @type t :: %__MODULE__{
          lastPage: boolean | nil,
          nextPage: String.t() | nil,
          self: String.t() | nil,
          since: integer | nil,
          until: integer | nil,
          values: [Jira.ChangedWorklog.t()] | nil
        }

  defstruct [:lastPage, :nextPage, :self, :since, :until, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      lastPage: :boolean,
      nextPage: {:string, :uri},
      self: {:string, :uri},
      since: :integer,
      until: :integer,
      values: [{Jira.ChangedWorklog, :t}]
    ]
  end
end
