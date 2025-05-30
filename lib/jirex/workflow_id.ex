defmodule Jirex.WorkflowId do
  @moduledoc """
  Provides struct and type for a WorkflowId
  """

  @type t :: %__MODULE__{draft: boolean, name: String.t()}

  defstruct [:draft, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [draft: :boolean, name: {:string, :generic}]
  end
end
