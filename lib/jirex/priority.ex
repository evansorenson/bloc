defmodule Jirex.Priority do
  @moduledoc """
  Provides struct and type for a Priority
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          iconUrl: String.t() | nil,
          id: String.t() | nil,
          isDefault: boolean | nil,
          name: String.t() | nil,
          schemes: map | nil,
          self: String.t() | nil,
          statusColor: String.t() | nil
        }

  defstruct [:description, :iconUrl, :id, :isDefault, :name, :schemes, :self, :statusColor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      iconUrl: {:string, :generic},
      id: {:string, :generic},
      isDefault: :boolean,
      name: {:string, :generic},
      schemes: :map,
      self: {:string, :generic},
      statusColor: {:string, :generic}
    ]
  end
end
