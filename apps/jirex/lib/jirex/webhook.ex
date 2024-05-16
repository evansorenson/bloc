defmodule Jirex.Webhook do
  @moduledoc """
  Provides struct and type for a Webhook
  """

  @type t :: %__MODULE__{
          events: [String.t()],
          expirationDate: integer | nil,
          fieldIdsFilter: [String.t()] | nil,
          id: integer,
          issuePropertyKeysFilter: [String.t()] | nil,
          jqlFilter: String.t()
        }

  defstruct [:events, :expirationDate, :fieldIdsFilter, :id, :issuePropertyKeysFilter, :jqlFilter]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      events: [
        enum: [
          "jira:issue_created",
          "jira:issue_updated",
          "jira:issue_deleted",
          "comment_created",
          "comment_updated",
          "comment_deleted",
          "issue_property_set",
          "issue_property_deleted"
        ]
      ],
      expirationDate: :integer,
      fieldIdsFilter: [string: :generic],
      id: :integer,
      issuePropertyKeysFilter: [string: :generic],
      jqlFilter: {:string, :generic}
    ]
  end
end
