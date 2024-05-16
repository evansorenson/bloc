defmodule Jirex.AssociatedItemBean do
  @moduledoc """
  Provides struct and type for a AssociatedItemBean
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t() | nil,
          parentId: String.t() | nil,
          parentName: String.t() | nil,
          typeName: String.t() | nil
        }

  defstruct [:id, :name, :parentId, :parentName, :typeName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      name: {:string, :generic},
      parentId: {:string, :generic},
      parentName: {:string, :generic},
      typeName: {:string, :generic}
    ]
  end
end
