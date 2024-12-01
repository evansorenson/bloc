defmodule Jirex.UpdateProjectDetails do
  @moduledoc """
  Provides struct and type for a UpdateProjectDetails
  """

  @type t :: %__MODULE__{
          assigneeType: String.t() | nil,
          avatarId: integer | nil,
          categoryId: integer | nil,
          description: String.t() | nil,
          issueSecurityScheme: integer | nil,
          key: String.t() | nil,
          lead: String.t() | nil,
          leadAccountId: String.t() | nil,
          name: String.t() | nil,
          notificationScheme: integer | nil,
          permissionScheme: integer | nil,
          url: String.t() | nil
        }

  defstruct [
    :assigneeType,
    :avatarId,
    :categoryId,
    :description,
    :issueSecurityScheme,
    :key,
    :lead,
    :leadAccountId,
    :name,
    :notificationScheme,
    :permissionScheme,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assigneeType: {:enum, ["PROJECT_LEAD", "UNASSIGNED"]},
      avatarId: :integer,
      categoryId: :integer,
      description: {:string, :generic},
      issueSecurityScheme: :integer,
      key: {:string, :generic},
      lead: {:string, :generic},
      leadAccountId: {:string, :generic},
      name: {:string, :generic},
      notificationScheme: :integer,
      permissionScheme: :integer,
      url: {:string, :generic}
    ]
  end
end
