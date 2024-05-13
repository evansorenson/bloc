defmodule Jira.SystemAvatars do
  @moduledoc """
  Provides struct and type for a SystemAvatars
  """

  @type t :: %__MODULE__{system: [Jira.Avatar.t()] | nil}

  defstruct [:system]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [system: [{Jira.Avatar, :t}]]
  end
end
