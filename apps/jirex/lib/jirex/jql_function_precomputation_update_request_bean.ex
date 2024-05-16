defmodule Jirex.JqlFunctionPrecomputationUpdateRequestBean do
  @moduledoc """
  Provides struct and type for a JqlFunctionPrecomputationUpdateRequestBean
  """

  @type t :: %__MODULE__{values: [Jirex.JqlFunctionPrecomputationUpdateBean.t()] | nil}

  defstruct [:values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [values: [{Jirex.JqlFunctionPrecomputationUpdateBean, :t}]]
  end
end
