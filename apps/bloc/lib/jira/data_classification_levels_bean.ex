defmodule Jira.DataClassificationLevelsBean do
  @moduledoc """
  Provides struct and type for a DataClassificationLevelsBean
  """

  @type t :: %__MODULE__{classifications: [Jira.DataClassificationTagBean.t()] | nil}

  defstruct [:classifications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [classifications: [{Jira.DataClassificationTagBean, :t}]]
  end
end
