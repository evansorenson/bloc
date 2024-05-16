defmodule Jirex.RemoteIssueLinkObject do
  @moduledoc """
  Provides struct and type for a RemoteIssueLinkObject
  """

  @type t :: %__MODULE__{
          icon: map | nil,
          status: map | nil,
          summary: String.t() | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:icon, :status, :summary, :title, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      icon: :map,
      status: :map,
      summary: {:string, :generic},
      title: {:string, :generic},
      url: {:string, :generic}
    ]
  end
end
