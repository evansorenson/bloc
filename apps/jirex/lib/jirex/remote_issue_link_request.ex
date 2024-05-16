defmodule Jirex.RemoteIssueLinkRequest do
  @moduledoc """
  Provides struct and type for a RemoteIssueLinkRequest
  """

  @type t :: %__MODULE__{
          application: Jirex.RemoteIssueLinkRequestApplication.t() | nil,
          globalId: String.t() | nil,
          object: Jirex.RemoteIssueLinkRequestObject.t(),
          relationship: String.t() | nil
        }

  defstruct [:application, :globalId, :object, :relationship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      application: {Jirex.RemoteIssueLinkRequestApplication, :t},
      globalId: {:string, :generic},
      object: {Jirex.RemoteIssueLinkRequestObject, :t},
      relationship: {:string, :generic}
    ]
  end
end
