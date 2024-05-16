defmodule Jirex.IssueUpdateMetadata do
  @moduledoc """
  Provides struct and type for a IssueUpdateMetadata
  """

  @type t :: %__MODULE__{fields: map | nil}

  defstruct [:fields]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fields: :map]
  end
end
