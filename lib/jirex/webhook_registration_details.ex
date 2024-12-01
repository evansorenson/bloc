defmodule Jirex.WebhookRegistrationDetails do
  @moduledoc """
  Provides struct and type for a WebhookRegistrationDetails
  """

  @type t :: %__MODULE__{url: String.t(), webhooks: [Jirex.WebhookDetails.t()]}

  defstruct [:url, :webhooks]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [url: {:string, :generic}, webhooks: [{Jirex.WebhookDetails, :t}]]
  end
end
