defmodule Jirex.StatusDetails do
  @moduledoc """
  Provides struct and type for a StatusDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          iconUrl: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          scope: map | nil,
          self: String.t() | nil,
          statusCategory: map | nil
        }

  defstruct [:description, :iconUrl, :id, :name, :scope, :self, :statusCategory]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      iconUrl: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      scope: :map,
      self: {:string, :generic},
      statusCategory: :map
    ]
  end
end
