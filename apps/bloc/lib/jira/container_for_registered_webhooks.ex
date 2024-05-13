defmodule Jira.ContainerForRegisteredWebhooks do
  @moduledoc """
  Provides struct and type for a ContainerForRegisteredWebhooks
  """

  @type t :: %__MODULE__{webhookRegistrationResult: [Jira.RegisteredWebhook.t()] | nil}

  defstruct [:webhookRegistrationResult]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [webhookRegistrationResult: [{Jira.RegisteredWebhook, :t}]]
  end
end
