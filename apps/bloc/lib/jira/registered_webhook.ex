defmodule Jira.RegisteredWebhook do
  @moduledoc """
  Provides struct and type for a RegisteredWebhook
  """

  @type t :: %__MODULE__{createdWebhookId: integer | nil, errors: [String.t()] | nil}

  defstruct [:createdWebhookId, :errors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [createdWebhookId: :integer, errors: [string: :generic]]
  end
end
