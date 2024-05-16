defmodule Jirex.DashboardGadgetPosition do
  @moduledoc """
  Provides struct and type for a DashboardGadgetPosition
  """

  @type t :: %__MODULE__{
          "The column position of the gadget.": integer | nil,
          "The row position of the gadget.": integer | nil
        }

  defstruct [:"The column position of the gadget.", :"The row position of the gadget."]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    ["The column position of the gadget.": :integer, "The row position of the gadget.": :integer]
  end
end
