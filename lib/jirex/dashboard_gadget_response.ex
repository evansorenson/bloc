defmodule Jirex.DashboardGadgetResponse do
  @moduledoc """
  Provides struct and type for a DashboardGadgetResponse
  """

  @type t :: %__MODULE__{gadgets: [Jirex.DashboardGadget.t()]}

  defstruct [:gadgets]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [gadgets: [{Jirex.DashboardGadget, :t}]]
  end
end
