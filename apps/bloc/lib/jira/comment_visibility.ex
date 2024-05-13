defmodule Jira.CommentVisibility do
  @moduledoc """
  Provides struct and type for a CommentVisibility
  """

  @type t :: %__MODULE__{
          identifier: String.t() | nil,
          type: String.t() | nil,
          value: String.t() | nil
        }

  defstruct [:identifier, :type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      identifier: {:string, :generic},
      type: {:enum, ["group", "role"]},
      value: {:string, :generic}
    ]
  end
end
