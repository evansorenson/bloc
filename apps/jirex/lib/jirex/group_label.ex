defmodule Jirex.GroupLabel do
  @moduledoc """
  Provides struct and type for a GroupLabel
  """

  @type t :: %__MODULE__{text: String.t() | nil, title: String.t() | nil, type: String.t() | nil}

  defstruct [:text, :title, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      text: {:string, :generic},
      title: {:string, :generic},
      type: {:enum, ["ADMIN", "SINGLE", "MULTIPLE"]}
    ]
  end
end
