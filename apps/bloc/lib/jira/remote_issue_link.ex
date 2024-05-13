defmodule Jira.RemoteIssueLink do
  @moduledoc """
  Provides struct and type for a RemoteIssueLink
  """

  @type t :: %__MODULE__{
          application: Jira.RemoteIssueLinkApplication.t() | nil,
          globalId: String.t() | nil,
          id: integer | nil,
          object: Jira.RemoteIssueLinkObject.t() | nil,
          relationship: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:application, :globalId, :id, :object, :relationship, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      application: {Jira.RemoteIssueLinkApplication, :t},
      globalId: {:string, :generic},
      id: :integer,
      object: {Jira.RemoteIssueLinkObject, :t},
      relationship: {:string, :generic},
      self: {:string, :uri}
    ]
  end
end
