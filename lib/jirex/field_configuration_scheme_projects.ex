defmodule Jirex.FieldConfigurationSchemeProjects do
  @moduledoc """
  Provides struct and type for a FieldConfigurationSchemeProjects
  """

  @type t :: %__MODULE__{
          fieldConfigurationScheme: Jirex.FieldConfigurationScheme.t() | nil,
          projectIds: [String.t()]
        }

  defstruct [:fieldConfigurationScheme, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fieldConfigurationScheme: {Jirex.FieldConfigurationScheme, :t},
      projectIds: [string: :generic]
    ]
  end
end
