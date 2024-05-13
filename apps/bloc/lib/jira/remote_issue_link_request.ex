defmodule Jira.RemoteIssueLinkRequest do
  @moduledoc """
  Provides struct and type for a RemoteIssueLinkRequest
  """

  @type t :: %__MODULE__{
          application: Jira.RemoteIssueLinkRequestApplication.t() | nil,
          globalId: String.t() | nil,
          object: Jira.RemoteIssueLinkRequestObject.t(),
          relationship: String.t() | nil
        }

  defstruct [:application, :globalId, :object, :relationship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      application: {Jira.RemoteIssueLinkRequestApplication, :t},
      globalId: {:string, :generic},
      object: {Jira.RemoteIssueLinkRequestObject, :t},
      relationship: {:string, :generic}
    ]
  end
end
