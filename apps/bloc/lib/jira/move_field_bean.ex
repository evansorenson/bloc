defmodule Jira.MoveFieldBean do
  @moduledoc """
  Provides struct and type for a MoveFieldBean
  """

  @type t :: %__MODULE__{after: String.t() | nil, position: String.t() | nil}

  defstruct [:after, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [after: {:string, :uri}, position: {:enum, ["Earlier", "Later", "First", "Last"]}]
  end
end
