defmodule Jira.ReorderIssuePriorities do
  @moduledoc """
  Provides struct and type for a ReorderIssuePriorities
  """

  @type t :: %__MODULE__{after: String.t() | nil, ids: [String.t()], position: String.t() | nil}

  defstruct [:after, :ids, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [after: {:string, :generic}, ids: [string: :generic], position: {:string, :generic}]
  end
end
