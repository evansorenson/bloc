defmodule Jirex.IssueUpdateDetailsFields do
  @moduledoc """
  Provides struct and type for a IssueUpdateDetailsFields
  """

  @type t :: %__MODULE__{}

  defstruct []

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    []
  end
end
