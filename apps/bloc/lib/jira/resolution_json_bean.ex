defmodule Jira.ResolutionJsonBean do
  @moduledoc """
  Provides struct and type for a ResolutionJsonBean
  """

  @type t :: %__MODULE__{
          default: boolean | nil,
          description: String.t() | nil,
          iconUrl: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:default, :description, :iconUrl, :id, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      default: :boolean,
      description: {:string, :generic},
      iconUrl: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
