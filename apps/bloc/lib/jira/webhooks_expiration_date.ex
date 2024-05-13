defmodule Jira.WebhooksExpirationDate do
  @moduledoc """
  Provides struct and type for a WebhooksExpirationDate
  """

  @type t :: %__MODULE__{expirationDate: integer}

  defstruct [:expirationDate]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expirationDate: :integer]
  end
end
