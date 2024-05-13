defmodule Jira.PageOfDashboards do
  @moduledoc """
  Provides struct and type for a PageOfDashboards
  """

  @type t :: %__MODULE__{
          dashboards: [Jira.Dashboard.t()] | nil,
          maxResults: integer | nil,
          next: String.t() | nil,
          prev: String.t() | nil,
          startAt: integer | nil,
          total: integer | nil
        }

  defstruct [:dashboards, :maxResults, :next, :prev, :startAt, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dashboards: [{Jira.Dashboard, :t}],
      maxResults: :integer,
      next: {:string, :generic},
      prev: {:string, :generic},
      startAt: :integer,
      total: :integer
    ]
  end
end
