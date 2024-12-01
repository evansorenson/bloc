defmodule Jirex.UiModificationDetails do
  @moduledoc """
  Provides struct and type for a UiModificationDetails
  """

  @type t :: %__MODULE__{
          contexts: [Jirex.UiModificationContextDetails.t()] | nil,
          data: String.t() | nil,
          description: String.t() | nil,
          id: String.t(),
          name: String.t(),
          self: String.t()
        }

  defstruct [:contexts, :data, :description, :id, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contexts: [{Jirex.UiModificationContextDetails, :t}],
      data: {:string, :generic},
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
