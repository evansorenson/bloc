defmodule Jira.SecurityLevel do
  @moduledoc """
  Provides struct and type for a SecurityLevel
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          isDefault: boolean | nil,
          issueSecuritySchemeId: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:description, :id, :isDefault, :issueSecuritySchemeId, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      isDefault: :boolean,
      issueSecuritySchemeId: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
