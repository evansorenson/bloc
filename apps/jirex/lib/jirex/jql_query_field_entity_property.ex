defmodule Jirex.JqlQueryFieldEntityProperty do
  @moduledoc """
  Provides struct and type for a JqlQueryFieldEntityProperty
  """

  @type t :: %__MODULE__{
          entity: String.t(),
          key: String.t(),
          path: String.t(),
          type: String.t() | nil
        }

  defstruct [:entity, :key, :path, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      entity: {:string, :generic},
      key: {:string, :generic},
      path: {:string, :generic},
      type: {:enum, ["number", "string", "text", "date", "user"]}
    ]
  end
end
