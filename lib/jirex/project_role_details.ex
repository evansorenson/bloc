defmodule Jirex.ProjectRoleDetails do
  @moduledoc """
  Provides struct and type for a ProjectRoleDetails
  """

  @type t :: %__MODULE__{
          admin: boolean | nil,
          default: boolean | nil,
          description: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          roleConfigurable: boolean | nil,
          scope: Jirex.ProjectRoleDetailsScope.t() | nil,
          self: String.t() | nil,
          translatedName: String.t() | nil
        }

  defstruct [
    :admin,
    :default,
    :description,
    :id,
    :name,
    :roleConfigurable,
    :scope,
    :self,
    :translatedName
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      admin: :boolean,
      default: :boolean,
      description: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      roleConfigurable: :boolean,
      scope: {Jirex.ProjectRoleDetailsScope, :t},
      self: {:string, :uri},
      translatedName: {:string, :generic}
    ]
  end
end
