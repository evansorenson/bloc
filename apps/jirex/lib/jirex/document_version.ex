defmodule Jirex.DocumentVersion do
  @moduledoc """
  Provides struct and type for a DocumentVersion
  """

  @type t :: %__MODULE__{id: String.t(), versionNumber: integer}

  defstruct [:id, :versionNumber]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, versionNumber: :integer]
  end
end
