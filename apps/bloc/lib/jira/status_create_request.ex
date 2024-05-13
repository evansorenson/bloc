defmodule Jira.StatusCreateRequest do
  @moduledoc """
  Provides struct and type for a StatusCreateRequest
  """

  @type t :: %__MODULE__{scope: Jira.StatusScope.t(), statuses: [Jira.StatusCreate.t()]}

  defstruct [:scope, :statuses]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [scope: {Jira.StatusScope, :t}, statuses: [{Jira.StatusCreate, :t}]]
  end
end
