defmodule Jirex.SecuritySchemeLevelBean do
  @moduledoc """
  Provides struct and type for a SecuritySchemeLevelBean
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          isDefault: boolean | nil,
          members: [Jirex.SecuritySchemeLevelMemberBean.t()] | nil,
          name: String.t()
        }

  defstruct [:description, :isDefault, :members, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      isDefault: :boolean,
      members: [{Jirex.SecuritySchemeLevelMemberBean, :t}],
      name: {:string, :generic}
    ]
  end
end
