defmodule Jirex.DataClassificationLevelsBean do
  @moduledoc """
  Provides struct and type for a DataClassificationLevelsBean
  """

  @type t :: %__MODULE__{classifications: [Jirex.DataClassificationTagBean.t()] | nil}

  defstruct [:classifications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [classifications: [{Jirex.DataClassificationTagBean, :t}]]
  end
end
