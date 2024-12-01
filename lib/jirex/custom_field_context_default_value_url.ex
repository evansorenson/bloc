defmodule Jirex.CustomFieldContextDefaultValueURL do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueURL
  """

  @type t :: %__MODULE__{contextId: String.t(), type: String.t(), url: String.t()}

  defstruct [:contextId, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, type: {:string, :generic}, url: {:string, :generic}]
  end
end
