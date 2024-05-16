defmodule Jirex.ServiceRegistryTier do
  @moduledoc """
  Provides struct and type for a ServiceRegistryTier
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          level: integer | nil,
          name: String.t() | nil,
          nameKey: String.t() | nil
        }

  defstruct [:description, :id, :level, :name, :nameKey]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :uuid},
      level: :integer,
      name: {:string, :generic},
      nameKey: {:string, :generic}
    ]
  end
end
