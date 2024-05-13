defmodule Jira.DefaultShareScope do
  @moduledoc """
  Provides struct and type for a DefaultShareScope
  """

  @type t :: %__MODULE__{scope: String.t()}

  defstruct [:scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [scope: {:enum, ["GLOBAL", "AUTHENTICATED", "PRIVATE"]}]
  end
end
