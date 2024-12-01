defmodule Jirex.DashboardGadgetUpdateRequest do
  @moduledoc """
  Provides struct and type for a DashboardGadgetUpdateRequest
  """

  @type t :: %__MODULE__{
          color: String.t() | nil,
          position: Jirex.DashboardGadgetUpdateRequestPosition.t() | nil,
          title: String.t() | nil
        }

  defstruct [:color, :position, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      color: {:string, :generic},
      position: {Jirex.DashboardGadgetUpdateRequestPosition, :t},
      title: {:string, :generic}
    ]
  end
end
