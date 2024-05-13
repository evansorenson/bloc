defmodule Jira.WebhookRegistrationDetails do
  @moduledoc """
  Provides struct and type for a WebhookRegistrationDetails
  """

  @type t :: %__MODULE__{url: String.t(), webhooks: [Jira.WebhookDetails.t()]}

  defstruct [:url, :webhooks]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [url: {:string, :generic}, webhooks: [{Jira.WebhookDetails, :t}]]
  end
end
