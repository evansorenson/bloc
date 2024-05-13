defmodule Jira.ComponentJsonBean do
  @moduledoc """
  Provides struct and type for a ComponentJsonBean
  """

  @type t :: %__MODULE__{
          ari: String.t() | nil,
          description: String.t() | nil,
          id: String.t() | nil,
          metadata: Jira.ComponentJsonBeanMetadata.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:ari, :description, :id, :metadata, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ari: {:string, :generic},
      description: {:string, :generic},
      id: {:string, :generic},
      metadata: {Jira.ComponentJsonBeanMetadata, :t},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
