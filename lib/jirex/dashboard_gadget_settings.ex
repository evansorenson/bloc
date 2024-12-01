defmodule Jirex.DashboardGadgetSettings do
  @moduledoc """
  Provides struct and type for a DashboardGadgetSettings
  """

  @type t :: %__MODULE__{
          color: String.t() | nil,
          ignoreUriAndModuleKeyValidation: boolean | nil,
          moduleKey: String.t() | nil,
          position: Jirex.DashboardGadgetSettingsPosition.t() | nil,
          title: String.t() | nil,
          uri: String.t() | nil
        }

  defstruct [:color, :ignoreUriAndModuleKeyValidation, :moduleKey, :position, :title, :uri]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color: {:string, :generic},
      ignoreUriAndModuleKeyValidation: :boolean,
      moduleKey: {:string, :generic},
      position: {Jirex.DashboardGadgetSettingsPosition, :t},
      title: {:string, :generic},
      uri: {:string, :generic}
    ]
  end
end
