defmodule Jira.PageBeanUser do
  @moduledoc """
  Provides struct and type for a PageBeanUser
  """

  @type t :: %__MODULE__{
          isLast: boolean | nil,
          maxResults: integer | nil,
          nextPage: String.t() | nil,
          self: String.t() | nil,
          startAt: integer | nil,
          total: integer | nil,
          values: [Jira.User.t()] | nil
        }

  defstruct [:isLast, :maxResults, :nextPage, :self, :startAt, :total, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isLast: :boolean,
      maxResults: :integer,
      nextPage: {:string, :uri},
      self: {:string, :uri},
      startAt: :integer,
      total: :integer,
      values: [{Jira.User, :t}]
    ]
  end
end
