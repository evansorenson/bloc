defmodule Jira.DashboardGadget do
  @moduledoc """
  Provides struct and type for a DashboardGadget
  """

  @type t :: %__MODULE__{
          color: String.t(),
          id: integer,
          moduleKey: String.t() | nil,
          position: Jira.DashboardGadgetPosition.t(),
          title: String.t(),
          uri: String.t() | nil
        }

  defstruct [:color, :id, :moduleKey, :position, :title, :uri]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color: {:enum, ["blue", "red", "yellow", "green", "cyan", "purple", "gray", "white"]},
      id: :integer,
      moduleKey: {:string, :generic},
      position: {Jira.DashboardGadgetPosition, :t},
      title: {:string, :generic},
      uri: {:string, :generic}
    ]
  end
end
