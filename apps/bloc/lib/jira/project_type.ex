defmodule Jira.ProjectType do
  @moduledoc """
  Provides struct and type for a ProjectType
  """

  @type t :: %__MODULE__{
          color: String.t() | nil,
          descriptionI18nKey: String.t() | nil,
          formattedKey: String.t() | nil,
          icon: String.t() | nil,
          key: String.t() | nil
        }

  defstruct [:color, :descriptionI18nKey, :formattedKey, :icon, :key]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color: {:string, :generic},
      descriptionI18nKey: {:string, :generic},
      formattedKey: {:string, :generic},
      icon: {:string, :generic},
      key: {:string, :generic}
    ]
  end
end
