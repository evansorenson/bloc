defmodule Jirex.NotificationSchemeAndProjectMappingJsonBean do
  @moduledoc """
  Provides struct and type for a NotificationSchemeAndProjectMappingJsonBean
  """

  @type t :: %__MODULE__{notificationSchemeId: String.t() | nil, projectId: String.t() | nil}

  defstruct [:notificationSchemeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [notificationSchemeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
