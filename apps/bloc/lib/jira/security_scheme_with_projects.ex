defmodule Jira.SecuritySchemeWithProjects do
  @moduledoc """
  Provides struct and type for a SecuritySchemeWithProjects
  """

  @type t :: %__MODULE__{
          defaultLevel: integer | nil,
          description: String.t() | nil,
          id: integer,
          name: String.t(),
          projectIds: [integer] | nil,
          self: String.t()
        }

  defstruct [:defaultLevel, :description, :id, :name, :projectIds, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultLevel: :integer,
      description: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      projectIds: [:integer],
      self: {:string, :generic}
    ]
  end
end
