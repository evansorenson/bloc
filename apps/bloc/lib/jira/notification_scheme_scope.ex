defmodule Jira.NotificationSchemeScope do
  @moduledoc """
  Provides struct and type for a NotificationSchemeScope
  """

  @type t :: %__MODULE__{project: map | nil, type: String.t() | nil}

  defstruct [:project, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [project: :map, type: {:enum, ["PROJECT", "TEMPLATE"]}]
  end
end
