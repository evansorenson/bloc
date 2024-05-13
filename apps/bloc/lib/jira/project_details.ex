defmodule Jira.ProjectDetails do
  @moduledoc """
  Provides struct and type for a ProjectDetails
  """

  @type t :: %__MODULE__{
          avatarUrls: map | nil,
          id: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          projectCategory: map | nil,
          projectTypeKey: String.t() | nil,
          self: String.t() | nil,
          simplified: boolean | nil
        }

  defstruct [:avatarUrls, :id, :key, :name, :projectCategory, :projectTypeKey, :self, :simplified]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatarUrls: :map,
      id: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      projectCategory: :map,
      projectTypeKey: {:enum, ["software", "service_desk", "business"]},
      self: {:string, :generic},
      simplified: :boolean
    ]
  end
end
