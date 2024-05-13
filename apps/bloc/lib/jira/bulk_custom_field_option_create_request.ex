defmodule Jira.BulkCustomFieldOptionCreateRequest do
  @moduledoc """
  Provides struct and type for a BulkCustomFieldOptionCreateRequest
  """

  @type t :: %__MODULE__{options: [Jira.CustomFieldOptionCreate.t()] | nil}

  defstruct [:options]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [options: [{Jira.CustomFieldOptionCreate, :t}]]
  end
end
