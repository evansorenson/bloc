defmodule Jirex.AddSecuritySchemeLevelsRequestBean do
  @moduledoc """
  Provides struct and type for a AddSecuritySchemeLevelsRequestBean
  """

  @type t :: %__MODULE__{levels: [Jirex.SecuritySchemeLevelBean.t()] | nil}

  defstruct [:levels]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [levels: [{Jirex.SecuritySchemeLevelBean, :t}]]
  end
end
