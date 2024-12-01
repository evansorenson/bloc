defmodule Jirex.FailedWebhooks do
  @moduledoc """
  Provides struct and type for a FailedWebhooks
  """

  @type t :: %__MODULE__{
          maxResults: integer,
          next: String.t() | nil,
          values: [Jirex.FailedWebhook.t()]
        }

  defstruct [:maxResults, :next, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [maxResults: :integer, next: {:string, :uri}, values: [{Jirex.FailedWebhook, :t}]]
  end
end
