defmodule Jira.SecurityScheme do
  @moduledoc """
  Provides struct and type for a SecurityScheme
  """

  @type t :: %__MODULE__{
          defaultSecurityLevelId: integer | nil,
          description: String.t() | nil,
          id: integer | nil,
          levels: [Jira.SecurityLevel.t()] | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:defaultSecurityLevelId, :description, :id, :levels, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultSecurityLevelId: :integer,
      description: {:string, :generic},
      id: :integer,
      levels: [{Jira.SecurityLevel, :t}],
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
