defmodule Jira.CustomFieldContextDefaultValueMultipleVersionPicker do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueMultipleVersionPicker
  """

  @type t :: %__MODULE__{
          type: String.t(),
          versionIds: [String.t()],
          versionOrder: String.t() | nil
        }

  defstruct [:type, :versionIds, :versionOrder]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: {:string, :generic}, versionIds: [string: :generic], versionOrder: {:string, :generic}]
  end
end
