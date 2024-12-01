defmodule Jirex.LinkedIssue do
  @moduledoc """
  Provides struct and type for a LinkedIssue
  """

  @type t :: %__MODULE__{
          fields: map | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:fields, :id, :key, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fields: :map, id: {:string, :generic}, key: {:string, :generic}, self: {:string, :uri}]
  end
end
