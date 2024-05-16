defmodule Jirex.FailedWebhook do
  @moduledoc """
  Provides struct and type for a FailedWebhook
  """

  @type t :: %__MODULE__{
          body: String.t() | nil,
          failureTime: integer,
          id: String.t(),
          url: String.t()
        }

  defstruct [:body, :failureTime, :id, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      body: {:string, :generic},
      failureTime: :integer,
      id: {:string, :generic},
      url: {:string, :generic}
    ]
  end
end
