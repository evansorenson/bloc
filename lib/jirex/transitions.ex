defmodule Jirex.Transitions do
  @moduledoc """
  Provides struct and type for a Transitions
  """

  @type t :: %__MODULE__{expand: String.t() | nil, transitions: [Jirex.IssueTransition.t()] | nil}

  defstruct [:expand, :transitions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expand: {:string, :generic}, transitions: [{Jirex.IssueTransition, :t}]]
  end
end
