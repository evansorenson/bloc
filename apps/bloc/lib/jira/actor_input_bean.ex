defmodule Jira.ActorInputBean do
  @moduledoc """
  Provides struct and type for a ActorInputBean
  """

  @type t :: %__MODULE__{
          group: [String.t()] | nil,
          groupId: [String.t()] | nil,
          user: [String.t()] | nil
        }

  defstruct [:group, :groupId, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [group: [string: :generic], groupId: [string: :generic], user: [string: :generic]]
  end
end
